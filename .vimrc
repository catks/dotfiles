set runtimepath^=~/.vim/bundle/ctrlp.vim
runtime macros/matchit.vim

call plug#begin('~/.vim/plugged')
Plug 'nightsense/snow'
Plug 'bling/vim-airline'
Plug 'jordwalke/flatlandia'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/AutoComplPop'
Plug 'markonm/traces.vim'
Plug 'rakr/vim-one'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'ngmy/vim-rubocop'
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterEnable' }
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
call plug#end()

" Airline Config
"let laststatus=2
"set ttimeoutlen=50
"
colorscheme flatlandia
set backspace=indent,eol,start
hi LineNr       term=bold cterm=bold ctermfg=2


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

" Move uma linhas ou blocos selecionados para cima ou para baixo
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Limpa o highlight da pesquisa ao apertar ESC
nnoremap <silent><esc> :noh<CR>
nnoremap <esc>[ <esc>[

""Comandos
command! Rspec execute "!rspec %"
command! DRspec execute "!docker-compose exec app rspec %"
command! ReloadVimRC execute ":so $MYVIMRC"
command! ReloadAndInstall execute ":so $MYVIMRC | PlugInstall"
command! DeleteTrailingSpaces execute "keeppatterns %s/\\s\\+$//e"
command! GitDiff execute "set splitbelow | new | setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number | r!git diff"
command! GitDiffStaged execute "set splitbelow | new | setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number | r!git diff --cached"

" Adicona "" no texto selecionado
"vnoremap <Leader>" c"<c-r>""
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

noh
