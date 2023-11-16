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
Plug 'Julian/vim-textobj-variable-segment'
Plug 'PeterRincker/vim-argumentative'
Plug 'benjifisher/matchit.zip'
Plug 'github/copilot.vim'
Plug 'glts/vim-textobj-comment'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'milkypostman/vim-togglelist'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'romainl/flattened'
Plug 'sjl/gundo.vim'
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
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wsdjeg/vim-fetch'

call plug#end()

" Linux never crashes. :)
set noswapfile
" Autosave whenever text changes
" autocmd TextChanged,InsertLeave * silent write

" https://stackoverflow.com/questions/17365324/auto-save-in-vim-as-you-type#comment114062094_55761306
" autocmd TextChanged,InsertLeave <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent write | endif

" https://stackoverflow.com/a/60095826
augroup autosave
    autocmd!
    autocmd BufRead * if &filetype == "" | setlocal ft=text | endif
    autocmd FileType * autocmd TextChanged,InsertLeave <buffer> if &readonly == 0 && filereadable(bufname('%')) | silent write | endif
augroup END

" set autowriteall
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
autocmd BufRead,BufNewFile *.config set filetype=yaml
" Don't assume the line after a comment is still a comment
autocmd FileType haml setlocal textwidth=120
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
call neomake#configure#automake('rn', 1000)
" Use ruby comments in markdown
autocmd FileType markdown setlocal commentstring=#\ %s
" Turn off auto wrapping of text in markdown files
autocmd FileType markdown set textwidth=0
" Back up notes to the cloud
if $META_DIRECTORY != ""
  autocmd BufWritePost notes.*,docker-compose.yml execute ':keepalt write! '.fnameescape($META_DIRECTORY).fnamemodify(getcwd(), ':t').'.'.expand('%:e')
  autocmd BufWritePost notes.*,docker-compose.yml execute 'terminal ++hidden ++close ++norestore bash -c "update_meta_file.sh '.fnameescape($META_DIRECTORY).fnamemodify(getcwd(), ':t').'.'.expand('%:e').'"'
endif

" Tabs and indentation
" Default to 2 spaces (ruby FTW)
set backspace=start,indent,eol
set tabstop=2
set softtabstop=2
set shiftwidth=2
retab
set expandtab
set textwidth=120
set formatoptions-=t

" Colors
syntax enable
colorscheme flattened_dark

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

" Highlight 81st and 121st column to discourage long lines.
set colorcolumn=81,121

" Close netrw buffers automatically
let g:netrw_fastbrowse=0
autocmd FileType netrw setl bufhidden=delete

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
imap <Tab> <C-P>
imap <S-Tab> <C-N>

" Toggle signcolumn: https://stackoverflow.com/a/71966533
nnoremap yoe :execute "set signcolumn=" .. (&signcolumn == "auto" ? "no" : "auto")<CR>

" Abbreviations
cabbrev EMo Emodel
cabbrev ECo Econtroller
cabbrev ECon Econtroller

" Run the last test
nnoremap <leader>a :TestLast<CR>:call OpenQuickfix()<CR>
" Run [a]ll tests
nnoremap <leader>A :TestSuite<CR>:call OpenQuickfix()<CR>
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
nnoremap <Leader>G :Git<CR>
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
noremap <Leader>n :edit tmp/notes.md<CR>
noremap <Leader>N :edit tmp/notes.rb<CR>
" [O]rganize alphabetically (sort)
noremap <Leader>o :sort<CR>
" Edit [p]ull request notes
noremap <Leader>p :edit pr.md<CR>
" [Q]uit
noremap <Leader>q :quitall!<CR>
" run the nearest test
nnoremap <leader>r :TestNearest<CR>:call OpenQuickfix()<CR>
" Run the tests on this file
nnoremap <leader>R :TestFile<CR>:call OpenQuickfix()<CR>
" [S]ave
nnoremap <Leader>s :update<CR>
" Insert [s]aved register 0
inoremap <C-S> <C-R>0
" Open [t]ag
noremap <Leader>t :BTags<CR>
" Vest the last run test
noremap <Leader>v :TestVisit<CR>
" E[x]it current buffer
noremap <Leader>x :bd<CR>
" E[x]it all but the current buffer
noremap <leader>X :silent! execute "%bd\|e#\|bd#"<CR>
" f[z]f Fuzzy Finder
noremap <Leader>z :FZF!<CR>
" Open a terminal
noremap <Leader>' :terminal<CR>

function! OpenQuickfix()
  cexpr []
  copen
  wincmd w
endfunction

" Put quickfix on the right
au FileType qf wincmd L
au FileType qf vertical resize 64

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
autocmd FileType ruby let b:surround_100 = "Rails.logger.debug(\"### #{\r}\")"
" t - try
let g:surround_116 = "try(:\r)"
" v - variable
let g:surround_118 = "\"#{\r}\""

" Configure vim-ruby
" https://github.com/vim-ruby/vim-ruby
let g:ruby_hanging_indent = 0

