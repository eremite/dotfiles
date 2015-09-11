" https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" General
Plug 'altercation/vim-colors-solarized'
Plug 'matchit.zip'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-rhubarb'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'christoomey/vim-tmux-navigator'
Plug 'sjl/gundo.vim'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'PeterRincker/vim-argumentative'

" Text objects
Plug 'Julian/vim-textobj-variable-segment'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" Languages/frameworks
Plug 'kchmck/vim-coffee-script'
Plug 'php.vim'
Plug 'php.vim-html-enhanced'
Plug 'othree/html5.vim'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'ekalinin/Dockerfile.vim'

call plug#end()

" Linux never crashes. :)
set noswapfile
" Autosave when changing buffers (the warnings get annoying)
set autowriteall
" Enable persistent undo
if isdirectory($HOME.'/.vim/tmp/undo') == 0
  call system('mkdir -p '.$HOME.'/.vim/tmp/undo')
endif
set undofile
set undodir=$HOME/.vim/tmp/undo

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
autocmd BufRead,BufNewFile *.prawn set filetype=ruby
" Don't assume the line after a comment is still a comment
autocmd FileType ruby setlocal formatoptions-=cro
autocmd FileType yaml setlocal formatoptions-=cro
" 4 spaces for python indentation
autocmd BufRead *.py set ts=4 et sw=4 sts=4
autocmd FileType php set sw=2
autocmd FileType php set list
" Remove fugitive buffers (from browsing git objects)
" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database
autocmd BufReadPost fugitive://* set bufhidden=delete
" When opening a commit message, go to the first line.
autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])


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
silent! colorscheme solarized
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
imap Jk <esc>
imap JK <esc>
imap jj <esc>j
imap kk <esc>k

" Map autocomplete to tab
" https://github.com/ryanb/dotfiles/blob/master/vimrc
imap <Tab> <C-N>
imap <S-Tab> <C-P>

" Abbreviations
ab pa params
cabbrev EMo Emodel

" Run [A]ll tests
nnoremap <leader>a :Rake test<CR>
" Open [a]ny file with Unite
" [b]uffergator
nnoremap <leader>b :BuffergatorOpen<CR>
" Close all but current [B]uffer
nnoremap <leader>B :1,999bd<CR><C-^>
" Open file in current [d]irectory
" http://vimcasts.org/episodes/the-edit-command
map <leader>d :e %:.:h/
" [E]dit
noremap <Leader>e :e<Space>
" [E]dit!
noremap <Leader>E :e!<CR>
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
noremap <Leader>n :e notes.md<CR>
" [O]rganize alphabetically (sort)
noremap <Leader>o :sort<CR>
" [Q]uit
noremap <Leader>q :quit<CR>
" [R]emove smart quotes (and friends).
" noremap <Leader>R ma:%s/[“”]/"/eg<CR>:%s/’/'/eg<CR>`a
" Run [r]ake on this line
nnoremap <leader>r :.Rake<CR>
" Run [R]ake on this file
nnoremap <leader>R :Rake<CR>
" [S]ave
noremap <Leader>s :write<CR>
" E[x]it current Buffer
noremap <Leader>x :bd<CR>

" Configure surround
" https://github.com/tpope/vim-surround
" Re-indent (=) after surrounding
let b:surround_indent = 1
" -
autocmd FileType php,html let b:surround_45 = "<? \r ?>"
autocmd FileType php,html let b:surround_61 = "<?= \r ?>"
" # - #{}
autocmd FileType ruby,eruby,haml let g:surround_35 = "#{\r}"
" c - code block
autocmd FileType markdown let b:surround_99 = "```ruby\n\r\n```"
" d - debug
autocmd FileType ruby let b:surround_100 = "logger.debug(\"### #{\r}\") #TODO: remove debug code"
autocmd FileType javascript let g:surround_100 = "console.log(\r); // TODO Remove debug code"
autocmd FileType coffee let g:surround_100 = "console.log(\r) # TODO: Remove debug code"
" t - try
let g:surround_116 = "try(:\r)"
" v - variable
let g:surround_118 = "\"#{\r}\""

" Configure vim-ruby
" https://github.com/vim-ruby/vim-ruby
let g:ruby_hanging_indent = 0

" Configure vim-markdown
let g:markdown_fenced_languages = ['sh', 'ruby', 'javascript', 'sql']

" Configure vim-buffergator
let g:buffergator_suppress_keymaps = 1
let g:buffergator_sort_regime = 'mru'
let g:buffergator_viewport_split_policy = 'T'
let g:buffergator_display_regime = 'bufname'

" Configure vim-flagship
set laststatus=2
set showtabline=0 " I don't use tabs

" Extend fugitive
cmap Gwc :Git whatchanged -p --abbrev-commit --pretty=medium %

" Configure projections
let g:projectionist_heuristics = {
\   "js/components/": {
\     "js/components/*.js": { "type": "component" },
\     "js/stores/*.js": { "type": "store" },
\     "js/utils/*.js": { "type": "utils" }
\   }
\ }
let g:rails_projections = {
\   "app/models/concerns/*.rb": {
\     "command": "mconcern",
\     "affinity": "model"
\   },
\   "app/controllers/concerns/*.rb": {
\     "command": "cconcern",
\     "affinity": "ccontroller"
\   },
\   "app/mailers/notifier.rb": {
\     "command": "mailer"
\   }
\ }
let g:rails_gem_projections = {
\   "pundit": {
\     "app/policies/*_policy.rb": {
\       "command": "policy",
\       "affinity": "model"
\     }
\   },
\   "carrierwave": {
\     "app/uploaders/*_uploader.rb": {
\       "command": "uploader"
\     }
\   }
\ }

" Turn on syntax completion.
set completefunc=syntaxcomplete#Complete
