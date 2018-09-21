set nu "设置行号

"set list "是否显示所有字符
set nowrap   "不换行
set shiftwidth=4  "默认缩进4个空格
set softtabstop=4  "使用tab时 tab空格数
set tabstop=4  "tab代表4个空格
set expandtab "tab自动转换为空格
"set nowrapscan "禁止循环查找
set modifiable
set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set history=400 "设置历史数目
" set cursorcolumn " 突出显示当前列
set cursorline "突出显示当前行
" autocmd InsertEnter * se cul "用浅色高亮当前行
" set showtabline=0 "关闭tab
set showcmd         "输入的命令显示出来，看的清楚些"
" 关闭交换文件
set noswapfile



"--搜索设置--
set hlsearch " 高亮度搜寻
set incsearch " 输入字符串就显示匹配点"
set ic "忽略大小写
set smartcase 
set title

" Remember info about open buffers on close
" set viminfo^=%

set fileformats=unix,dos

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""" color""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &bg == "dark"   " 根据你的背景色风格来设置不同的书签颜色
    highlight SignColor ctermfg=white ctermbg=blue guifg=wheat guibg=peru
else               " 主要就是修改guibg的值来设置书签的颜色
    highlight SignColor ctermbg=white ctermfg=blue guibg=grey guifg=RoyalBlue3
endif

if $TERM =~ '^xterm' || $TERM =~ '^screen' || $TERM=~ '256color$'
    set t_Co=256
    set background=dark
    colorscheme desert
    " colorscheme darkblue
elseif has('gui_running')
    set background=light
    colorscheme solarized
elseif $TERM =~ 'cons256'
    colorscheme default
endif
" colorscheme evening  "颜色模式
" colorscheme molokai "颜色模式
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0
" colorscheme desert
" colorscheme wombat256mod
" colorscheme solarized
" set background=dark
" colorscheme github

"通过两次<Esc>来刷新当前界面，这样可以去除高亮显示
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>!

"通过*和#来查找 高亮选中区域
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" set foldenable              " 开始折叠
" set foldmethod=syntax       " 设置语法折叠
" set foldcolumn=0            " 设置折叠区域的宽度
" setlocal foldlevel=1        " 设置折叠层数为

"设置当正在编辑的文件被外部的其它程序所修改后自动在Vim加载 
set autoread
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

set autowrite "在切换buffer时自动保存当前文件
set scrolloff=7 "光标移动到buffer的顶部和底部时保持3行的距离

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
" set relativenumber number
" au FocusLost * :set norelativenumber number
" au FocusGained * :set relativenumber
" " 插入模式下用绝对行号, 普通模式下用相对
" autocmd InsertEnter * :set norelativenumber number
" autocmd InsertLeave * :set relativenumber
" function! NumberToggle()
"   if(&relativenumber == 1)
"     set norelativenumber number
"   else
"     set relativenumber
"   endif
" endfunc
" nnoremap <C-n> :call NumberToggle()<cr>


" let mapleader=","
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
" let g:mapleader=","
" noremap \ , "用\来完成反向查找


nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
vmap <Leader>y "zy
vmap <Leader>d "zd
nmap <Leader>p "zp
nmap <Leader>P "zP
vmap <Leader>p "zp
vmap <Leader>P "zP
vmap <Leader>Y "Zy
vmap <Leader>D "Zd
nmap <Leader><Leader>d :call setreg('z', '')<CR>

"在命令行窗口使用<c-p> <c-n>来回溯历史命令
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""" Initial Plugin 加载插件""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif
filetype plugin indent on

"syctastic plugin
" configure syntastic syntax checking to check on open as well as save
" let g:syntastic_check_on_open=1
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_wq = 0
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" 自动对齐
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a\ :Tabularize /\<CR>
vmap <Leader>a\ :Tabularize /\<CR>

" nnoremap <leader>ri :RunInInteractiveShell<space>

"incsearch.vim 高亮选择的内容
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

