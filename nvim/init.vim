" Start {{{

" 判断是否存在插件管理器，没有就安装
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
endif

set matchpairs+=<:> " 添加尖括号到匹配项
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
set autochdir

" }}}

" Edit {{{

" 关闭拼写检查
set nospell

" 开启文件类型检测和缩进检测
filetype indent plugin on

" 开启语法检测
syntax on

" }}}

" Undo & Swap {{{

" 从外部改变文件时自动读取
set autoread

" 不备份原始文件
set nobackup
set nowritebackup

" 设置交换文件夹，使崩溃后能恢复文件
call mkdir($HOME."/.local/share/nvim/swapfiles","p")
set dir=$HOME/.local/share/nvim/swapfiles//
" 设置撤销文件夹，使文件二次编辑时也能撤销
set undofile
set undolevels=1000

call mkdir($HOME."/.local/share/nvim/undotree","p")
set undodir=$HOME/.local/share/nvim/undotree//

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
set fileformats=unix,mac

" }}}

" UI {{{

" 设置字体
"set guifont=Fantasque\ Sans\ Mono:h10

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
    inoremap <CR> <CR><C-o>zz
endif

" 设置vim打开时自动跳转到上次退出的地方或者尾行
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 短暂显示括号匹配
set sm  " showmatch简写，输入右括号会跳到对应的括号处，闪动一下
set matchtime=1 "设置showmatch的闪动时间，单位是十分之一秒

" }}}

" Cursor {{{

" 设置光标显示模式
set guicursor=n-v-ve-o-r:hor10,i-c-ci-cr-sm:ver10

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

" 设置缩进线
set list lcs=tab:\|\ 
"let g:indentLine_char_list=[ '|','¦','┆','┊'] " 设置每个缩进级别使用不同字符

" }}}

" Plug {{{

call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim',{'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'iamcco/markdown-preview.nvim',{ 'do': 'cd app & yarn install'  }
Plug 'dkarter/bullets.vim'
"Plug 'SidOfc/mkdx',{'for':'markdown'}
"Plug 'Scuilion/markdown-drawer',{'for': 'markdown'}
Plug 'voldikss/vim-floaterm'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'morhetz/gruvbox'
Plug 'hardcoreplayers/gruvbox9'

call plug#end()

" }}}

" Theme {{{

set termguicolors
set background=dark

let g:gruvbox_filetype_hi_groups = 1

let g:gruvbox_italic = 1

let g:gruvbox_italicize_strings = 1

let g:gruvbox_plugin_hi_groups = 1

let g:gruvbox_transp_bg = 1
    
" 设置主题
colorscheme gruvbox9
" dracula 主题背景不透明，这里手动设置背景透明，必须在主题后才生效
"highlight Normal guibg=none ctermbg=none
" 设置当前行的高亮，我设成透明的
hi CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
" 当前行透明不太好看当前行在哪，所以加了根下划线
hi CursorLine cterm=underline gui=underline

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
    \ 'colorscheme': 'ayu_mirage',
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2"},
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3"},
    \ 'active': {
    \   'left': [ [ 'mode', 'paste','status'],
    \             [ 'filename', 'cocstatus', 'readonly', 'modified'],
    \             ['blame'] ],
    \   'right': [ ['lineinfo'],
    \              ['percent'],
    \              ['fileformat', 'fileencoding', 'filetype']]
    \ },
    \ 'component': {
    \  'lineinfo': "\uf160". ' ' . '%3l:%-2c',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'cocstatus': 'StatusDiagnostic',
    \   'status': 'LightlineGitStatus',
    \   'blame': 'LightlineGitBlame'
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

" 集成 Coc 消息后，刷新 lightline
autocmd User CocStatusChange,CocDiagnosticChange,CocGitStatusChange call lightline#update()

" 设置只读文件符号
function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction

" 集成 Coc-git 传递的文件版本信息
function! LightlineGitStatus() abort
  let status = get(g:,'coc_git_status','') . get(b:,'coc_git_status','') 
  " return blame
  return status
endfunction

" coc-git 传递的当前行的变动信息说明
function! LightlineGitBlame() abort
  let blame = get(b:,'coc_git_blame','') 
  " return blame
  return blame
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return "\uf0e7". ' ' .'0' . ' ' . "\uf12a" . ' ' . '0' | endif
  let msgs = []
  let ems = "\uf0e7".' '.'0'
  let wms = "\uf12a". ' ' . '0'

  if get(info, 'error', 0)
    let ems = "\uf0e7" . ' ' . info['error']
  endif
  if get(info, 'warning', 0)
    let wms = "\uf12a" . ' ' . info['warning']
  endif
  call add(msgs, ems)
  call add(msgs, wms)
  return join(msgs, ' ')
endfunction

" 刷新 nvim 配置文件
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup  END

" }}}

" Bufferline {{{

"let g:lightline#bufferline#modified = " \uf040"

"let g:lightline#bufferline#read_only = " \ufc71"

let g:lightline#bufferline#show_number = 2

let g:lightline#bufferline#composed_number_map = {
\ 1: "\uf303", 2: "\uf306", 3: "\uf30d", 4: "\uf30c", 5: "\uf314",
\ 6: "\uf30b", 7: "\uf316", 8: "\uf30e", 9: "f315", 10: "f300"}

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

" Bullets {{{

let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \ ]

let g:bullets_enabled_in_empty_buffers = 1

let g:bullets_pad_right = 0

" }}}

