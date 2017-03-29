" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

let $VIMRUNTIME="/usr/share/vim/vim74"  
set runtimepath=/usr/share/vim/vim74

if getfsize("vimscript")>0
    source   vimscript
endif 

"autocmd ColorScheme * hi Sneak guifg=black guibg=yellow ctermfg=96 ctermbg=black
autocmd ColorScheme * hi Sneak guifg=black guibg=yellow ctermfg=211 ctermbg=black

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

syntax on                   " 自动语法高亮
set nocp
set number                  " 显示行号
set cursorline              " 突出显示当前行
set cul
"autocmd InsertEnter * se cul " 用浅色高亮当前行
set ruler                   " 打开状态栏标尺
set shiftwidth=4            " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4           " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4               " 设定 tab 长度为 4
set nobackup                " 覆盖文件时不备份
set autochdir               " 自动切换当前目录为当前文件所在的目录
"filetype plugin on
filetype plugin indent on   " 开启插件
set backupcopy=yes          " 设置备份时的行为为覆盖
"set ignorecase smartcase    " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan              " 禁止在搜索到文件两端时重新搜索
set incsearch               " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本
set magic                   " 设置魔术
set smartindent             " 开启新行时使用智能自动缩进
set expandtab               " 用space替代tab的输入
set relativenumber
"set foldmethod=syntax

set showtabline=2

inoremap jj <Esc>
inoremap jk <Esc>:w<CR>
let mapleader=","

"""""""""""""""""""""Format""""""""""""""""""""""""""""""
"inoremap ( ()<ESC>i
"inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap { {}<ESC>i
"inoremap } <c-r>=ClosePair('}')<CR>
"inoremap [ []<ESC>i
"inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap < <><ESC>i
"inoremap > <c-r>=ClosePair('>')<CR>
           
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "<Right>"
    else
        return a:char
    endif
endfunction

let g:clang_close_preview=1


fun! DeleteAllBuffersInWindow()
    let s:curWinNr = winnr()
    if winbufnr(s:curWinNr) == 1
        ret
    endif
    let s:curBufNr = bufnr("%")
    exe "bn"
    let s:nextBufNr = bufnr("%")
    while s:nextBufNr != s:curBufNr
        exe "bn"
        exe "bdel ".s:nextBufNr
        let s:nextBufNr = bufnr("%")
    endwhile
endfun
map <leader>bda     :call DeleteAllBuffersInWindow()

"""""""""""""""""""""""python""""""""""""""""""""""""
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1


"""""""""""""""""""""Hot Key""""""""""""""""""""""
nmap <Leader>aa :A<CR>
nmap <Leader>w :w<CR>

"""""""""""""""""""""Only For 17CY""""""""""""""""""""""
nmap <Leader>e /\v<error>\C<CR>
"nmap <Leader>w /\v<warning>\C<CR>
"nmap <Leader>w :cd /home/guanzx/w_17cy/<CR>:wa<CR>:make libTraffic-navi snod -j8<CR>:cw<CR><C-O><C-W>j<Leader>e
nmap <Leader>m :cd /home/guanzx/17cy/<CR>:wa<CR>:make libTraffic-navi snod -j8<CR>:cw<CR><C-O><C-W>j<Leader>e
nmap <Leader>t :cd /home/guanzx/17cy/<CR>:wa<CR>:make libTraffic-navi-test -j8<CR>:cw<CR><C-O><C-W>j<Leader>e
nmap <Leader>p :cd /mass/workspace/DM001/<CR>:wa<CR>:make -j8<CR>:cw<CR><C-O><C-W>j<Leader>e
nmap <Leader>df :cd /mass/workspace/DM001_1s/<CR>:wa<CR>:make libvsdecoder-pdr -j8<CR>:cw<CR><C-O><C-W>j<Leader>e
nmap <Leader>ee :cd /mass/workspace/DM001_1s/<CR>:wa<CR>:make rtpServer -j8<CR>:cw<CR><C-O><C-W>j<Leader>e
nmap <Leader>te :cd /mass/workspace/16tmap_DemoPJ/<CR>:wa<CR>:make libvsencoder -j8<CR>:cw<CR><C-O><C-W>j<Leader>e
nmap <Leader>tt :cd /mass/workspace/16tmap_DemoPJ/<CR>:wa<CR>:make vpudec_tool -j8<CR>:cw<CR><C-O><C-W>j<Leader>e
nmap <Leader>t2 :cd /mass/workspace/17cyt1t2stable/<CR>:wa<CR>:make libTraffic-navi -j8<CR>:cw<CR><C-O><C-W>j<Leader>e

"nmap <Leader>v :cd /home/17cy/<CR>:wa<CR>:make libTraffic-navi snod -j8<CR>:cw<CR><C-O><C-W>j<Leader>e

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"""""""""""""""""""""cscope""""""""""""""""""""""
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>ll :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR> 
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" set cst
set csto=0
set nocsre


