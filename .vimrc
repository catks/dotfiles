set runtimepath^=~/.vim/bundle/ctrlp.vim
runtime macros/matchit.vim

call plug#begin('~/.vim/plugged')
Plug 'vim-syntastic/syntastic'
Plug 'bling/vim-airline'

Plug 'jordwalke/flatlandia'
Plug 'jpo/vim-railscasts-theme'
Plug 'nightsense/snow'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'skreek/skeletor.vim'
Plug 'brooth/far.vim'

Plug 'martinda/Jenkinsfile-vim-syntax'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/AutoComplPop'
Plug 'markonm/traces.vim'
Plug 'rakr/vim-one'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterEnable' }
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'wincent/command-t'
Plug 'airblade/vim-rooter'
Plug 'kylef/apiblueprint.vim'
" Ruby
Plug 'ngmy/vim-rubocop'

Plug 'ngmy/vim-rubocop'
" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Lint
Plug 'w0rp/ale'
"
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-session'
Plug 'tpope/vim-fugitive'


Plug 'kchmck/vim-coffee-script'
call plug#end()

" Airline Config
"let laststatus=2
"set ttimeoutlen=50
"
"set termguicolors
"
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme lucario

" Seta a pasta raiz com projetos do git
let g:rooter_patterns = ['.git/']

let g:has_async = v:version >= 800 || has('nvim')
" hi LineNr       term=bold cterm=bold ctermfg=2

set nobackup
set nowritebackup
set noswapfile

"No noise
set visualbell
" Corrige Backspace no Mac
set backspace=indent,eol,start

" Automatically :write before running commands
" set autowrite
" Automatically update a file if it is changed externally
set autoread

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" GitGutter
set signcolumn="yes"

let mapleader = ","

" Easy Motion
map <Leader>m <Plug>(easymotion-prefix)

nnoremap <Leader>w :w <CR>
nnoremap <Leader>q :q <CR>
nnoremap <Leader>x :x <CR>
nnoremap <Leader>b :Buffers <CR>
nnoremap <Leader>pf <Ctrl-p>
nnoremap <Leader><Leader> :b# <CR>
nnoremap <Leader>du :!docker-compose up -d <CR>
nnoremap <Leader>des :!docker-compose exec app sh <CR>
nnoremap <Leader>\ :vsp <CR>
nnoremap <Leader>- :sp <CR>
nnoremap <Leader>. :winc w <CR>
nnoremap <Leader>vd :GitGutterEnable <CR>

"Searchs with CtrlSF
nnoremap <Leader>f :CtrlSF <CR>
noremap <expr> <Leader>F ':CtrlSF ' . expand('<cword>')

" Searchs with Ag
noremap <Leader>sp :Ag<space>
noremap <expr> <Leader>sP ':Ag ' . expand('<cword>')

" Search current file
nnoremap <expr> <Leader>/ '/ ' . expand('<cword>')

"nnoremap <Leader>s :%s/\<<C-r><C-w>\>/


" Move uma linhas ou blocos selecionados para cima ou para baixo
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

"Limpa o highlight da pesquisa ao apertar a tecla
nnoremap <silent><Enter> :noh<CR>

" Open file explorer
nnoremap <Leader>ff :Explore <CR>
" Create file in current folder
nnoremap <Leader>fc :e %:h/
" Search current word
nnoremap <expr> <Leader>/ '/' . expand('<cword>')

" Format entire file
nnoremap <Leader>= ggvG=

""Comandos
command! Rspec execute "!rspec %"
command! DRspec execute "!docker-compose exec app rspec %"
command! ReloadVimRC execute ":so $MYVIMRC"
command! ReloadAndInstall execute ":so $MYVIMRC | PlugInstall"
command! DeleteTrailingSpaces execute "keeppatterns %s/\\s\\+$//e"
command! GitDiff execute "set splitbelow | new | setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number | r!git diff"
command! GitDiffStaged execute "set splitbelow | new | setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number | r!git diff --cached"

" fzf

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
command! ProjectAg execute 'Ag' s:find_git_root()
" Adicona "" no texto selecionado
"vnoremap <Leader>" c"<c-r>""
"
"


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" if executable('ag')
"   " Use Ag over Grep
"   set grepprg=ag\ --nogroup\ --nocolor
"   " Use ag in CtrlP for listing files. Lightning fast and respects
"   "       .gitignore
"   let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
"   let g:ctrlp_user_command =
"         \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
" endif
" "   " Default to filename searches
" let g:ctrlp_by_filename = 1
" Indentação
"
set expandtab
set shiftwidth=2
set softtabstop=2

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Copia tudo para o clipboard
set clipboard=unnamed

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Muda o diretório de acordo com o arquivo
set autochdir

" Permite trocar de buffer sem salvar
set hidden

" Mostra espaços indesejados
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" TODO: Criar uma função para setar os espaços em branco
autocmd! BufWinEnter *  match ExtraWhitespace /\s\+$/
autocmd! InsertEnter *  call clearmatches()
autocmd! InsertLeave *  match ExtraWhitespace /\s\+$/
autocmd! BufWinLeave * call clearmatches()
"match ExtraWhitespace /\s\+$\| \+\ze\t/
"match ExtraWhitespace /[^\t]\zs\t\+/

augroup Mkdir
  autocmd!
  autocmd BufWritePre *
        \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
        \ endif
augroup END

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

  " ALE linting events
  " if g:has_async
  "   set updatetime=1000
  "   let g:ale_lint_on_text_changed = 0
  "   autocmd CursorHold * call ale#Lint()
  "   autocmd CursorHoldI * call ale#Lint()
  "   autocmd InsertEnter * call ale#Lint()
  "   autocmd InsertLeave * call ale#Lint()
  " else
  "   echoerr "The thoughtbot dotfiles require NeoVim or Vim 8"
  " endif
augroup END

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:CommandTWildIgnore=&wildignore . ",*/node_modules"
