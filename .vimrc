"Author:mizoc <yaesuft729@gmail.com> https://github.com/mizoc/dotfiles
"license:MIT
"                                         ____             _                 
"  _   __(_)___ ___  __________    ____  / __/  ____ ___  (_)___  ____  _____
" | | / / / __ `__ \/ ___/ ___/   / __ \/ /_   / __ `__ \/ /_  / / __ \/ ___/
" | |/ / / / / / / / /  / /__    / /_/ / __/  / / / / / / / / /_/ /_/ / /__  
" |___/_/_/ /_/ /_/_/   \___/    \____/_/    /_/ /_/ /_/_/ /___/\____/\___/  
"
"---------------Setting of Plugin--------------------
call plug#begin('~/.vim/plugged')

"フォント(icon)
Plug 'ryanoasis/vim-devicons'

"markdownのプラグイン 下で設定
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'

"ruby end 自動入力
Plug 'tpope/vim-endwise'

"ップレビュー一括置換
Plug 'osyo-manga/vim-over'

"スムーズなスクロール
" Plug 'yuttie/comfortable-motion.vim'

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

"日本語<=>英語を翻訳してくれるやつ
Plug 'mattn/webapi-vim'
Plug 'mattn/excitetranslate-vim'

"便利なもの
Plug 'Shougo/Unite.vim'
"Plug 'rhysd/vim-operator-surround'
"Plug 'tpope/vim-surround'
"Plug 'vim-scripts/Align'
Plug 'vim-scripts/YankRing.vim'

"to do list
Plug 'vim-scripts/TaskList.vim'

"左側のやつ
Plug 'Shougo/vimfiler'

"高機能undo管理
Plug 'dsummersl/gundo.vim'

"関数名・クラス名表示
Plug 'Shougo/unite-outline'

"非同期実行して結果を見ることができる奴
Plug 'thinca/vim-quickrun'

"カッコの自動入力
Plug 'kana/vim-smartinput'

"Python　文法チェック
"Plug 'andviro/flake8-vim'

"幅跳びゲーム
Plug 'mattn/habatobi-vim'

"gccで素の行を、V後gcで選択範囲をコメントアウト
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdcommenter'
"Plug 'emonkak/vim-operator-comment'

"選択したブロックの直感的な移動、複製
Plug 't9md/vim-textmanip'

"python coding check(pep8違反じゃないかとか)
Plug 'hynek/vim-python-pep8-indent'

"編集中の関数の中のローカル変数をハイライト
Plug 'hachibeeDI/python_hl_lvar.vim'

"インデント単位での調整が可能
"Plug 'kana/vim-textobj-indent'
Plug 'tweekmonster/braceless.vim'
Plug 'thaerkh/vim-indentguides'

"インデント可視化
Plug 'nathanaelkane/vim-indent-guides'

"airline thema(下で設定)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

"python 補完
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/neosnippet.vim'

"補完 下で設定
Plug 'shougo/neocomplete.vim'

"カラーテーマ
Plug 'flazz/vim-colorschemes'
Plug 'ujihisa/unite-colorscheme'

"rubyのプラグイン
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


" 見た目系
" テーマの設定
syntax enable
"colorscheme BlackSea
colorscheme molokai
"行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
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
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
"set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
"eコマンドなどのtab補完
set wildmenu
set wildmode=full

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
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>
"f5でpython3実行 f6でpython2の実行
nmap <F5> :!python3 %
nmap <F6> :!python %
"f10でsource
nmap <F10> :source %

"f8でruby実行
nmap <F4> :!ruby %

"GUNDOの設定
set undofile
set undodir=~/.vim/undo

"-------------------neocompleteの設定-----------------
let g:neocomplete#enable_at_startup = 1 "起動時に有効化

".mdをmarkdown形式として読み込ませる
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

"------------------previmの設定----------------------
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>

"------------------vim-table-modeの設定---------------
let g:table_mode_corner = '|'
autocmd BufNewFile,BufRead *.md* TableModeEnable

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
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('sh',    'red', 'none', '#ff00ff', '#151515')

" setting of leader
let mapleader="\<Space>"
"leader-sでプレビュー置換の起動
nnoremap <leader>s :OverCommandLine<CR>:%s/
" leader-sでツリー表示・非表示
nnoremap <silent><leader>e :NERDTreeToggle<CR>
" leader-iでインデント整形
nnoremap <leader>i gg=G
" leader-wで画面分割間の移動
nnoremap <leader>w <C-w><C-w>