" Markdown {{{

" 开启 markdown 文件中代码块语法高亮，需 VIM 较高版本
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'css', 'js=javascript']

" }}}

" Coc {{{

" 设置 Coc 全局插件，启动时不存在的插件会自动安装
let g:coc_global_extensions =[
    \ 'coc-explorer',
    \ 'coc-lists',
    \ 'coc-git',
    \ 'coc-zi',
    \ 'coc-pairs',
    \ 'coc-json',
    \ 'coc-emmet',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-prettier',
    \ 'coc-phpls',
    \ 'coc-vimlsp',
    \ 'coc-sh',
    \ ]

" 设置文件类型映射字典
let g:coc_filetype_map = {
    \ 'html.swig': 'html',
    \ 'wxss': 'css',
    \ }

" 设置 Coc status 中错误的字符
let g:coc_status_error_sign = "\uf00d"
" 设置 Coc status 中警告的字符
let g:coc_status_warning_sign = "\uf12a"

"如果不设置隐藏，文本编辑可能失效
set hidden

"设置更新时间，默认4s，时间太长会导致延迟
set updatetime=300

"不将信息发送到完成菜单
set shortmess+=c

"始终显示标志列
"set signcolumn=yes

"设置 TAB 键选择补全，shift-TAB反向选择
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

"使用 <CR> 确认补全，并触发 coc.nvim 的 `formatOnType` 功能: >
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 当只有一个补全项时 tab 键选择并完成补全,且格式化代码
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 补全完成后关闭预览窗口
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" 跳转到上一个错误处
nmap <silent> [g <Plug>](coc-diagnostic-prev)
" 跳转到下一个错误处
nmap <silent> [g <Plug>](coc-diagnostic-next)
" 跳转到定义
nmap <silent> gd <Plug>(coc-definition)
" 跳转到类型定义
nmap <silent> gy <Plug>(coc-type-definition)
" 跳转到实现
nmap <silent> gi <Plug>(coc-implementation)
" 跳转到引用
nmap <silent> gr <Plug>(coc-references)
" 如果是 vim或帮助文件,在当前字符上按 K 会显示当前 位置的悬浮信息
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], $filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" 重命名光标所在位置符号
nmap <leader>rn <Plug>(coc-rename)

" 可视化和选择模式下格式化选中的区间
vmap <leader>f <Plug>(coc-format-selected)
" 普通模式下格式化选中的区间
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    autocmd Filetype typescript,json setl formatexpr=CocAction('formatSelected')
    " 跳转到占位符后自动显示函数签名
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 可视化和普通模式下，获取并执行语言服务器给出的当前选中区域的可用操作
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" 普通模式下，获取并执行语言服务器给出的当前缓冲区的可用操作
nmap <leader>ac  <Plug>(coc-codeaction)
" 普通模式下，修复当前行可修复的第一个错误
nmap <leader>qf  <Plug>(coc-fix-current)


" 可视模式下选中当前所在函数内的所有行
xmap if <Plug>(coc-funcobj-i)
" 可视模式下选中当前所在函数的所有区间
xmap af <Plug>(coc-funcobj-a)
" 操作符等待模式下选中当前所在函数内的所有行，配合操作符快速操作函数
omap if <Plug>(coc-funcobj-i)
" 操作符等待模式下选中当前所在函数的所有区间
omap af <Plug>(coc-funcobj-i)

" 普通模式下选择下一个可选区域，仅部分语言服务支持
"nmap <silent> <TAB> <Plug>(coc-range-select)
" 可视模式下选择下一个可选区域，仅部分语言服务支持
"xmap <silent> <TAB> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Format :call CocAction('fold',<f-args>)
command! -nargs=0 OR :call CocAction('runCommand','editor.action.organizeImport')
command! -nargs=0 Prettier :CocCommand prettier.formatFile



" }}}

" Coc-lists {{{


" 打开错误信息列表
nnoremap <silent> <space>w :<C-u>CocList words<cr>
" 打开错误信息列表
nnoremap <silent> <space>e :<C-u>CocList diagnostics<cr>
" 打开当前文档链接列表
nnoremap <silent> <space>a :<C-u>CocList links<cr>
" 打开可用源列表
nnoremap <silent> <space>s :<C-u>CocList sources<cr>
" 打开 Coclist
nnoremap <silent> <space>d :<C-u>CocList <cr>
" 打开当前项目内符号列表
nnoremap <silent> <space>f :<C-u>CocList symbols<cr>
" 打开当前缓冲区大纲，当没有对 lsp 提供 symbols 功能时使用 ctags 生成
nnoremap <silent> <space>g :<C-u>CocList outline<cr>
" 打开翻译列表，由coc-zi插件提供的
nnoremap <silent> <space>h :<C-u>CocList translators<cr>
" 打开最近跳转列表
nnoremap <silent> <space>l :<C-u>CocList location<cr>

nnoremap <silent> <space>j :<C-u>CocNext<cr>
nnoremap <silent> <space>k :<C-u>CocPrev<cr>
nnoremap <silent> <space>r :<C-u>CocListResume<cr>

" }}}

" Coc-explorer {{{

nnoremap <silent> <C-e> :CocCommand explorer<CR>

" }}}

" Coc-git {{{
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
" }}}

" Coc-pairs {{{
" autocmd FileType tex let b:coc_pairs = [["$", "$"]]
"
" autocmd FileType markdown let b:coc_paors_disabled = ["`"]
" }}}

