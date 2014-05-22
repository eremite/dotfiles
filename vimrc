" https://github.com/Shougo/neobundle.vim
" :NeoBundleUpdatesLog - list recent changes.
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" Configure NeoBundle
let g:neobundle#types#git#default_protocol = 'git'

NeoBundleFetch 'Shougo/neobundle.vim'

" General
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'matchit.zip'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'tommcdo/vim-exchange'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-vinegar'

" Text objects
NeoBundle 'Julian/vim-textobj-variable-segment'
NeoBundle 'glts/vim-textobj-comment'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'sgur/vim-textobj-parameter'

" Languages/frameworks
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'php.vim'
NeoBundle 'php.vim-html-enhanced'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'ekalinin/Dockerfile.vim'

" Unite
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite.vim'

" Linux never crashes. :)
set noswapfile
" Autosave when changing buffers (the warnings get annoying)
set autowriteall

" Set Leader
" \ is too far away!
let mapleader = "'"

" FileTypes
filetype on
filetype indent on
filetype plugin on
" Makefiles need literal tabs
autocmd FileType make setlocal noexpandtab
" Special ruby files
autocmd BufRead,BufNewFile *.jbuilder set filetype=ruby
autocmd BufRead,BufNewFile *.rabl set filetype=ruby
" Don't assume the line after a comment is still a comment
autocmd FileType ruby setlocal formatoptions-=cro
autocmd FileType yaml setlocal formatoptions-=cro
" 4 spaces for python indentation
autocmd BufRead *.py set ts=4 et sw=4 sts=4
autocmd FileType php set sw=2
" Remove fugitive buffers (from browsing git objects)
" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database
autocmd BufReadPost fugitive://* set bufhidden=delete

" Tabs and indentation
" Default to 2 spaces (ruby FTW)
set backspace=start,indent,eol
set tabstop=2
set softtabstop=2
set shiftwidth=2
retab
set expandtab

" Colors
syntax enable
set background=dark
colorscheme solarized
set t_Co=256

" Color Customizations
syntax on
set nohlsearch
highlight MatchParen ctermbg=4
set synmaxcol=1024 " Give up on uberlong lines
" Vimdiff
highlight DiffAdd cterm=underline ctermbg=Black ctermfg=2
highlight DiffChange cterm=underline ctermbg=Black ctermfg=4
highlight DiffText cterm=underline ctermbg=4 ctermfg=0
highlight DiffDelete cterm=underline ctermbg=Black ctermfg=1
" Spelling
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" Highlight 81st column to discourage long lines.
set colorcolumn=81

" Remember last location in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Ignore the following
set wildignore+=.git,*.jpg,*.png,*.zip,*.tar.gz,.DS_Store,tmp/**

" Ignore case for fast-typed commands.
command Q q
command W w
command WQ wq
command Wq wq

" Copy to the end of the line (https://github.com/tpope/tpope/blob/master/.vimrc)
nnoremap Y y$

" Insert just one character
nnoremap <space> :exec "normal i".nr2char(getchar())."\e"<CR>

" Search in a visual range
" http://www.vim.org/tips/tip.php?tip_id=796
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" Enable undo for CTRL-u and backspace
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Use motion commands to leave insert mode
" http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim
imap jk <esc>
imap jj <esc>j
imap kk <esc>k

" Map autocomplete to tab
" https://github.com/ryanb/dotfiles/blob/master/vimrc
imap <Tab> <C-P>
imap <S-Tab> <C-N>

" Abbreviations
ab pa params

" Open [a]ny file with Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>a :<C-u>Unite -buffer-name=files -start-insert file_rec<CR>
" Switch to open [b]uffer with Unite
nnoremap <leader>b :<C-u>Unite -buffer-name=buffer -start-insert buffer<CR>
" Open file in current [d]irectory
" http://vimcasts.org/episodes/the-edit-command
map <leader>d :e %:p:h/
" [E]dit
noremap <Leader>e :e<Space>
" [F]lip to alternate buffers
noremap <Leader>f :e #<CR>
" Git Grep (G[g]rep) the selection
vnoremap <Leader>g y:Ggrep '<C-r>"'<CR>
" Git Grep (G[g]rep) the word under the cursor
nnoremap <Leader>g :Ggrep <C-r><C-w><CR>
" Change string to a symbol (like ruby's [i]ntern method)
nnoremap <Leader>i 2f'xF'xi:<ESC>
nnoremap <Leader>I 2f"xF"xi:<ESC>
" Convert a three line tag or block to one line. (an overpowered [J])
noremap <Leader>j maJxJx`a
" [M]ulti-line an array or hash
noremap <Leader>m ma:s/, \?/,<c-v><CR>/g<CR>j=`a
" Edit [N]otes file
noremap <Leader>n :e gitignore/notes.md<CR>
" [O]rganize alphabetically (sort)
noremap <Leader>o :sort<CR>
" [Q]uit
noremap <Leader>q :quit<CR>
" [R]emove smart quotes (and friends).
noremap <Leader>R ma:%s/[“”]/"/eg<CR>:%s/’/'/eg<CR>`a
" [S]ave
noremap <Leader>s :write<CR>
" Show ou[t]line
nnoremap <leader>t :<C-u>Unite -buffer-name=outline -start-insert outline<CR>
" Open most recently [u]sed files.
call unite#custom#source('file_mru', 'matchers', ['matcher_project_files', 'matcher_fuzzy'])
noremap <leader>u :<C-u>Unite file_mru<CR>
" [y]ank history
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<CR>
" E[x]it current Buffer
noremap <Leader>x :bd<CR>

" Configure surround
" https://github.com/tpope/vim-surround
" Re-indent (=) after surrounding
let b:surround_indent = 1
" -
autocmd FileType php,html let b:surround_45 = "<?php \r ?>"
" # - #{}
autocmd FileType ruby,eruby,haml let g:surround_35 = "#{\r}"
" c - code block
autocmd FileType markdown let b:surround_99 = "```ruby\n\r\n```"
" d - debug
autocmd FileType ruby let b:surround_100 = "logger.debug(\"### #{\r}\") #TODO: remove debug code"
autocmd FileType javascript let g:surround_100 = "console.log(\r); // TODO Remove debug code"
autocmd FileType unite DisableWhitespace
" t - try
let g:surround_116 = "try(:\r)"
" v - variable
let g:surround_118 = "\"#{\r}\""

" Configure vim-ruby
" https://github.com/vim-ruby/vim-ruby
let g:ruby_hanging_indent = 0

" Configure vim-markdown
let g:markdown_fenced_languages = ['ruby', 'javascript']

" Extend fugitive
cmap Gwc :Git whatchanged -p --abbrev-commit --pretty=medium %

" Configure unite
" http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

" Unite <3 Rails
command Umodel Unite -start-insert file_rec:app/models
command Uview Unite -start-insert file_rec:app/views
command Ucontroller Unite -start-insert file_rec:app/controllers

" Load customizations for local machine.
if filereadable(expand("$HOME/.vimrc_local"))
  source $HOME/.vimrc_local
endif

NeoBundleCheck