" Configure switch
let g:switch_custom_builtins =
\ {
\   'ruby_array_shorthand_with_brackets_and_double_quotes': {
\     '\[\%(\k\|[''", ]\)\+\]': {
\       '\[':                    '%w[',
\       '[''"]\(\k\+\)[''"],\=': '\1',
\       ']':                     ']',
\     },
\     '%w\[\%(\k\|\s\)\+\]': {
\       '%w\[':      '[',
\       '\(\k\+\) ': '"\1", ',
\       '\(\k\+\)\]': '"\1"]',
\     },
\     '\[\%(\k\|[:, ]\)\+\]': {
\       '\[':           '%i[',
\       ':\(\k\+\),\=': '\1',
\       ']':            ']',
\     },
\     '%i\[\%(\k\|\s\)\+\]': {
\       '%i\[':      '[',
\       '\(\k\+\) ': ':\1, ',
\       '\(\k\+\)\]': ':\1]',
\     },
\   },
\   'ruby_assert_not': {
\     'assert_not': 'assert',
\     'assert\%(_not\)\@!': 'assert_not',
\   },
\   'ruby_assert_not_nil': {
\     'assert_not_nil': 'assert_nil',
\     'assert\%(_not\)\@!_nil': 'assert_not_nil',
\   },
\   'haml_interpolation': {
\     '#{\(.*\)}$': '= \1',
\     '= \(.*\)$': '#{\1}',
\   },
\ }
autocmd FileType ruby let b:switch_custom_definitions =
\ [
\   g:switch_custom_builtins.ruby_array_shorthand_with_brackets_and_double_quotes,
\   g:switch_custom_builtins.ruby_assert_not,
\   g:switch_custom_builtins.ruby_assert_not_nil,
\ ]
autocmd FileType haml let b:switch_custom_definitions = [g:switch_custom_builtins.haml_interpolation]

" Configure togglelist
let g:toggle_list_no_mappings = 1

" Configure splitjoin.vim
let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_options_as_arguments = 1
nnoremap sj :SplitjoinSplit<CR>
nnoremap sk :SplitjoinJoin<CR>

" Configure dispatch
let g:dispatch_quickfix_height=30

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
cmap Gwc Git -p whatchanged --abbrev-commit --pretty=medium .
set tags^=./.git/tags;

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
  \ 'args': ['compose', 'exec', '-T', 'web', 'rubocop', '-P', '--format', 'emacs', '%'],
  \ 'errorformat': '%f:%l:%c: %t: %m',
  \ 'exe': 'docker',
  \ 'mapexpr': "substitute(v:val, '/var/app/current/', '', '')",
  \ 'postprocess': function('RubocopEntryProcess'),
\ }
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_rubocop_maker = {
  \ 'args': ['compose', 'exec', '-T', 'web', 'rubocop', '-P', '--format', 'emacs', '--force-exclusion'],
  \ 'errorformat': '%f:%l:%c: %t: %m',
  \ 'exe': 'docker',
  \ 'mapexpr': "substitute(v:val, '/var/app/current/', '', '')",
  \ 'postprocess': function('RubocopEntryProcess'),
\ }

" haml
let g:neomake_haml_haml_lint_maker = {
  \ 'append_file': 0,
  \ 'args': ['compose', 'exec', '-T', 'web', 'haml-lint', '--no-color', '--no-summary', '%'],
  \ 'errorformat': '%f:%l %m',
  \ 'exe': 'docker',
  \ 'mapexpr': "substitute(v:val, '/var/app/current/', '', '')",
\ }
let g:neomake_haml_enabled_makers = ['haml_lint']
let g:neomake_haml_maker = {
  \ 'args': ['compose', 'exec', '-T', 'web', 'haml-lint', '--no-color', '--no-summary'],
  \ 'errorformat': '%f:%l %m',
  \ 'exe': 'docker',
  \ 'mapexpr': "substitute(v:val, '/var/app/current/', '', '')",
\ }

" javascript
let g:neomake_javascript_eslint_maker = {
  \ 'args': ['compose', 'exec', '-T', 'web', 'yarn', 'lint_js', '--format', 'unix'],
  \ 'errorformat': '%f:%l:%c: %m',
  \ 'exe': 'docker',
  \ 'mapexpr': "substitute(v:val, '/var/app/current/', '', '')",
\ }
let g:neomake_javascript_enabled_makers = ['eslint']

" scss
let g:neomake_scss_stylelint_maker = {
  \ 'args': ['compose', 'exec', '-T', 'web', 'yarn', 'lint_scss', '%', '--formatter', 'unix'],
  \ 'errorformat': '%f:%l:%c: %m',
  \ 'exe': 'docker',
  \ 'append_file': 0,
  \ 'mapexpr': "substitute(v:val, '/var/app/current/', '', '')",
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

" haml
let g:neomake_yaml_yamllint_maker = {
  \ 'append_file': 0,
  \ 'args': ['compose', 'exec', '-T', 'web', 'yamllint', '--format', 'parsable', '%'],
  \ 'errorformat': '%E%f:%l:%c: [error] %m,%W%f:%l:%c: [warning] %m',
  \ 'exe': 'docker',
  \ 'mapexpr': "substitute(v:val, '/var/app/current/', '', '')",
\ }
let g:neomake_yaml_enabled_makers = ['yamllint']
let g:neomake_yaml_maker = {
  \ 'args': ['compose', 'exec', '-T', 'web', 'yamllint', '--format', 'parsable', '.'],
  \ 'errorformat': '%E%f:%l:%c: [error] %m,%W%f:%l:%c: [warning] %m',
  \ 'exe': 'docker',
  \ 'mapexpr': "substitute(v:val, '/var/app/current/', '', '')",
\ }

" Configure test-vim
let g:test#ruby#rails#executable = '~/dotfiles/bin/dcrtest'
let test#strategy = 'neomake'
let test#enabled_runners = ["ruby#rails"]
let test#preserve_screen = 0

" Turn on syntax completion.
set completefunc=syntaxcomplete#Complete
