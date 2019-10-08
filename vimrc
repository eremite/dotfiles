" https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" General
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'PeterRincker/vim-argumentative'
Plug 'benjifisher/matchit.zip'
Plug 'bfredl/nvim-miniyank'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'milkypostman/vim-togglelist'
Plug 'morhetz/gruvbox'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sjl/gundo.vim'
Plug 'slim-template/vim-slim'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wsdjeg/vim-fetch'

" Text objects
Plug 'Julian/vim-textobj-variable-segment'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

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

" Live substitution
if exists('&inccommand')
  set inccommand=nosplit
endif

" Turn off mouse
set mouse=

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
autocmd BufRead,BufNewFile *.ruby set filetype=ruby
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
" Check syntax on file save
autocmd BufWritePost *.rb,*.slim,*.js,*.scss,*.haml Neomake
" Use yaml style comments instead of erb
autocmd FileType eruby.yaml setlocal commentstring=#\ %s

" Tabs and indentation
" Default to 2 spaces (ruby FTW)
set backspace=start,indent,eol
set tabstop=2
set softtabstop=2
set shiftwidth=2
retab
set expandtab
set textwidth=100
set formatoptions-=t

" Colors
syntax enable
set background=dark
colorscheme gruvbox

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

" Highlight 81st and 101st column to discourage long lines.
set colorcolumn=81,101

