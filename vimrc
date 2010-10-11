" Set Leader
let mapleader = "'"

" Linux never crashes. :)
set noswapfile

" Turn on filetype
filetype on
filetype indent on
filetype plugin on

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

" Tabs and indentation
set backspace=start,indent,eol
set tabstop=2
set softtabstop=2
set shiftwidth=2
retab
set expandtab
let b:surround_indent = 1

" Highlight spaces at the end of lines.
highlight link localWhitespaceError Error
autocmd Syntax * syn match localWhitespaceError /\(\zs\%#\|\s\)\+$/ display

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

" Saving and quitting quickly
command Q q
command W w
command WQ wq
command Wq wq
" edit most recent file (searching recursively)
command ER e `find . -type f -not -name *.swp -not -path ./% -printf \"\%TY-\%Tm-\%Td\_\%TT\ \%p\\n\" \| sort \| tail -1 \| awk '{print $NF}'`


" Filetypes
" autocmd BufRead,BufNewFile *.html set filetype=php
" autocmd BufRead,BufNewFile *.htm set filetype=php 
autocmd FileType make setlocal noexpandtab
autocmd BufRead,BufNewFile *.prawn set filetype=ruby
autocmd FileType ruby setlocal formatoptions-=cro
autocmd FileType yaml setlocal formatoptions-=cro

" For CTRL-^ in particular
set autowrite

" Easy Grep Settings
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

" Supertab Settings
let g:SuperTabRetainCompletionType=0

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
"!
let g:surround_33 = "<!-- \r -->"
"1
let g:surround_49 = "<!-- \r -->"
"\ \n
let g:surround_92 = "\n\r\n"
"# #{}
let g:surround_35 = "#{\r}"
"s
let g:surround_115 = "logger.debug(\"### #{\r}\") #TODO: remove debug code"
autocmd FileType javascript let g:surround_115 = "console.log(\r); // TODO Remove debug code"
"t try
let g:surround_116 = "try(:\r)"
"u
" let g:surround_117 = "t('\r')"
"v variable
let g:surround_118 = "\"#{\r}\""

" http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim
imap jj <esc>j
imap kk <esc>k

"http://github.com/fabiokung/vimfiles/tree
let g:browser = 'firefox-3.5 -new-tab '
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

" Git Blame
nnoremap <Leader>gb :GitBlame<Enter>
" Git Checkout
nnoremap <Leader>gco :GitCheckout %<Enter>
" Handy for one-lining a three line tag or block
noremap <Leader>j maJxJx`a
" Remove end of line white space.
noremap <Leader>r ma:%s/\s\+$//e<CR>`a
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
" Toggle paste!
noremap <Leader>p :set paste!<CR>
" search for TODO
noremap <Leader>t /\<TODO\><CR>
" multi-line an array or hash
noremap <Leader>m ma:s/, /,<c-v><CR>/g<CR>j=`a
" Open file in current directory <http://vimcasts.org/episodes/the-edit-command>
map <leader>d :e %:p:h/

" You can use the mouse without gui-vim!
" y would you want to though? :)
" wka's comment on http://vimcasts.org/episodes/working-with-windows
" http://vim.wikia.com/wiki/Managing_set_options
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
  else
    set mouse=a
  endif
endfunction
if has('mouse')
  noremap <Leader>y :call ToggleMouse()<CR>
end
