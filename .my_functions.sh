# Funções
wait_deploy() {
  until (curl -s $1 | grep $2) do; sleep 2 && echo 'Esperando Nova Versão'; done && echo 'Fez deploy'
}

top_big_files() {
  du -hsx * | sort -rh | head -$1
}

build_in_jenkins() {
  local current_project=`basename $PWD`
  local current_branch=`git rev-parse --abbrev-ref HEAD`
  local request_url="$JENKINS_URL/job/$current_project/job/$current_branch/build"
  echo "Agendando Build no Jenkins em $request_url"
  curl $request_url
}

semver_tags() {
  # git log --oneline --decorate | grep -Eo '\d+\.\d+\.\d+(-rc\.\d+)*' | cat
  git tag | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+(-rc\.[0-9]+)*' | sort -Vr | cat
}

up_special_semver() {
  local tag=$1
  local semtag_regex="[0-9]+\.[0-9]+\.[0-9]+"
  local base_tag=`echo $tag | sed -nE "s/($semtag_regex)-[a-zA-Z]+.[0-9]+/\1/p"`
  local special=`echo $tag | sed -nE "s/$semtag_regex-([a-zA-Z]+).[0-9]+/\1/p"`
  local special_number=`echo $tag | sed -nE "s/$semtag_regex-[a-zA-Z]+.([0-9]+)/\1/p"`
  echo "$base_tag-$special.$((special_number + 1))"
}

up_patch_semver() {
  local tag=$1
  local semtag_regex="([0-9]+)\.([0-9]+)\.([0-9]+)"
  local major=`echo $tag | sed -nE "s/$semtag_regex/\1/p"`
  local minor=`echo $tag | sed -nE "s/$semtag_regex/\2/p"`
  local patch=`echo $tag | sed -nE "s/$semtag_regex/\3/p"`
  echo "$major.$minor.$((patch + 1))"
}

next_release_candidate() {
  local last_tag=`semver_tags| head -n 1`
  local base_tag=`echo $last_tag | grep -q rc && echo $last_tag || up_patch_semver $last_tag | sed "s/.*/&-rc.0/"`
  echo `up_special_semver $base_tag`
}

tag_next_release_candidate() {
  local tag=`next_release_candidate`
  echo "Tagging $tag"
  git tag $tag
  echo "Pushing to remote"
  git push --tags && git push
}

deploy_qa() {
  echo "Fetching"
  git fetch
  echo "Updating with master"
  git merge origin/master

  tag_next_release_candidate
  build_in_jenkins
}


merged_prs_from_last_tag() {
  local result=`git log --oneline --decorate  | grep -B 100 -m 1 "tag:" | grep "pull request" | awk '{print $1}' | xargs git show --format='%b' | grep -v Approved | grep -v "^$" | grep -E "^[[:space:]]*\[.*\]" | sed 's/^[[:space:]]*\(.*\)/ * \1/'`
  echo "$result"
}

# usage: next_changelog 1.1.1
next_changelog() {
  local change_list=`merged_prs_from_last_tag`
  local time=`date +'%d de %B de %Y'`
  local version=$1
  echo "## $version - $time\n$change_list"
}

infer_tag() {
  local last_tag=`semver_tags | grep -Ev 'rc' | head -n 1`

}

last_stable_tag() {
  semver_tags | grep -v 'rc' | head -n 1
}
# TODO: infer the next tag if none is passed
# TODO: infer the changelog filename
# usage: update_changelog 1.2.3
update_changelog() {
  local changelog=`next_changelog $1`
  echo "Diff Release"
  echo "---------------------------"
  echo $changelog
  echo "---------------------------"
  echo "Type Enter to continue or CTRL-C to cancel"
  read
  echo "Updating Changelog"
  { echo -n "$changelog" ; echo; echo; cat CHANGELOG.md; } > CHANGELOG.temp
  mv CHANGELOG.temp CHANGELOG.md
}

choose_version() {
  clear
  echo 'Diff from last tag'
  echo "---------------------------"
  echo `merged_prs_from_last_tag ${last_stable_tag}`
  echo "---------------------------"
  echo "Select the version number to increment:"
  echo "1. Major"
  echo "2. Minor"
  echo "3. Patch"
  read opt
  case $opt in
    1)
      echo "major"
      ;;
    2)
      echo "minor"
      ;;
    3)
      echo "patch"
      ;;
  esac
}

deploy_prod() {
  echo "Fetching"
  git fetch
  echo "Checkout to master"
  git checkout master
  echo "Updating master"
  git pull
  update_changelog $1
  git add CHANGELOG.md
  git commit -m 'Updates CHANGELOG.md'
  git tag $1
  git push --tags && git push
  # TODO: Add build to Jenkins
}


start_http_for_current_folder(){
  local port=${1:-8000}
  ruby -rwebrick -e "WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd).start"
}

# Attach in a running container of compose
dcm_attach_to() {
 local container=`docker-compose ps | grep $1 | awk '{print $1}' | head -n 1`
 docker attach $container
}