" 快速移动
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F']
" let g:qs_first_occurrence_highlight_color = 155       " terminal vim
" let g:qs_second_occurrence_highlight_color = 81         " terminal vim
" Map the leader key + q to toggle quick-scope's highlighting in normal/visual mode.
" Note that you must use nmap/vmap instead of their non-recursive versions (nnoremap/vnoremap).
nmap <leader>f <plug>(QuickScopeToggle)
vmap <leader>f <plug>(QuickScopeToggle)

"ctrlp 模糊查找
if executable('ag')
  " Use Ag over Grep
  echo "########################"
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" Bind C-k for Clear all cache and open CtrlP
" nnoremap <silent> <C-k> :ClearAllCtrlPCache<CR>\|:CtrlP<CR>

"grep插件
let g:EasyGrepMode = 0     " All:0, Open Buffers:1, TrackExt:2, 
let g:EasyGrepCommand = 0  " Use vimgrep:0, grepprg:1
let g:EasyGrepRecursive  = 1 " Recursive searching
let g:EasyGrepIgnoreCase = 1 " not ignorecase:0
let g:EasyGrepFilesToExclude = "*.bak, *~, cscope.*, *.a, *.o, *.pyc, *.bak, .git, tags, *.tar.gz"
nmap <Leader>vu :ReplaceUndo<CR> 


" "config ctrlspace
" noremap <silent> <C-m> :CtrlSpace<CR>
" let g:CtrlSpaceSearchTiming = 500
" if executable("ag")
"     let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
" endif
" let g:airline_exclude_preview = 1
" " hi link CtrlSpaceSearch IncSearch
" hi CtrlSpaceSelected guifg=#586e75 guibg=#eee8d5 guisp=#839496 gui=reverse,bold ctermfg=10 ctermbg=7 cterm=reverse,bold
" hi CtrlSpaceNormal   guifg=#839496 guibg=#021B25 guisp=#839496 gui=NONE ctermfg=12 ctermbg=0 cterm=NONE
" hi CtrlSpaceSearch   guifg=#cb4b16 guibg=NONE gui=bold ctermfg=9 ctermbg=NONE term=bold cterm=bold
" hi CtrlSpaceStatus   guifg=#839496 guibg=NONE gui=NONE term=reverse cterm=NONE ctermfg=12 ctermbg=0
" let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
" let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
" let g:CtrlSpaceSaveWorkspaceOnExit = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"book mark
let g:NERDTreeShowBookmarks = 1


"PowerLine插件 状态栏增强展示
set laststatus=2 "vim有一个状态栏 加上powline则有两个状态栏
set t_Co=256
let g:Powline_symbols='fancy'

"taglist配置
let Tlist_Ctags_Cmd='ctags'
let Tlist_Show_One_File=1               "不同时显示多个文件的tag，只显示当前文件的
let Tlist_WinWidt =28                    "设置taglist的宽度
let Tlist_Exit_OnlyWindow=1             "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window=1            "在右侧窗口中显示taglist窗口
let Tlist_Use_Left_Window =1                "在左侧窗口中显示taglist窗口

let g:tagbar_ctags_bin='ctags'            "ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
let g:tagbar_left = 1
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
map <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=./tags;
" set tags=./multimediad.tags;
" set tags=./multimedia.tags;
" set tags+=./npm.tags;
" set tags+=./caf2.tags;
map <F3> :Tagbar<CR>
map <F4> :tp<CR>
map <F6> :tn<CR>


" let OmniCpp_NamespaceSearch = 1
" let OmniCpp_GlobalScopeSearch = 1
" let OmniCpp_DisplayMode = 1
" let OmniCpp_ShowAccess = 1
" let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
" let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
" let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
" let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
" let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" " 自动关闭补全窗口
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" set completeopt=menuone,menu,longest
" highlight Pmenu    guibg=darkgrey guifg=black
" highlight PmenuSel guibg=lightgrey guifg=black
" mapping
" inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
" inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
" inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
" inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"


" let g:SuperTabRetainCompletionType=1
" let g:SuperTabDefaultCompletionType="context"
"0 - 不记录上次的补全方式
"1 - 记住上次的补全方式,直到用其他的补全命令改变它
"2 - 记住上次的补全方式,直到按ESC退出插入模式为止


