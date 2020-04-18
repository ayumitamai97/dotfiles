" まだ整理必要...
syntax on
colorscheme vim-framer-syntax

" Thanks https://qiita.com/iwaseasahi/items/0b2da68269397906c14c
set t_Co=256
set backupskip=/tmp/*,/private/tmp/*
set number

" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup
" ファイルを上書きする前にバックアップを作ることを無効化
set nobackup
" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block
" 挿入モードでバックスペースで削除できるようにする
" set backspace=indent,eol,start
" 全角文字専用の設定
set ambiwidth=double
" wildmenuオプションを有効(vimバーからファイルを選択できる)
set wildmenu
" 行を折り返さない
set nowrap

set autoread

" ウインドウ分割の方向
set splitbelow
set splitright
" Vimでターミナルをエミュレートするときのサイズ
set termwinsize=20x0
" Vimでターミナルをエミュレートするときの実行コマンド
let &shell=$SHELL." --login"

"----------------------------------------
" 検索
"----------------------------------------
" 検索するときに大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視して検索
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set wrapscan
" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch
" 検索結果をハイライト表示
set hlsearch
hi Search ctermbg=DarkGray
hi Search ctermfg=White

"----------------------------------------
" 表示設定
"----------------------------------------
set cursorline
hi Normal ctermbg=233
hi CursorLine cterm=NONE ctermbg=236
hi Comment cterm=NONE
hi Directory ctermfg=Cyan
" 行番号にアンダーライン引かない
hi CursorLineNr cterm=NONE

" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells
" 対応する括弧やブレースを表示
set showmatch matchtime=1
" インデント方法の変更
set cinoptions+=:0
set tabstop=2
" メッセージ表示欄を2行確保
set cmdheight=2
" ステータス行を常に表示
set laststatus=2
" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd
" 省略されずに表示
set display=lastline
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~
" コマンドラインの履歴を10000件保存する
set history=10000
" Tabキーを押した時にタブ文字ではなく半角スペースを挿入
set expandtab
" インデント幅
set shiftwidth=2
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2
" ファイル内にあるタブ文字の表示幅
set tabstop=2
" 対応する括弧を強調表示
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 検索にマッチした行以外を折りたたむ(フォールドする)機能
set nofoldenable
" タイトルを表示
set title
" 行番号の表示
set number
" ヤンクでクリップボードにコピー
set clipboard+=unnamed,autoselect
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
" すべての数を10進数として扱う
set nrformats=
" 行をまたいで移動
" set whichwrap=b,s,h,l,<,>,[,],~
" バッファスクロール
set mouse=a

" auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" 保存時に行末のスペースを削除
autocmd BufWritePre * :%s/\s\+$//ge

" auto comment off
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" HTML/XML閉じタグ自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" 編集箇所のカーソルを記憶
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

" Commands, abbreviations
command Rp let @+ = join([expand("%"), line(".")], ":")
command Fp let @+ = expand("%:p")
command Cdc lcd %:p:h " 今開いているファイルのディレクトリにlcdする
cnoreabbrev cdc Cdc
command Phil cd ~/phil
cnoreabbrev phil Phil
command Rmself call delete(expand('%')) | Ex | echo 'Removed file'
cnoreabbrev rmself Rmself

" Ruby gems commands
let TermRspec = 'ter++noclose bundle exec rspec'
command RspecFile execute join([TermRspec, expand('%')])
cnoreabbrev rspf RspecFile
command RspecCase execute join([TermRspec, join([expand('%'), line('.')], ':')])
cnoreabbrev rspc RspecCase
command Rubo ter++noclose bundle exec rubocop -a
cnoreabbrev rubo Rubo

" Slim syntax highlights
execute pathogen#infect()
filetype plugin indent on