" Remember last location in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Ignore the following
set wildignore+=.git,*.jpg,*.png,*.zip,*.tar.gz,.DS_Store,tmp/**

" Ignore case for fast-typed commands.
command Q q
command W w
command WQ wq
command Wq wq
command Cnf cnf

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
cabbrev ECo Econtroller
cabbrev ECon Econtroller

" Run the last test
nnoremap <leader>a :TestLast<CR>:cexpr []<CR>:copen<CR>:wincmd k<CR>
" Run [a]ll tests
nnoremap <leader>A :TestSuite<CR>:cexpr []<CR>:copen<CR>:wincmd k<CR>
nnoremap <silent> <Leader>b :call fzf#run({
\   'source': reverse(<sid>buflist()),
\   'sink': function('<sid>bufopen'),
\   'options': '+m',
\   'up': len(<sid>buflist()) + 2
\ })<CR>
" Toggle Quickfix list
nnoremap <silent> <leader>c :call ToggleQuickfixList()<CR>
" Open file in current [d]irectory
nnoremap <silent> <Leader>d :call fzf#run({
\   'dir': expand("%:p:h"),
\   'options': '+m',
\   'sink': 'edit',
\   'source': 'find . -maxdepth 1 -type f -printf "%f\n"'
\ })<CR>
" Edit file in current [d]irectory
nnoremap <Leader>D :saveas %:h/
" [E]dit
noremap <Leader>e :e<Space>
" [E]dit!
noremap <Leader>E :e!<CR>
" [f]lip to alternate buffer
noremap <Leader>f :b #<CR>
" Git Grep (G[g]rep) the selection
vnoremap <Leader>g y:Ggrep '<C-r>"'<CR>
" Git Grep (G[g]rep) the word under the cursor
nnoremap <Leader>g :Ggrep <C-r><C-w><CR>
" Change string to a symbol (like ruby's [i]ntern method)
nnoremap <Leader>i 2f'xF'xi:<ESC>
nnoremap <Leader>I 2f"xF"xi:<ESC>
" Convert a three line tag or block to one line. (an overpowered [J])
noremap <Leader>j maJxJx`a
" Toggle Location list
nnoremap <silent> <leader>l :call ToggleLocationList()<CR>
" [M]ulti-line an array or hash
noremap <Leader>m ma:s/, \?/,<c-v><CR>/g<CR>j=`a
" Edit [N]otes file
noremap <Leader>n :call OpenDirectoryNotes()<CR>
" [O]rganize alphabetically (sort)
noremap <Leader>o :sort<CR>
" [Q]uit
noremap <Leader>q :quitall!<CR>
" run the nearest test
nnoremap <leader>r :TestNearest<CR>:cexpr []<CR>:copen<CR>:wincmd k<CR>
" Run the tests on this file
nnoremap <leader>R :TestFile<CR>:cexpr []<CR>:copen<CR>:wincmd k<CR>
" [S]ave
nnoremap <Leader>s :update<CR>
" Insert [s]aved register 0
inoremap <C-S> <C-R>0
" Open [t]ag
noremap <Leader>t :BTags<CR>
" Vest the last run test
noremap <Leader>v :TestVisit<CR>
" E[x]it current Buffer
noremap <Leader>x :bd<CR>
" f[z]f Fuzzy Finder
noremap <Leader>z :FZF!<CR>

function OpenDirectoryNotes()
  execute ':e ' . fnameescape($META_DIRECTORY) . fnamemodify(getcwd(), ':t') . '.md'
endfunction

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
autocmd FileType markdown let b:surround_99 = "```\n\r\n```"
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

" Configure switch
autocmd FileType ruby let b:switch_custom_definitions =
\ [
\   {
\     'assert_not': 'assert',
\     'assert\%(_not\)\@!': 'assert_not',
\   },
\   {
\     'assert_not_nil': 'assert_nil',
\     'assert\%(_not\)\@!_nil': 'assert_not_nil',
\   }
\ ]

" Configure togglelist
let g:toggle_list_no_mappings = 1

" Configure splitjoin.vim
let g:splitjoin_ruby_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
nnoremap sj :SplitjoinSplit<CR>
nnoremap sk :SplitjoinJoin<CR>

" Configure miniyank
if has('nvim')
  map p <Plug>(miniyank-autoput)
  map P <Plug>(miniyank-autoPut)
  map <leader>p <Plug>(miniyank-cycle)
end

" Configure dispatch
let g:dispatch_quickfix_height=20

" Configure markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['ruby', 'sh', 'bash=sh', 'javascript', 'sql']

" Configure fzf
" https://github.com/junegunn/fzf/wiki/Examples-(vim)
" Select buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction
function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction
" Jump to tag in current buffer
function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction
function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction
function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction
function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction
command! BTags call s:btags()

" Configure vim-flagship
set laststatus=2
set showtabline=0 " I don't use tabs

" Extend fugitive
cmap Gwc :Git whatchanged -p --abbrev-commit --pretty=medium %
set tags^=./.git/tags;

" Configure projections
let g:rails_projections = {
\   "app/models/concerns/*.rb": {
\     "command": "mconcern",
\     "affinity": "model"
\   },
\   "app/controllers/concerns/*.rb": {
\     "command": "cconcern",
\     "affinity": "controller"
\   },
\   "app/presenters/*_presenter.rb": {
\     "command": "presenter",
\     "affinity": "model"
\   },
\   "app/classes/*.rb": {
\     "command": "class"
\   },
\   "app/forms/*.rb": {
\     "command": "form"
\   },
\   "app/reports/*.rb": {
\     "command": "report"
\   },
\   "app/webpack/components/*": {
\     "command": "component",
\   },
\   "app/controllers/api/*_controller.rb": {
\     "alternate": "test/integration/api/{}_test.rb"
\   },
\   "test/integration/api/*_test.rb": {
\     "related": "app/controllers/api/{}_controller.rb"
\   },
\   "test/mailers/previews/*_preview.rb": {
\     "command": "mpreview",
\     "related": "app/mailers/{}.rb"
\   }
\ }
let g:rails_gem_projections = {
\   "carrierwave": {
\     "app/uploaders/*_uploader.rb": {
\       "command": "uploader"
\     }
\   }
\ }

" Configure Neomake
" let g:neomake_open_list = 3
" let g:neomake_place_signs = 0
let g:neomake_logfile = '/tmp/neomake.log'
let g:neomake_warning_sign = { 'text': '>>', 'texthl': 'ErrorMsg' }
let g:neomake_error_sign = { 'text': '>>', 'texthl': 'ErrorMsg' }

" rubocop
function! RubocopEntryProcess(entry)
	if a:entry.type ==# 'F'
		let a:entry.type = 'E'
	elseif a:entry.type !=# 'W' && a:entry.type !=# 'E'
		let a:entry.type = 'W'
	endif
endfunction
let g:neomake_ruby_rubocop_maker = {
  \ 'append_file': 0,
  \ 'args': ['exec', '-T', 'web', 'rubocop', '-P', '--format', 'emacs', '%'],
  \ 'errorformat': '%f:%l:%c: %t: %m',
  \ 'exe': 'docker-compose',
  \ 'mapexpr': "substitute(v:val, '/usr/src/app/', '', '')",
  \ 'postprocess': function('RubocopEntryProcess'),
\ }
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_rubocop_maker = {
  \ 'args': ['exec', '-T', 'web', 'rubocop', '-P', '--format', 'emacs', '--force-exclusion'],
  \ 'errorformat': '%f:%l:%c: %t: %m',
  \ 'exe': 'docker-compose',
  \ 'mapexpr': "substitute(v:val, '/usr/src/app/', '', '')",
  \ 'postprocess': function('RubocopEntryProcess'),
\ }

" haml
let g:neomake_haml_haml_lint_maker = {
  \ 'append_file': 0,
  \ 'args': ['exec', '-T', 'web', 'haml-lint', '--no-color', '--no-summary', '%'],
  \ 'errorformat': '%f:%l %m',
  \ 'exe': 'docker-compose',
  \ 'mapexpr': "substitute(v:val, '/usr/src/app/', '', '')",
\ }
let g:neomake_haml_enabled_makers = ['haml_lint']
let g:neomake_haml_maker = {
  \ 'args': ['exec', '-T', 'web', 'haml-lint', '--no-color', '--no-summary'],
  \ 'errorformat': '%f:%l %m',
  \ 'exe': 'docker-compose',
  \ 'mapexpr': "substitute(v:val, '/usr/src/app/', '', '')",
\ }

" slim
let g:neomake_slim_slim_lint_maker = {
  \ 'append_file': 0,
  \ 'args': ['exec', '-T', 'web', 'slim-lint', '--no-color', '%'],
  \ 'errorformat': '%f:%l %m',
  \ 'exe': 'docker-compose',
  \ 'mapexpr': "substitute(v:val, '/usr/src/app/', '', '')",
\ }
let g:neomake_slim_enabled_makers = ['slim_lint']
let g:neomake_slim_lint_maker = {
  \ 'args': ['exec', '-T', 'web', 'slim-lint', '--no-color', 'app/views'],
  \ 'errorformat': '%f:%l %m',
  \ 'exe': 'docker-compose',
  \ 'mapexpr': "substitute(v:val, '/usr/src/app/', '', '')",
\ }

" javascript
let g:neomake_javascript_yarn_maker = {
  \ 'args': ['exec', '-T', 'web', 'yarn', 'test', '--format', 'unix'],
  \ 'errorformat': '%f:%l:%c: %m',
  \ 'exe': 'docker-compose',
  \ 'mapexpr': "substitute(v:val, '/usr/src/app/', '', '')",
\ }
let g:neomake_javascript_enabled_makers = ['yarn']

" scss
let g:neomake_scss_stylelint_maker = {
  \ 'args': ['exec', '-T', 'web', 'yarn', 'stylelint', '%', '--formatter', 'unix'],
  \ 'errorformat': '%f:%l:%c: %m',
  \ 'exe': 'docker-compose',
  \ 'append_file': 0,
  \ 'mapexpr': "substitute(v:val, '/usr/src/app/', '', '')",
\ }
let g:neomake_scss_enabled_makers = ['stylelint']

" sh
let g:neomake_sh_shellcheck_maker = {
  \ 'append_file': 0,
  \ 'args': ['-fgcc', '%:.'],
  \ 'errorformat':
    \ '%f:%l:%c: %trror: %m,' .
    \ '%f:%l:%c: %tarning: %m,' .
    \ '%f:%l:%c: %tote: %m',
  \ 'exe': 'shellcheck',
  \ 'mapexpr': "substitute(v:val, '/source/', '', '')",
\ }
let g:neomake_sh_enabled_makers = ['shellcheck']

" Configure test-vim
let test#ruby#rails#executable = 'docker-compose exec -T web rails test'
let test#strategy = 'neomake'
let test#enabled_runners = ["ruby#rails"]
let test#preserve_screen = 0

" Turn on syntax completion.
set completefunc=syntaxcomplete#Complete
