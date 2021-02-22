" Start {{{
" remap <silent> <A-d> <cmd>lua
" require('lspsaga.floaterm').open_float_terminal()<CR>
if(has("win32"))
    let $SWAP_PATH= $HOME."\\AppData\\Local\\nvim\\swapfiles\\"
    let $UNDO_PATH = $HOME."\\AppData\\Local\\nvim\\undotree\\"
    let $isWindows = 1
else
    let $SWAP_PATH= $HOME."/.local/share/nvim/swapfiles//"
    let $UNDO_PATH = $HOME."/.local/share/nvim/undotree//"
    let $isWindows = 0
endif

" 判断是否存在插件管理器，没有就安装
if($isWindows == 1)
    if empty(glob($HOME."/AppData/Local/nvim-data/site/autoload/plug.vim"))
        silent !iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
        autocmd VimEnter * PlugInstall --sync
    endif
else
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync
    endif
endif

" }}}

" Disable {{{

"" Disable vim distribution plugins
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" }}}

" System {{{

" 关闭错误声音
set noerrorbells
set novisualbell
set t_vb=

" 启用鼠标
set mouse=

" 输入时禁用鼠标
set mousehide

" 设置正常使用退格键
set backspace=eol,start,indent

" 设置系统剪贴板
set clipboard=unnamed,unnamedplus

" 自动更改工作区
"set autochdir

" 设置 Leader 键
"let mapleader = "\<space>"

" }}}

" Edit {{{

" 关闭拼写检查
set nospell

" 开启文件类型检测和缩进检测
filetype indent plugin on

" 开启语法检测
syntax on

" 设置汇编语言高亮
augroup hlightasm
    au BufNewFile,BufRead *.asm set ft=masm
augroup END

"au insertLeave *.* write

" }}}

" Undo & Swap {{{

" 从外部改变文件时自动读取
set autoread

" 不备份原始文件
set nobackup
set nowritebackup
"set noswapfile

" 设置交换文件夹，使崩溃后能恢复文件
call mkdir($SWAP_PATH,"p")
set directory=$SWAP_PATH

"设置撤销文件夹，使文件二次编辑时也能撤销

set undofile
set undolevels=1000

call mkdir($UNDO_PATH,"p")
set undodir=$UNDO_PATH

" }}}

" Search {{{

" 对正则表达式启用魔术
set magic

" 搜索忽略大小写
set ignorecase

" 启用智能搜索
set smartcase

" 高亮搜索
set hlsearch

" 设置光标实时跳转到搜索到的内容
set incsearch

" 非递归映射，esc键取消搜索后的高亮
nnoremap <silent> <esc> :noh<return><esc>

" }}}

" Lang & Encoding {{{

" 去掉文件的BOM标头
set nobomb

" 设置UTF-8为标准编码和en_US为标准语言
set encoding=utf8
set fileencodings=ucs-bom,utf-8,default,cp936,big5,latin1

" 使用Unix作为标准文件类型
set fileformats=unix,mac,dos

" }}}

" UI {{{

" 设置字体
set guifont=FiraCode\ NF:h12

" 启动时不显示信息
set shortmess=atl

" 使用256色
set t_Co=256

" 设置光标不闪烁
set guicursor+=a:blinkon0

" 高亮命令栏
set cmdheight=1

" 高亮当前行
set cursorline

" 高亮当前列
"set cursorcolumn

" 显示行号
set number

" 设置行号为相对行号
set relativenumber

" 设置自动折行
set wrap

" 总是显示当前位置
set ruler

" 右下角显示正在输入的命令
set showcmd

" 命令补全时显示补全列表
set wildmenu

" 插入模式使用绝对行数，普通模式使用相对行数
augroup relative_number
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END

" 设置默认情况下光标始终处于屏幕中间
if !exists('noalwayscenter')
    " Calculate proper scrolloff
    autocmd VimEnter,WinEnter,VimResized,InsertLeave * :let &scrolloff = float2nr(floor(winheight(0)/2)+1)
    autocmd InsertEnter * :let &scrolloff = float2nr(floor(winheight(0)/2))
    " Use <Enter> to keep center in insert mode, need proper scrolloff
"    inoremap <CR> <CR><C-o>zz
endif

" 设置vim打开时自动跳转到上次退出的地方或者尾行
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 短暂显示括号匹配
set sm  " showmatch简写，输入右括号会跳到对应的括号处，闪动一下
set matchtime=1 "设置showmatch的闪动时间，单位是十分之一秒

" 添加尖括号到匹配项
set matchpairs+=<:> 

" }}}

" Cursor {{{

" 设置光标显示模式
set guicursor=n-v-ve-o-r:ver10,i-c-ci-cr-sm:ver10

" }}}

" Fold {{{

" vim 文件折叠方式
augroup ft_vim
    au!
    au Filetype vim setlocal foldmethod=marker
augroup END

" 代码折叠
" set foldmethod=indent
" set foldlevel=99

" }}}

" Indentation {{{
" 以下三个选项只启用一个，多个设置时会根据优先级覆盖，还有一个按表达式缩进，最灵活也是最高
" 优先级

" 自动缩进,优先级最低
"set autoindent

" 按照C语言调整缩进长度,需要使用 cinoptions 设置缩进风格 优先级高
"set cindent

" 智能缩进,优先级中等
set smartindent

set smarttab

" 使用空格代替制表符
set expandtab
" 如果用Tab缩进，则使用此设置缩进线
"set list lcs=tab:\|\

