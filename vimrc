" vimrc

" Tabs and indentation
filetype indent on
set backspace=start,indent,eol
set shiftwidth=2
set tabstop=2
retab
set expandtab
let b:surround_indent = 1
au FileType make setlocal noexpandtab

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

" Highlight spaces at the end of lines.
highlight link localWhitespaceError Error
au Syntax * syn match localWhitespaceError /\(\zs\%#\|\s\)\+$/ display

"http://vim.wikia.com/wiki/VimTip1269 add indent level as text-object
onoremap <silent>ai :<C-u>cal IndTxtObj(0)<CR>
onoremap <silent>ii :<C-u>cal IndTxtObj(1)<CR>
vnoremap <silent>ai :<C-u>cal IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii :<C-u>cal IndTxtObj(1)<CR><Esc>gv
function! IndTxtObj(inner)
  let curline = line(".")
  let lastline = line("$")
  let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
  let i = i < 0 ? 0 : i
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      -
      let p = line(".") - 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! 0V
    call cursor(curline, 0)
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      +
      let p = line(".") + 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! $
  endif
endfunction

" My own (semi-lame) text-object for commas
onoremap <silent>a, :<C-u>silent! normal! F,vt,<CR>
onoremap <silent>i, :<C-u>silent! normal! T,vf,<CR>
vnoremap <silent>a, :<C-u>silent! normal! F,vt,<CR><Esc>gv
vnoremap <silent>i, :<C-u>silent! normal! T,vf,<CR><Esc>gv

" Search in a visual range: http://www.vim.org/tips/tip.php?tip_id=796
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" Inserting just one thing
nnoremap <cr> o<esc>
nnoremap - O<esc>
nnoremap + i<cr><esc>
nnoremap <space> :exec "normal i".nr2char(getchar())."\e"<CR>

" Quitting quickly
command Q q
command W w
command WQ wq
command Wq wq

" Filetypes
" au BufRead,BufNewFile *.html set filetype=php
au BufRead,BufNewFile *.htm set filetype=php 
au BufRead,BufNewFile *.php set filetype=php 
au BufRead,BufNewFile *.haml set filetype=haml 
au FileType ruby setlocal formatoptions-=cro
au FileType yaml setlocal formatoptions-=cro

" For CTRL-^ in particular
set autowrite

" Easy Grep Defaults
let g:EasyGrepFileAssociations='/home/daniel/.vim/plugin/EasyGrepFileAssociations'
let g:EasyGrepMode=2
let g:EasyGrepCommand=0
let g:EasyGrepRecursive=1
let g:EasyGrepIgnoreCase=0
let g:EasyGrepHidden=0
let g:EasyGrepAllOptionsInExplorer=1
let g:EasyGrepWindow=0
let g:EasyGrepOpenWindowOnMatch=0
let g:EasyGrepEveryMatch=0
let g:EasyGrepJumpToMatch=0
let g:EasyGrepInvertWholeWord=0
let g:EasyGrepFileAssociationsInExplorer=1
let g:EasyGrepOptionPrefix='<leader>vy'
let g:EasyGrepReplaceWindowMode=0
let g:EasyGrepReplaceAllPerFile=0

" Rails
let g:rails_syntax=1

" Enable undo for CTRL-u and backspace
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Vimdiff shortcuts
nmap do do]c
nmap dp dp]c

" Surrounds
"-
autocmd FileType php let b:surround_45 = "<?php \r ?>"
autocmd FileType html let b:surround_45 = "<?php \r ?>"
"1
let g:surround_49 = "<!-- \r -->"
"!
let g:surround_33 = "<!-- \r -->"
"\
let g:surround_92 = "\n\r\n"
"#
let g:surround_35 = "#{\r}"
"d
let g:surround_100 = "logger.debug(\"###\\n### #{\r}\\n###\") #TODO: remove debug code"
"s
let g:surround_115 = "logger.debug(\"### #{\r}\") #TODO: remove debug code"
"t
let g:surround_116 = "t '\r'"
"u
let g:surround_117 = "t('\r')"
"v
let g:surround_118 = "\"#{\r}\""
"|
let g:surround_124 = "{{\r}}"

" http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim
imap jj <esc>j
imap kk <esc>k

"http://github.com/fabiokung/vimfiles/tree
let g:browser = 'firefox -new-tab '
" Open the Ruby ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/'.a:keyword
  exec '!'.g:browser.' '.url.' &'
endfunction
noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>
" Open the Rails ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/'.a:keyword
  exec '!'.g:browser.' '.url.' &'
endfunction
noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>

" Function keys
map <F4> :w<CR>:cn<CR>
map <F6> :set paste!<CR>
map <F7> :silent setlocal invspell<CR>
map <F8> ]czz
map <F11> :wqa<CR>
map <F12> :1,$+1diffget<CR>:wqa<CR>

let mapleader = "'"