"""""""""""""""""""CCTree""""""""""""""""""""""""""""""
"let g:CTreeCscopeDb = "/home/guanzx/17cy/framework/service/navi/src/traffic/cscope.out"
"let g:CCTreeRecursiveDepth = 3
"let g:CCTreeMinVisibleDepth = 3






"""""""""""""""""""Ctags""""""""""""""""""""""""""""""
"--c++-kinds=+p : 为标签添加函数原型(prototype)信息
"--fields=+iaS : 为标签添加继承信息(inheritance)，访问控制(access)信息，函数特征(function Signature,如参数表或原型等)
"--extra=+q : 为类成员标签添加类标识
"nnoremap <f5> :cd /home/nfs/guanzx/17cy/framework/service/navi/src/traffic<CR>:!ctags -R --c++-kinds=+p --fields=+liaS --extra=+q<CR>:cd -<CR>
"nnoremap <f5> :cd /home/guanzx/17cy/framework/service/navi/src/traffic<CR>:!ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q --language-force=c++<CR>:!cscope -Rbkq<CR>:!cscope add cscope.out<CR>:cd -<CR>
"nnoremap <f5> :cd /home/guanzx/17cy/framework/service/navi/src/traffic<CR>
"                \:!ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q --language-force=c++<CR>
"                \:!cscope -Rbkq<CR>:cs reset<CR><CR>
"                "\:!cscope add cscope.out<CR>:cd -<CR>
nnoremap <f5> :cd /home/guanzx/17cy/framework/service/navi/src/traffic<CR>:!ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q --language-force=c++<CR>
                \:!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR> 
                \:!cscope -b -i cscope.files -f cscope.out<CR>
                \:cs reset<CR>
                \:!cscope add cscope.out<CR>
                \:cd -<CR>

set cscopeverbose 
" 设置tags路径,自动加载个人tags
set tags+=./tags  
set tags+=../tags  
set tags+=../../tags
set tags+=../../../tags
set tags+=../../../../tags
set tags+=../../../../../tags
set tags+=../../../../../../tags
"set tags+=/home/guanzx/17cy/framework/service/navi/src/traffic/tags
"set tags+=/home/navicloud/.vim/tags/base_tags
"set tags+=/home/navicloud/.vim/tags/cpp_tags
":set csprg=/home/local/bin/cscope



""""""""""""""""""molokai color scheme"""""""""""""""""""
set t_Co=256
"colorscheme molokai
colorscheme wombat256mod
"colorscheme solarized
"color molokai
"color desert
"colorscheme freyr
"colorschem solarized
"colorschem lucius
"colorschem lucius2



""""""""""""""""""NERD tree"""""""""""""""""""""""""""""""
map <f8> :NERDTreeToggle<cr>


""""""""""""""""""tag bar"""""""""""""""""""""""""""""""
nmap <f7> :TagbarToggle<CR>
highlight TagbarHighlight guifg=Green ctermfg=Green
let g:tagbar_autofocus = 1


""""""""""""""""""tag list"""""""""""""""""""""""""""""""
"map <f7> :Tlist<cr>
"let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
"let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口"
"let Tlist_WinWidth = 45
"
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'


""""""""""""""""""""""""""ctrlp"""""""""""""""""""""""""""
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
"let g:ctrlp_working_path_mode=0
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=1
"let g:ctrlp_mruf_max=500
"let g:ctrlp_follow_symlinks=1


"map <F6> :CtrlPFunky<cr>
nnoremap <Leader>fu :CtrlPFunky<Cr> 