" 设置一缩进等于四空格
function Settab()
    if (&filetype==?"markdown" || &filetype==?"json" || &filetype==?"javascript" || &filetype==?"html" || &filetype==?"css")
        set shiftwidth=2
        set softtabstop=2
        set tabstop=2
    else
        set shiftwidth=4
        set softtabstop=4
        set tabstop=4
    endif
endfunction

autocmd BufEnter * :call Settab()

" }}}

" Plug {{{

call plug#begin($HOME."/AppData/Local/nvim/plugged")

Plug 'lifepillar/vim-gruvbox8'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'Yggdroot/indentLine'
Plug 'ironhouzi/nvim-colorizer.lua'

Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-lua/completion-nvim'

Plug 'justinmk/vim-sneak'
Plug 'Raimondi/delimitMate'

Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-operator-surround'

Plug 'mg979/vim-visual-multi',{'branch':'master'}

call plug#end()

" }}}

" Theme {{{

set termguicolors
"set background=dark

" 设置主题
colorscheme gruvbox8
" 主题背景不透明，这里手动设置背景透明，必须在主题后才生效
highlight Normal guibg=none ctermbg=none ctermfg=255
" 设置当前行的高亮，我设成透明的
hi CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
" 当前行透明不太好看当前行在哪，所以加了根下划线
"hi CursorLine cterm=underline gui=underline

" }}}

" lightline {{{

" 设置状态栏高度
"set laststatus=2

" 设置 256 色
if !has('gui_running')
    set t_Co=256
endif

" 显示标签栏
set showtabline=2

" 设置左下角不显示当前模式
set noshowmode


" 配置 lightline
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2"},
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3"},
    \ 'active': {
    \   'left': [ [ 'mode', 'paste'],
    \             [ 'filename', 'readonly', 'modified']
    \           ],
    \   'right': [ ['lineinfo'],
    \              ['percent'],
    \              ['fileformat', 'fileencoding', 'filetype']]
    \ },
    \ 'component': {
    \  'lineinfo': "\uf160". ' ' . '%3l:%-2c',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \ },
    \ 'tabline': {
    \   'left':[ ['buffers'] ],
    \   'right': [ ['close'] ]
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \},
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \},
    \ 'mode_map': {
    \   'n': 'N',
    \   'i': 'I',
    \   'R': 'R',
    \   'v': 'V',
    \   'V': 'VL',
    \   "\<C-v>": 'VB',
    \   'c': 'C',
    \   's': 'S',
    \   'S': 'SL',
    \   "\<C-s>": 'SB',
    \   't': 'T',
    \ },
    \ }

" 设置只读文件符号
function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction

" 刷新 nvim 配置文件
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup  END

" }}}

" Bufferline {{{

let g:lightline#bufferline#modified = " \uf040"

let g:lightline#bufferline#read_only = " \ufc71"

let g:lightline#bufferline#show_number = 2

let g:lightline#bufferline#composed_number_map = {
\ 1: "\uf303", 2: "\uf306", 3: "\uf30d", 4: "\uf30c", 5: "\uf314",
\ 6: "\uf30b", 7: "\uf316", 8: "\uf30e", 9: "\uf315", 10: "\uf300"}

let g:lightline#bufferline#unnamed = "\ue7c5"

let g:lightline#bufferline#unicode_symbols = 1

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <C-t> :tabnew split<CR>

nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>c0 <Plug>lightline#bufferline#delete(10)

" }}}

" IndentLine {{{

let g:indentLine_setColors = 0
let g:indentLine_char="\uf63d"
"let g:indentLine_char_list=[ '|','¦','┆','┊'] " 设置每个缩进级别使用不同字符
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char = "\uf63d"
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" }}}

" Colorizer {{{
lua require'colorizer'.setup()
" }}}

" Lspconfig {{{
lua << EOF
require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
EOF
" }}}

" Completion {{{

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_sorting = "length"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_matching_smart_case = 1
augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
augroup end
let g:completion_trigger_keyword_length = 2
" }}}

" Lspsaga {{{

lua require'lspsaga'.init_lsp_saga()

" Hover Doc
nnoremap <silent>K :Lspsaga hover_doc<CR>

" Async Lsp Finder
nnoremap <silent>gh :Lspsaga lsp_finder<CR>

" Code Action
noremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>



" SignatureHelp
nnoremap <silent>gs :Lspsaga signature_help<CR>

" Rename 
nnoremap <silent>gr :Lspsaga rename<CR>
" close rename win use <C-c> in insert mode or `q` in noremal mode or `:q`

" Preview Definition
nnoremap <silent>gd :Lspsaga preview_definition<CR>
" can use smart_scroll_with_saga to scroll

" Jump Diagnostic and Show Diagnostics
" show
nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
" jump diagnostic
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

" float terminal
nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>

"highlight link LspSagaFinderSelection Search 
" }}}

" Sneak {{{

map <Leader>s <Plug>Sneak_s
map <Leader>S <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" }}}

" DelimitMate {{{

let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_balance_matchpairs = 1
"let delimitMate_expand_inside_quotes = 1

au FileType markdown let b:delimitMate_nesting_quotes = ['`']
au FileType python let b:delimitMate_nesting_quotes = ['"']

imap <leader>g <Plug>delimitMateJumpMany

" }}}

" Operator Surround {{{
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
" }}}

" Markdown {{{

" 开启 markdown 文件中代码块语法高亮，需 VIM 较高版本
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'css', 'js=javascript']

" }}}

" Neovide {{{
let g:neovide_transparency=0.8
let g:neovide_no_idle=v:true
let g:neovide_cursor_animation_length=0.13
let g:neovide_cursor_trail_length=0.8
let g:neovide_cursor_antialiasing=v:true
let g:neovide_cursor_vfx_mode = "sonicboom"
" }}}

