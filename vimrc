"256 Colors
set t_Co=256

colorscheme desert256

syntax on

set nohlsearch

filetype indent on

" Fix tabs
set backspace=start,indent,eol
au FileType make setlocal noexpandtab

set shiftwidth=2
set tabstop=2
retab
set expandtab
let b:surround_indent = 1

let g:rails_syntax=1
"vnoremap <C-X> <Esc>`.``gvP``P

"Search in a visual range: http://www.vim.org/tips/tip.php?tip_id=796
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

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

" My own (semi-lame) text-object for underscored_words
onoremap <silent>a_ :<C-u>silent! normal! T_vf_<CR>
onoremap <silent>i_ :<C-u>silent! normal! T_vt_<CR>
vnoremap <silent>a_ :<C-u>silent! normal! T_vf_<CR><Esc>gv
vnoremap <silent>i_ :<C-u>silent! normal! T_vt_<CR><Esc>gv

"save register between sessions
"http://www.oreillynet.com/mac/blog/2006/07/more_vim_save_time_with_macros_1.html
":set viminfo=%,'50,\"100,n~/.viminfo 

command Q q
command W w
command WQ wq
command Wq wq

au BufRead,BufNewFile *.html set filetype=php 
au BufRead,BufNewFile *.htm set filetype=php 
au BufRead,BufNewFile *.php set filetype=php 

"http://www.vim.org/scripts/script.php?script_id=13
au Filetype html,xml,xsl,eruby source ~/.vim/scripts/closetag.vim

"set surround for #
let g:surround_35 = "#{\r}"
"set surround for d
let g:surround_100 = "logger.debug(\"###\\n### #{\r}\\n###\") #TODO: remove debug code"
let g:surround_115 = "logger.debug(\"### #{\r}\") #TODO: remove debug code"

"set surround for - in php files
autocmd FileType php let b:surround_45 = "<?php \r ?>"
autocmd FileType html let b:surround_45 = "<?php \r ?>"
autocmd FileType html let b:surround_61 = "<?php echo \r; ?>"
autocmd FileType php let b:surround_103 = "$_GET[\"\r\"]"
autocmd FileType php let b:surround_112 = "$_POST[\"\r\"]"
autocmd FileType php let b:surround_114 = "$row[\"\r\"]"
autocmd FileType js let b:surround_42 = "/*\r*/"
autocmd FileType css let b:surround_42 = "/*\r*/"

"set surround for ?
let g:surround_63 = "<? \r ?>"
"set surround for 1 and !
let g:surround_49 = "<!-- \r -->"
let g:surround_33 = "<!-- \r -->"
"set surround for \
let g:surround_92 = "\n\r\n"

inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
nnoremap <cr> o<esc>
nnoremap - O<esc>
nnoremap + i<cr><esc>
nnoremap <space> :exec "normal i".nr2char(getchar())."\e"<CR>

map <F2> :s/^/#/e<CR>
map <F3> :s/^\s*#/\1/e<CR>
map <F4> :w<CR>:cn<CR>
map <F6> :set paste!<CR>
map <F7> :silent setlocal invspell<CR>
map <F8> ]czz
map <F11> :wqa<CR>
map <F12> :1,$+1diffget<CR>:wqa<CR>

":setlocal spell spelllang=en_us
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

" Vimdiff preferences
highlight DiffAdd cterm=underline ctermbg=Black ctermfg=2
highlight DiffChange cterm=underline ctermbg=Black ctermfg=4
highlight DiffText cterm=underline ctermbg=4 ctermfg=0
highlight DiffDelete cterm=underline ctermbg=Black ctermfg=1
nmap do do]c
nmap dp dp]c

set fo-=c
set fo-=o
set fo-=r

