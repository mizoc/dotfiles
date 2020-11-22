"Author:mizoc <yaesuft729@gmail.com> https://github.com/mizoc/dotfiles
"license:MIT
"@ (#) My .vimrc
"                                         ____             _
"  _   __(_)___ ___  __________    ____  / __/  ____ ___  (_)___  ____  _____
" | | / / / __ `__ \/ ___/ ___/   / __ \/ /_   / __ `__ \/ /_  / / __ \/ ___/
" | |/ / / / / / / / /  / /__    / /_/ / __/  / / / / / / / / /_/ /_/ / /__
" |___/_/_/ /_/ /_/_/   \___/    \____/_/    /_/ /_/ /_/_/ /___/\____/\___/
"
"---------------Setting of Plugin--------------------
call plug#begin('~/.vim/plugged')

"c++補完
" Plug 'justmao945/vim-clang'
" Plug 'vim-jp/cpp-vim'

" html close tag automatically
Plug 'alvan/vim-closetag'

"python formatter
Plug 'psf/black', { 'branch': 'stable' }
Plug 'fisadev/vim-isort'

"python docstring
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

"cal
Plug 'itchyny/calendar.vim'

"golang
" Plug 'fatih/vim-go'

"フォント(icon)
Plug 'ryanoasis/vim-devicons'

"show relative number
" Plug 'vim-scripts/RltvNmbr.vim'

"半角スペース可視化
Plug 'bronson/vim-trailing-whitespace'

"minimap
Plug 'severin-lemaignan/vim-minimap'

"preview markdown
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'

"tab補完
Plug 'ervandew/supertab'

":ansiEscでANSIカラー表示
Plug 'vim-scripts/AnsiEsc.vim'

"ruby end 自動入力
Plug 'tpope/vim-endwise'

"繰り返しを可能にする
Plug 'tpope/vim-repeat'

"ップレビュー一括置換
Plug 'osyo-manga/vim-over'

"ツリー表示
Plug 'scrooloose/nerdtree'

"文法的間違いを指摘
Plug 'w0rp/ale'

"vimでw3m
Plug 'yuratomo/w3m.vim'

"テーブル作成(下で設定)
Plug 'dhruvasagar/vim-table-mode'

"git 関連
Plug 'airblade/vim-gitgutter'

"Gdiffを可視化
Plug 'tpope/vim-fugitive'

"翻訳
Plug 'skanehira/translate.vim'

"便利なもの
Plug 'Shougo/Unite.vim'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/YankRing.vim'

"高機能undo管理
Plug 'dsummersl/gundo.vim'

"関数名・クラス名表示
Plug 'Shougo/unite-outline'

"非同期実行して結果を見ることができる奴
Plug 'thinca/vim-quickrun'

"カッコの自動入力
Plug 'kana/vim-smartinput'

"gccでその行を、V後gcで選択範囲をコメントアウト
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdcommenter'

"選択したブロックの直感的な移動、複製
Plug 't9md/vim-textmanip'

"python coding check(pep8違反じゃないかとか)
Plug 'hynek/vim-python-pep8-indent'

"インデント単位での調整が可能
Plug 'tweekmonster/braceless.vim'

"airline thema(下で設定)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

"python 補完
Plug 'davidhalter/jedi-vim'

"多機能セレクター Ctrl-pで起動
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'suy/vim-ctrlp-commandline'

"補完
Plug 'shougo/neocomplete.vim'

"snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"template :template main
Plug 'mattn/vim-sonictemplate'

"colorscheme
Plug 'flazz/vim-colorschemes'
Plug 'ujihisa/unite-colorscheme'

"ruby
Plug 'vim-ruby/vim-ruby'

call plug#end()

"viとの互換性を無効にする(INSERT中にカーソルキーが有効になる)
set nocompatible
"BSで削除できるものを指定する
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start
"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
scriptencoding utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
"改行後の自動コメントアウト無効
set formatoptions-=ro
"バッファを閉じない（undo履歴残すため）
set hidden
"対応するカッコをハイライト
set showmatch
"保存用文字コード
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