""""""""""""""""""""""""air line"""""""""""""""""""""""""""
set laststatus=2

map gt :bn<cr>
map gT :bp<cr>
map gc :bd<cr>

"let g:airline#extensions#hunks#enabled=0
let g:airline_powerline_fonts = 1
"let g:airline_section_b = '%{strftime("%c")}'
"let g:airline_section_y = 'BN: %{bufnr("%")}'

let g:airline#extensions#tavline#enabled = 1
"let g:airline#extensions#branch#displayed_head_limit = 10

" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#tagbar#enabled = 1

let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 1
"enable/disable displaying tabs, regardless of number. >
"let g:airline#extensions#tabline#show_tabs = 1
"configure how numbers are displayed in tab mode. >
"let g:airline#extensions#tabline#tab_nr_type = 1 " splits and tab number
"enable/disable displaying tab number in tabs mode. >
"let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#formatter = 'unique_tail'
"configure whether buffer numbers should be shown. >
"let g:airline#extensions#tabline#buffer_nr_show = 0
""configure how buffer numbers should be formatted with |printf|. >
"let g:airline#extensions#tabline#buffer_nr_format = '%s: '
""configure the formatting of filenames (see |filename-modifiers|). >
"let g:airline#extensions#tabline#fnamemod = ':p:.'
""configure collapsing parent directories in buffer name. >
"let g:airline#extensions#tabline#fnamecollapse = 1
"
"let g:airline#extensions#csv#enabled = 0
"let g:airline#extensions#hunks#enabled = 0
"let g:airline#extensions#virtualenv#enabled = 1

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create_left(['branch','hunks'])
    let g:airline_section_c = airline#section#create(['%f'])
    let g:airline_section_y = 'BN: %{bufnr("%")}'
    let g:airline_section_z = airline#section#create(['%P',':','%4l',',','%3c'])
endfunction
autocmd VimEnter * call AirlineInit()

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_theme = 'powerlineish'


""""""""""""""""""""ListToggle""""""""""""""""""""""""""""""
"let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
"let g:lt_height = 10


""""""""""""""""""" OmniCppComplete""""""""""""""""""""""""
let g:acp_enableAtStartup = 1 
let g:acp_completeoptPreview = 1
let g:acp_ignorecaseOption = 1
" 
let OmniCpp_ShowAccess = 1
"-- omnicppcomplete setting -- 
let OmniCpp_MayCompleteDot = 1 
" autocomplete with . 
let OmniCpp_MayCompleteArrow = 1 
" autocomplete with -> 
let OmniCpp_MayCompleteScope = 1 
" autocomplete with :: 
" let OmniCpp_SelectFirstItem = 2 xx 
" select first item (but don't insert)
let OmniCpp_ShowPrototypeInAbbr = 1 
" show function prototype in popup window 
let OmniCpp_GlobalScopeSearch = 1 
let OmniCpp_DisplayMode = 1 
let OmniCpp_MayCompleteScope = 1
" 
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "traffic"]
" 
set completeopt=menu,menuone,longest
"set completeopt+=longest
highlight Pmenu    guibg=darkgrey  guifg=black
highlight PmenuSel guibg=lightgrey guifg=black


"""""""""""""""""""Clang Complete""""""""""""""""""""""""""
"let g:clang_complete_copen=1
"let g:clang_periodic_quickfix=1
"let g:clang_snippets=1
"let g:clang_close_preview=1
"let g:clang_use_library=1
"let g:clang_user_options='-stdlib=libc++ -std=c++11 -IIncludePath'
"
"let g:clang_library_path="/usr/local/lib"

"""""""""""""""""""YouCompleteMe"""""""""""""""""""""""""""
"设置全局配置文件的路径  
"let g:ycm_global_ycm_extra_conf = '/home/navicloud/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '/home/guanzx/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_global_ycm_extra_conf = '/home/guanzx/17cy/framework/service/navi/src/.ycm_extra_conf.py' 
""开启基于tag的补全，可以在这之后添加需要的标签路径  
"let g:ycm_collect_identifiers_from_tags_files = 1  
"开启语义补全  
"let g:ycm_seed_identifiers_with_syntax = 1  
"在接受补全后不分裂出一个窗口显示接受的项  
"set completeopt-=preview  
"不显示开启vim时检查ycm_extra_conf文件的信息  
let g:ycm_confirm_extra_conf=0  
"每次重新生成匹配项，禁止缓存匹配项  
"let g:ycm_cache_omnifunc=0  
"在注释中也可以补全  
"let g:ycm_complete_in_comments=2  
"语法关键字补全         
"let g:ycm_seed_identifiers_with_syntax=1
"输入第一个字符就开始补全  
"let g:ycm_min_num_of_chars_for_completion=1  
"不查询ultisnips提供的代码模板补全，如果需要，设置成1即可  
"let g:ycm_use_ultisnips_completer=0 
let g:ycm_enable_diagnostic_highlighting = 0

let g:ycm_python_binary_path = '/usr/bin/python2.7/'
let g:clang_library_path = '/usr/lib/'

"let g:syntastic_always_populate_loc_list = 1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <leader>jd :YcmCompleter GoTo<CR>
nmap <F3> :YcmDiags<CR>


""""""""""""""""""""""""ycm_simple_conf"""""""""""""""""""""""


""""""""""""""""""""""""Syntastic"""""""""""""""""""""""
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_cpp_check_header = 1
"let g:syntastic_cpp_auto_refresh_includes = 1
"let g:syntastic_cpp_include_dirs = ['/home/navicloud/17cy/framework/service/navi/src/']
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_remove_include_errors = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0


"""""""""""""""""""""""Rainbow Parenthese""""""""""""""""
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
"au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"""""""""""""""""""""""gitgutter"""""""""""""""""""""""""
let g:gitgutter_override_sign_column_highlight = 1
let g:gitgutter_max_signs = 50000
nmap ]f <Plug>GitGutterNextHunk
nmap [f <Plug>GitGutterPrevHunk


"""""""""""""""""""""""easymotion""""""""""""""""""""""""
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=gray