let NERDTreeWinPos='left'
let NERDTreeWinSize=30
"NERDTree-Tabs
let g:nerdtree_tabs_open_on_console_startup=1 "设置打开vim的时候默认打开目录树"
map <F2> :NERDTreeToggle<CR>


" -- MiniBufferExplorer --
let g:miniBufExplMapWindowNavVim = 1 " 按下Ctrl+h/j/k/l，可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapWindowNavArrows = 1 " 按下Ctrl+箭头，可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapCTabSwitchBufs = 1 " 启用以下两个功能：Ctrl+tab移到下一个buffer并在当前窗口打开；Ctrl+Shift+tab移到上一个buffer并在当前窗口打开；ubuntu好像不支持
let g:miniBufExplMapCTabSwitchWindows = 1 " 启用以下两个功能：Ctrl+tab移到下一个窗口；Ctrl+Shift+tab移到上一个窗口；ubuntu好像不支持
let g:miniBufExplModSelTarget = 1    " 不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer
let g:miniBufExplMoreThanOne=0
" MiniBufExpl Colors
" hi MBENormal               guifg=#808080 guibg=fg
" hi MBEChanged              guifg=#CD5907 guibg=fg
" hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
" hi MBEVisibleChanged       guifg=#F1266F guibg=fg
" hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
" hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg
" map <F11> :MBEbp<CR>
" map <F12> :MBEbn<CR>
" 切换前后buffer
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>
nnoremap <Leader>bd :bdelete
" 使用方向键切换buffer
" noremap <left> :bprevious<CR>
" noremap <right> :bnext<CR>


" quickfix窗口映射
noremap <F7> :cprev<CR>
noremap <F8> :cnext<CR>
nnoremap <Leader>fc :cclose<CR>
nnoremap <Leader>fo :copen<CR>
nnoremap <Leader>ff :cfirst<CR>
nnoremap <Leader>fl :clast<CR>
nnoremap <Leader>fp :cprev<CR>
nnoremap <Leader>fn :cnext<CR>
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K

"为 terryma/vim-expand-region 做映射
"按一次 v 选择一个字符。
"再按一次 v 自动扩展选择一个单词。
"再按一次 v 自动扩展选择一段代码。
"…
"以此类推…
"按<C-v> 回退上一次的选择操作
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

augroup vimrcEx
    autocmd!
    "删除行尾空格, \s 表示空格，\转义，+表示有1个以上，$行尾
    autocmd FileType c,cc,h,cpp,python,ruby,java,sh,html,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END

"通过%%就可以插入文件名
cnoremap <expr> %% getcmdtype(  ) == ':' ? expand('%:h').'/' : '%%'

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"Treat long lines as break lines (useful when moving around in them)
"se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" F10 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F10> :call HideNumber()<CR>

" when in insert mode, press <F5> to go to
" paste mode, where you can paste mass data
" that won't be autoindented
set pastetoggle=<F9>
" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" F12 换行开关
nnoremap <F12> :set wrap! wrap?<CR>

" F5 set paste问题已解决, 粘贴代码前不需要按F5了
" F5 粘贴模式paste_mode开关,用于有格式的代码粘贴
" Automatically set paste mode in Vim when pasting in insert mode
" it's not working for me, why???
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunc
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" Go to home and end using capitalized directions
noremap H ^
noremap L $

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" select all
map <Leader>sa ggVG
map <Leader>sy ggVGy

" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" kj 替换 Esc
" inoremap kj <Esc>
" map jj to <Esc> is easy for us
inoremap jj <Esc>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Map ; to : and save a million keystrokes 用于快速进入命令行
" nnoremap ; :
" 为了保留;的正向查找功能，把\映射为;
" nnoremap \ ;


" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>"

" 搜索相关
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" 进入搜索Use sane regexes"
nnoremap / /\v
vnoremap / /\v

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" tab 操作
" tab切换
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>
map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm
map <leader>to :tabnew<cr>
" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
" nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr>
" nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
" vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()
" 新建tab  Ctrl+t
" nnoremap <C-t>     :tabnew<CR>
" inoremap <C-t>     <Esc>:tabnew<CR>

set mouse=a

nnoremap <leader>v "+gp
imap <leader>v  <esc>"+gp"
vmap <leader>c "+y