" 見た目系
" テーマの設定
syntax enable
" colorscheme molokai
colorscheme badwolf
"行番号を表示
set number
"相対的な行表示
set relativenumber
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
" set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4

autocmd BufEnter *.go,*.cpp,*.c set tabstop=2
autocmd BufEnter *.go,*.cpp,*.c set shiftwidth=2
autocmd BufEnter *.cpp,*.c set cindent
" autocmd BufEnter *.rb set noexpandtab "tabをスペースにしたくない場合
" autocmd BufEnter *.cpp,*.c ClangCompleteInit

"Python
autocmd BufEnter *.py setlocal smarttab
"Setting of python formatters(black, isort)
let g:vim_isort_map=''
let g:black_linelength=150
let g:vim_isort_python_version = 'python3'
autocmd BufWritePre *.py execute ':Black'
" autocmd BufWritePre *.py execute ':Isort'

"Setting of pydocstring
let g:pydocstring_formatter='google'

"eコマンドなどのtab補完
set wildmenu
set wildmode=full
set history=1000 "保存コマンド履歴数

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索しない
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" insert modeで素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

"f4でruby実行
nmap <F4> :!ruby %
"f5でpython3実行
nmap <F5> :!python3 %
"f6でcpp実行
nmap <F6> :!g++ % && ./a.out
"f7でgolang実行
nmap <F7> :!go run %
"f10でsource
nmap <F10> :source %

"クリップボードの設定
set clipboard=unnamed,autoselect

"spell check
set spell
set spelllang=en,cjk
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline,bold

"show relative number
" autocmd BufEnter * RltvNmbr

"GUNDOの設定
set undofile
set undodir=~/.vim/undo

"----------------Setting of Ctrlp------------------------------------------
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用

" CtrlPCommandLineの有効化
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

" CtrlPFunkyの有効化
let g:ctrlp_funky_matchtype = 'path'

"C++ DoxygenToolkit
"https://github.com/vim-scripts/DoxygenToolkit.vim
"cp plug directory to ~/.vim/plugged
":Dox
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="mizoc"
let g:DoxygenToolkit_licenseTag="MIT"

"-------------------neocompleteの設定-----------------
let g:neocomplete#enable_at_startup = 1 "起動時に有効化

"settings of translate.vim
let g:translate_source = "en"
let g:translate_target = "ja"
let g:translate_popup_window = 1 "use pop-up window
"grでその行を翻訳
nmap gr <Plug>(Translate)
"visual mode で選択してtで翻訳
vmap t <Plug>(VTranslate)

".mdをmarkdown形式として読み込ませる
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" ------------------ansiescの設定------------------
autocmd BufNewFile,BufRead *.log AnsiEsc

"------------------previmの設定----------------------
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>

"------------------vim-table-modeの設定---------------
let g:table_mode_corner = '|'
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='
silent autocmd BufNewFile,BufRead *.md,*.txt TableModeEnable

"-------------------ホワイトスペースの可視化設定-----------------------
autocmd BufNewFile,BufRead * FixWhitespace

"---------------airlineの設定-------------
set laststatus=2
"タブに番号
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"Ctrl-mでタブの切り替え
nmap <C-m> <Plug>AirlineSelectPrevTab
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
"タブを大文字にする
let g:airline#extensions#tabline#buffer_idx_format = {
			\'0':'0',
			\'1':'1',
			\'2':'2',
			\'3':'3',
			\'4':'4',
			\'5':'5',
			\'6':'6',
			\'7':'7',
			\'8':'8',
			\'9':'9',}
