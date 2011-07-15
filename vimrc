" Pathogen
" (http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen)
" To update all submodules:
"   git submodule update --init
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

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
" Autocomplete question? methods (http://stackoverflow.com/questions/4258955)
autocmd FileType ruby setlocal iskeyword+=?
" 4 spaces for python indentation
autocmd BufRead *.py set ts=4 et sw=4 sts=4
" Remove fugitive buffers (from browsing git objects)
" (http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database)
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
set t_Co=256
colorscheme desert256
syntax on
set nohlsearch
highlight MatchParen ctermbg=4
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

" Autosave when changing buffers (the warnings get annoying)
set autowriteall

" Remember last location in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Reminder of how to use the mouse without gui-vim! (I never do though)
" set mouse=a


" Command-T (http://git.wincent.com/command-t.git)
" Close the buffer with <Esc>
let g:CommandTCancelMap='<Esc>'


" Supertab (https://github.com/ervandew/supertab)
" The CR mapping sometimes conflicts with other plugins.
let g:SuperTabCrMapping = 0
" Always use default completion type
let g:SuperTabRetainCompletionDuration='completion'


" Surround (https://github.com/tpope/vim-surround)
" Re-indent (=) after surrounding
let b:surround_indent = 1
"-
autocmd FileType php let b:surround_45 = "<?php \r ?>"
autocmd FileType html let b:surround_45 = "<?php \r ?>"
"!
let g:surround_33 = "<!-- \r -->"
"1
let g:surround_49 = "<!-- \r -->"
"\ \n
let g:surround_92 = "\n\r\n"
"# #{}
let g:surround_35 = "#{\r}"
"d
autocmd FileType ruby let b:surround_100 = "logger.debug(\"### #{\r}\") #TODO: remove debug code"
autocmd FileType javascript let g:surround_100 = "console.log(\r); // TODO Remove debug code"
"t try
let g:surround_116 = "try(:\r)"
"v variable
let g:surround_118 = "\"#{\r}\""


" Custom Mappings

" Ignore case when saving and quitting
command Q q
command W w
command WQ wq
command Wq wq

" Insert just one character
nnoremap <space> :exec "normal i".nr2char(getchar())."\e"<CR>

" Search in a visual range: http://www.vim.org/tips/tip.php?tip_id=796
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" Enable undo for CTRL-u and backspace
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Go to next change after getting/putting in a Vimdiff
nmap do do]c
nmap dp dp]c

" Use motion commands to leave insert mode
" (http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim)
imap jj <esc>j
imap kk <esc>k

" My own (semi-lame) text-object for commas
onoremap <silent>a, :<C-u>silent! normal! F,vt,<CR>
onoremap <silent>i, :<C-u>silent! normal! T,vf,<CR>
vnoremap <silent>a, :<C-u>silent! normal! F,vt,<CR><Esc>gv
vnoremap <silent>i, :<C-u>silent! normal! T,vf,<CR><Esc>gv

" Handy for one-lining a three line tag or block
noremap <Leader>j maJxJx`a
" Remove end of line white space.
noremap <Leader>r ma:%s/\s\+$//e<CR>`a
" Remove smart quotes (and friends).
noremap <Leader>R ma:%s/[“”]/"/eg<CR>:%s/’/'/eg<CR>`a
" Save
noremap <Leader>s :write<CR>
" Write
noremap <Leader>w :write<CR>
" Quit
noremap <Leader>q :quit<CR>
" Edit
noremap <Leader>e :e<Space>
" Flip to alternate buffers
noremap <Leader>f :w<CR>:e #<CR>
" CLIPBOARD ("+ is awkward)
noremap <Leader>c "+
" PRIMARY ("* is awkward)
noremap <Leader>C "*
" Toggle Spelling
noremap <Leader>k :silent setlocal invspell<CR>
" multi-line an array or hash
noremap <Leader>m ma:s/, \?/,<c-v><CR>/g<CR>j=`a
" Open file in current directory (http://vimcasts.org/episodes/the-edit-command)
map <leader>d :e %:p:h/
" Close current Buffer
noremap <Leader>x :bd<CR>