"""""""""""""""""""""""sneak""""""""""""""""""""""""
nmap m <Plug>Sneak_s
nmap M <Plug>Sneak_S
xmap m <Plug>Sneak_s
xmap M <Plug>Sneak_S
omap m <Plug>Sneak_s
omap M <Plug>Sneak_S



"""""""""""""""""""""""cpp.vim""""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1


"""""""""""""""""""""""vim-easy-align""""""""""""""""""""""""
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String']  }


"""""""""""""""""""""""Goyo""""""""""""""""""""""""
nnoremap <Leader><Leader>d :Goyo<CR>


"""""""""""""""""""""""vim-expand-region""""""""""""""""""""""""
map <C-k> <Plug>(expand_region_expand)
map <C-j> <Plug>(expand_region_shrink)


"""""""""""""""""""""""incsearch""""""""""""""""""""""""
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)


"""""""""""""""""""""""VimIM""""""""""""""""""""""""
let g:vimim_cloud = 'sogou,qq'
let g:vimim_shuangpin = 'ms' 
"let g:vimim_map = 'tab_as_gi'  



"""""""""""""""""""""""SrcExpl.vim""""""""""""""""""""""""
" // The switch of the Source Explorer 
nmap <Leader>v :SrcExplToggle<CR>

" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 10 

" // Set 100 ms for refreshing the Source Explorer 
" let g:SrcExpl_refreshTime = 100 

" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 

" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 

" // In order to avoid conflicts, the Source Explorer should know what plugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
                \ "_NERD_tree_" 
                    \  ]

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update the tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 

" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<F12>" 

" // Set "<F3>" key for displaying the previous definition in the jump list 
" let g:SrcExpl_prevDefKey = "<F3>" 

" // Set "<F4>" key for displaying the next definition in the jump list 
" let g:SrcExpl_nextDefKey = "<F4>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F4 compile and run
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F4> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'python'
        exec "!python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!time go run %"
    endif
endfunc


""""""""""""""""""""""""vundle"""""""""""""""""""""""""""

set nocompatible               " be iMproved
filetype off                   " required!
 
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
 
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
 
" My Bundles here:
"
" original repos on github
Bundle 'kien/ctrlp.vim'
"Bundle 'sukima/xmledit'
Bundle 'sjl/gundo.vim'
Bundle 'jiangmiao/auto-pairs'
"Bundle 'klen/python-mode'
Bundle 'Valloric/ListToggle'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'rdnetto/YCM-Generator'
Bundle "tdcdev/ycm_simple_conf"
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround' 
"Bundle 'vim-scripts/taglist.vim'
Bundle 'brookhong/cscope.vim'
Bundle 'hari-rangarajan/CCTree'
"Bundle 'wesleyche/Trinity'

Bundle 't9md/vim-quickhl'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'scrooloose/nerdtree'
Bundle 'tacahiroy/ctrlp-funky'
"Bundle 'Lokaltog/powerline'
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
Bundle 'powerline/fonts'
Bundle 'vim-scripts/molokai.git'
Bundle 'bitterjug/vim-colors-freyr'
Bundle 'altercation/solarized'

Bundle 'davidhalter/jedi-vim'
Bundle 'vim-scripts/indentpython.vim'
Bundle 'tmhedberg/SimpylFold'

Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/c.vim'
Bundle 'octol/vim-cpp-enhanced-highlight'
"Bundle 'Shougo/neocomplcache.vim'
"Bundle 'vim-scripts/neocomplcache'
Bundle 'vim-scripts/AutoComplPop'
"Bundle 'Rip-Rip/clang_complete'
Bundle 'airblade/vim-gitgutter'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'terryma/vim-multiple-cursors' 
Bundle 'mhinz/vim-startify'
Bundle 'zhisheng/visualmark.vim' 
Bundle 'wesleyche/SrcExpl' 
"""Bundle 'vimscripts-song/csExplorer' 
Bundle 'tpope/vim-fugitive'
Bundle 'majutsushi/tagbar'
"Bundle 'godlygeek/tabular.git'
Bundle "junegunn/vim-easy-align"
Bundle "junegunn/goyo.vim"
Bundle "justinmk/vim-sneak"
Bundle "rking/ag.vim"
"Bundle "haya14busa/incsearch.vim"
Bundle "terryma/vim-expand-region"
Bundle "pthrasher/conqueterm-vim"
Bundle "vim-scripts/VimIM"
"Bundle "exvim/ex-hierarchy"

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...
 
filetype plugin indent on     " required!
"
" Brief help  -- 此处后面都是vundle的使用命令
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..