let g:airline_theme = 'simple'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"" old vim-powerline symbols
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'
"
" -------------------Setting of Nerdtree---------------------
" " gitアイコン設定
" let g:NERDTreeIndicatorMapCustom = {
" 			\ "Modified"  : "✹",
" 			\ "Staged"    : "✚",
" 			\ "Untracked" : "✭",
" 			\ "Renamed"   : "➜",
" 			\ "Unmerged"  : "═",
" 			\ "Deleted"   : "✖",
" 			\ "Dirty"     : "✗",
" 			\ "Clean"     : "✔︎",
" 			\ "Unknown"   : "?"
" 			\ }
let g:NERDTreeShowIgnoredStatus = 1
" ファイルアイコンの表示有効化
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" ブックマーク初期表示
let g:NERDTreeShowBookmarks=1
" 起動時に実行(ファイル名無指定時のみ)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"ctrl-eで開く
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" sign of Directory
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('asm',     'Red',     'none', 'cyan',     '#151515')
call NERDTreeHighlightFile('cpp',     'blue',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('c',     'green',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('sh',    'red', 'none', '#ff00ff', '#151515')

"tabで補完
let g:SuperTabContextDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:jedi#completions_command = "<c-n>"
"
"Settings of braceless
autocmd FileType python BracelessEnable +indent +fold "+highlight-cc

"Setting of vim-go
" autocmd BufNewFile,BufRead *.go let g:go_fmt_command = "goimports"
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

"settings of vim-indent-guides
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'vimrc'] "無効
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

"setting of vim-sonictemplate
"my template
let g:sonictemplate_vim_template_dir = [
    \ '~/.dotfiles/template'
    \]

"setting of ultisnips
let g:UltiSnipsExpandTrigger='<c- >'
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:ulti_expand_or_jump_res = 0 "enterでスニペット展開
function! Ulti_ExpandOrJump_and_getRes()
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfunction
inoremap <CR> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":"\n"<CR>

"setting of clang
let g:clang_c_option = '-std=c11'
let g:clang_cpp_option = '-std=c++1z'
let g:clang_format_style = 'Google'
let g:clang_format_auto = 1
let g:clang_check_syntax = 1
let g:clang_format_style#style_options = {
	\ "Standard" : "C++11",
	\ "AlignAfterOpenBracket" : "true",
	\ "AlignConsecutiveAssignments" : "true",
	\ "AlignEscapedNewlines" : "Right",
	\ "AlignTrailingComments" : "true",
	\ "ColumnLimit" : "150",
	\ "AllowShortIfStatementsOnASingleLine" : "true",
	\ "AllowShortBlocksOnASingleLine" : "true",
	\ "AllowShortLoopsOnASingleLine" : "true",
	\ "AlwaysBreakBeforeMultilineStrings" : "true"}

"Setting of vim-python-pep8-indent
let g:python_pep8_indent_hang_closing = 1

" オムニ補完設定
autocmd FileType typescript setlocal omnifunc=lsp#complete

"Settings of vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

"key bindings
" setting of leader
let mapleader="\<Space>"
"leader-sでプレビュー置換の起動
nnoremap <leader>s :OverCommandLine<CR>:%s/
" leader-tでツリー表示・非表示
nnoremap <silent><leader>t :NERDTreeToggle<CR>
" leader-iでインデント整形
nnoremap <leader>i gg=G
"leader-wで保存
nnoremap <leader>w :w<cr>
"leader-qで終了
nnoremap <leader>q :q<cr>
"leader-jで画面間移動
nnoremap <leader>j <C-w><C-w>
"leader-hでコマンド履歴起動
nnoremap <leader>h :CtrlPCommandLine<cr>
"leader-pでpaste mode
nnoremap <leader>p :set paste<cr>
nnoremap <leader>pp :set nopaste<cr>
"leader-oでsplit
nnoremap <leader>o :split<cr>
"leader-oでvs
nnoremap <leader>e :vsplit<cr>
"leader-a+hjklでpain間の移動
nnoremap <leader>aj <C-w>j
nnoremap <leader>ah <C-w>h
nnoremap <leader>ak <C-w>k
nnoremap <leader>al <C-w>l

"setting of vim-fugitive
nnoremap <leader>gs :tab sp<CR>:Gstatus<CR>:only<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gh :tab sp<CR>:0Glog<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gd :Gvdiff<CR>
