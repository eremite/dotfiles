" Pathogen
call pathogen#incubate()
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
" Swa[p] selection and previous deletion
" http://vim.wikia.com/wiki/VimTip47#Visual-mode_swapping
vnoremap <Leader>p <Esc>`.``gvP``P
" [Q]uit
noremap <Leader>q :quit<CR>
" [R]emove end of line white space.
noremap <Leader>r ma:%s/\s\+$//e<CR>`a
" [R]emove smart quotes (and friends).
noremap <Leader>R ma:%s/[“”]/"/eg<CR>:%s/’/'/eg<CR>`a
" [S]ave
noremap <Leader>s :write<CR>
" Go to [t]ag in tagbar
noremap <Leader>t :TagbarOpenAutoClose<CR>
" Open most recently [u]sed files with CtrlP fuzzy finding.
noremap <Leader>u :CtrlPMRU<CR>
" E[x]it current Buffer
noremap <Leader>x :bd<CR>

" Configure tagbar
let g:tagbar_compact = 1

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

" Load customizations for local machine.
if filereadable(expand("$HOME/.vimrc_local"))
  source $HOME/.vimrc_local
endif
