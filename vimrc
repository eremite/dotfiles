" Pathogen
" http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen
" To install a new plugin
"   git submodule add git://github.com/user/plugin vim/bundle/plugin
"   git submodule init
" To update all submodules:
"   git submodule update --init
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


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
" .prawn files are just ruby
autocmd BufRead,BufNewFile *.prawn set filetype=ruby
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

" Highlight spaces at the end of lines
highlight link localWhitespaceError Error
autocmd Syntax * syn match localWhitespaceError /\(\zs\%#\|\s\)\+$/ display

" Highlight 81st column to discourage long lines.
set colorcolumn=81

" Remember last location in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Reminder of how to use the mouse without gui-vim! (I never do though)
" set mouse=a

" Ignore the following
set wildignore+=.git,*.jpg,*.png,*.zip,*.tar.gz,.DS_Store,tmp/**


" Ignore case for fast-typed commands.
command Q q
command W w
command WQ wq
command Wq wq

" Insert just one character
nnoremap <space> :exec "normal i".nr2char(getchar())."\e"<CR>

" Search in a visual range
" http://www.vim.org/tips/tip.php?tip_id=796
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" Enable undo for CTRL-u and backspace
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Go to next change after getting/putting in a Vimdiff
nmap do do]c
nmap dp dp]c

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

" My own (semi-lame) text-object for commas
onoremap <silent>a, :<C-u>silent! normal! F,vt,<CR>
onoremap <silent>i, :<C-u>silent! normal! T,vf,<CR>
vnoremap <silent>a, :<C-u>silent! normal! F,vt,<CR><Esc>gv
vnoremap <silent>i, :<C-u>silent! normal! T,vf,<CR><Esc>gv

" Open [a]ny file with CtrlP fuzzy finding.
noremap <Leader>a :CtrlP<CR>
" Switch to open [b]uffer with CtrlP fuzzy finding.
noremap <Leader>b :CtrlPBuffer<CR>
" Open file in current [d]irectory
" http://vimcasts.org/episodes/the-edit-command
map <leader>d :e %:p:h/
" [E]dit
noremap <Leader>e :e<Space>
" [F]lip to alternate buffers
noremap <Leader>f :w<CR>:e #<CR>
" [G]o to tag in tagbar
noremap <Leader>G :TagbarOpenAutoClose<CR>
" Git Grep (G[g]rep) the selection
vnoremap <Leader>g y:Ggrep '<C-r>"'<CR>
" Git Grep (G[g]rep) the word under the cursor
nnoremap <Leader>g :Ggrep <C-r><C-w><CR>
" Convert a three line tag or block to one line. (an overpowered [J])
noremap <Leader>j maJxJx`a
" Toggle Spelling
noremap <Leader>k :silent setlocal invspell<CR>
" [M]ulti-line an array or hash
noremap <Leader>m ma:s/, \?/,<c-v><CR>/g<CR>j=`a
" [O]rganize alphabetically (sort)
noremap <Leader>o :sort<CR>
" [Q]uit
noremap <Leader>q :quit<CR>
" [R]emove end of line white space.
noremap <Leader>r ma:%s/\s\+$//e<CR>`a
" [R]emove smart quotes (and friends).
noremap <Leader>R ma:%s/[“”]/"/eg<CR>:%s/’/'/eg<CR>`a
" [S]ave
noremap <Leader>s :write<CR>
" Open most recently [u]sed files with CtrlP fuzzy finding.
noremap <Leader>u :CtrlPMRU<CR>
" E[x]it current Buffer
noremap <Leader>x :bd<CR>

" Cycle through quickfix without saving buffers
nmap <silent> [p :bd\|cprevious<CR>
nmap <silent> ]p :bd\|cnext<CR>


" Configure tagbar
let g:tagbar_compact = 1

" Configure surround
" https://github.com/tpope/vim-surround
" Re-indent (=) after surrounding
let b:surround_indent = 1
" -
autocmd FileType php,html let b:surround_45 = "<?php \r ?>"
" \ \n
let g:surround_92 = "\n\r\n"
" # #{}
autocmd FileType ruby,eruby,haml let g:surround_35 = "#{\r}"
" d
autocmd FileType ruby let b:surround_100 = "logger.debug(\"### #{\r}\") #TODO: remove debug code"
autocmd FileType javascript let g:surround_100 = "console.log(\r); // TODO Remove debug code"
" t try
let g:surround_116 = "try(:\r)"
" v variable
let g:surround_118 = "\"#{\r}\""

" Configure vim-ruby
" https://github.com/vim-ruby/vim-ruby
let g:ruby_hanging_indent = 0

" Extend fugitive
cmap Gwc :Git whatchanged -p --abbrev-commit --pretty=medium %

" Load customizations for local machine.
if filereadable(expand("$HOME/.vimrc_local"))
  source $HOME/.vimrc_local
endif

" Add statusline
set statusline=%1*%<%=%f\ %h%m%r\ %-8.(%l,%c%V%)\ %P
set laststatus=2
