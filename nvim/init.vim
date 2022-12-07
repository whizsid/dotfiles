" Fish doesn't play all that well with others
set shell=/bin/bash
:set mouse=a
let mapleader = "\<Space>"

">>>>>>>>>>>>>>>>>Text Editor Settings"
set number
set foldlevel=9999
set foldcolumn=1
set wrap!
set scrolloff=2
:set scrollopt+=hor
set path=$PWD/**
filetype plugin on
set clipboard=unnamedplus
set wildcharm=<Tab>

" =============================================================================
" # PLUGINS
" =============================================================================
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'vim-syntastic/syntastic'
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'agude/vim-eldar'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
"Plug 'tpope/vim-fugitive'
Plug 'docteurklein/vim-symfony'
Plug 'chase/vim-ansible-yaml'
Plug 'nelsyeung/twig.vim'
Plug 'ianks/vim-tsx'
Plug 'dhulihan/vim-rfc'
Plug 'swekaj/php-foldexpr.vim'
Plug 'mileszs/ack.vim'
Plug 'beanworks/vim-phpfmt'
Plug 'whizsid/vim-autoresize'
Plug 'othree/eregex.vim'
Plug 'leafgarland/typescript-vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'gabrielelana/vim-markdown'
Plug 'joeytwiddle/sexy_scroller.vim'
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'chrisbra/vim-diff-enhanced'
Plug 'jvirtanen/vim-octave'
Plug 'Shatur/neovim-cmake'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'dylanaraps/wal.vim'
Plug 'neoclide/jsonc.vim'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'nicwest/vim-http'
Plug 'mfussenegger/nvim-dap'

call plug#end()

">>>>>>>>>>>>>>>NERDTreee"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeMouseMode = 3
let g:NERDTreeGitStatusShowIgnored = 1
let NERDTreeShowHidden=1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'M',
                \ 'Staged'    :'S',
                \ 'Untracked' :'U',
                \ 'Renamed'   :'R',
                \ 'Unmerged'  :'UM',
                \ 'Deleted'   :'D',
                \ 'Dirty'     :'DI',
                \ 'Ignored'   :'I',
                \ 'Clean'     :'CL',
                \ 'Unknown'   :'N/A',
                \ }

">>>>>>>>>>>>>>>Rust"
syntax enable
"let g:rustfmt_autosave = 1"

">>>>>>>>>>>>>>>Syntastic"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_stl_format = '! %e | ⚠️ %w'

">>>>>>>>>>>>>>>Code completion"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gx :vs<CR><Plug>(coc-definition)
nmap <silent> gh :sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


">>>>>>>>>>>>>>>>>>Light Line"
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [  'gitbranch', 'readonly', 'relativepath', 'modified', 'cocstatus', 'syntasticstatus' ] ]
      \ },
      \ 'component': {
      \   'relative_filename': '%'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'cocstatus': 'coc#status',
      \   'syntasticstatus': 'SyntasticStatuslineFlag'
      \ },
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
      \ }

">>>>>>>>>>>>>>>>Find Files"
function! Find(name)
  let l:list=system("find . -name '".a:name."' | perl -ne 'print \"$.\\t$_\"'")
" replace above line with below one for gvim on windows
" let l:list=system("find . -name ".a:name." | perl -ne \"print qq{$.\\t$_}\"")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (CR=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")

">>>>>>>>>>>>>>>>Bookmark"
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_no_default_key_mappings = 1

" Finds the Git super-project directory.
function! g:BMWorkDirFileLocation()
    let filename = 'bookmarks'
    let location = ''
    if isdirectory('.git')
        " Current work dir is git's work tree
        let location = getcwd().'/.git'
    else
        " Look upwards (at parents) for a directory named '.git'
        let location = finddir('.git', '.;')
    endif
    if len(location) > 0
        return location.'/'.filename
    else
        return getcwd().'/.'.filename
    endif
endfunction

">>>>>>>>>>>>>>>>>Color Theme"
if has('syntax')
    syntax enable             " Turn on syntax highlighting
    silent! colorscheme wal " Custom color scheme
endif

">>>>>>>>>>>>>>>>>Cursor When Scroll"
set nostartofline

">>>>>>>>>>>>>>>>>Formatter"
"au BufWrite * :Format"

augroup yaml_fix
    autocmd!
    autocmd FileType yaml setlocal indentexpr=\s\s\s\s
augroup END

">>>>>>>>>>>>>>>>>Vertical Line"
set colorcolumn=+1
autocmd FileType php set colorcolumn=120
highlight ColorColumn ctermbg=black guibg=black

">>>>>>>>>>>>>>>>>>Tab Size"
set ts=4 sw=4

">>>>>>>>>>>>>>>>>>Syntastic"
let g:syntastic_php_checkers = ['php']

">>>>>>>>>>>>>>>>>>Toggle comment"
autocmd FileType c,cpp,java,scala,php,rust let b:comment_leader = '//'
autocmd FileType sh,ruby,python   let b:comment_leader = '#'
autocmd FileType conf,fstab       let b:comment_leader = '#'
autocmd FileType tex              let b:comment_leader = '%'
autocmd FileType mail             let b:comment_leader = '>'
autocmd FileType vim              let b:comment_leader = '"'
function! CommentToggle()
    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction

">>>>>>>>>>>>>>>>>>Replace tabs with spaces"
set tabstop=4 shiftwidth=4 expandtab

">>>>>>>>>>>>>>>>>>Auto resize"
let g:autoresize_width = 120
let g:autoresize_height = 22
let g:autoresize_disabled_filetypes = ['nerdtree', 'tagbar','qf', 'dbui']

">>>>>>>>>>>>>>>>>>Fold line colors"
hi Folded ctermfg=DarkGray
hi Folded ctermbg=Green

">>>>>>>>>>>>>>>>>>>Markdown"
augroup FILETYPES
  autocmd FileType markdown let b:indentLine_enabled = 0
augroup END

">>>>>>>>>>>>>>>>>>>Scroll"
let g:SexyScroller_ScrollTime = 2
let g:SexyScroller_CursorTime = 5
let g:SexyScroller_MaxTime = 300
let g:SexyScroller_EasingStyle = 3
let g:SexyScroller_MinLines = 20
let g:SexyScroller_MinColumns = 120

">>>>>>>>>>>>>>>>>>>>Latex Live Preview"
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0

">>>>>>>>>>>>>>>>>>>>Diff"
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

">>>>>>>>>>>>>>>>>>Matlab Include Path"
if isdirectory('/usr/local/MATLAB/R2021a/extern/include')
    set path+=/usr/local/MATLAB/R2021a/extern/include
endif

">>>>>>>>>>>>>>>>>TreeSitter"
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  }
}
EOF

">>>>>>>>>>>>>>>>>Folding"
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

">>>>>>>>>>>>>>>>>Indent Up Down"
function! g:IndentUp()
    let pattern = '^\s*[^\s]'
    if search(pattern, 'Wnb') > 0
        let pattern_array = matchstr(getline('.'), pattern)
        let new_pattern = '^' . repeat('\s', strlen( pattern_array) - 1) . '[^ ]'
        let next_line = search(new_pattern, 'Wznb')
        let column = col('.')
        call cursor(next_line, column)
    endif
endfunction

function! g:IndentDown()
    let pattern = '^\s*[^\s]'
    if search(pattern, 'Wn') > 0
        let pattern_array = matchstr(getline('.'), pattern)
        let new_pattern = '^' . repeat('\s', strlen( pattern_array) - 1) . '[^ ]'
        let next_line = search(new_pattern, 'Wzn')
        echo next_line
        let column = col('.')
        call cursor(next_line, column)
    endif
endfunction

">>>>>>>>>>>>>>>>>>Execute Selected"
function! g:GetSelected()
    if mode()=="v"
        let [line_start, column_start] = getpos("v")[1:2]
        let [line_end, column_end] = getpos(".")[1:2]
    else
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
    end
    if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
        let [line_start, column_start, line_end, column_end] =
        \   [line_end, column_end, line_start, column_start]
    end
    let lines = getline(line_start, line_end)
    if len(lines) == 0
            return ''
    endif
    let lines[-1] = lines[-1][: column_end - 1]
    let lines[0] = lines[0][column_start - 1:]
    return lines
endfunction

function! g:ExecuteSelected()
    let ft = &ft
    let selected = g:GetSelected()
    let joined = join(selected, '\n')
    if ft == 'rust'
        if matchstr(joined, 'struct \|enum \|trait \|fn \|use \|mod \|impl ')!=''
            if matchstr(joined, 'fn main')==''
                let selected = selected + ['fn main(){}']
            endif
        else
            let selected = ['fn main(){'] + selected + ['}']
        endif
        call writefile(selected, '/tmp/nvim-test.rs', 's')
        split
        wincmd j
        terminal cargo script /tmp/nvim-test.rs
    elseif ft == 'php'
        let joined = shellescape( join(selected, ' '))
        split
        wincmd j
        if filereadable('artisan') > 0
            exe 'terminal php artisan tinker --execute='.joined
        else
            exe 'terminal php -r '.joined
        endif
    elseif ft == 'javascript'
        let joined = shellescape( join(selected, ' '))
        split
        wincmd j
        exe 'terminal node -e '.joined
    elseif ft == 'typescript'
        let joined = shellescape( join(selected, ' '))
        split
        wincmd j
        exe 'terminal ts-node -e '.joined
    elseif ft == 'python'
        call writefile(selected, '/tmp/nvim-test.py', 's')
        split
        wincmd j
        terminal python /tmp/nvim-test.py
endfunction

">>>>>>>>>>>>>>>>>>DB UI"
let g:db_ui_win_position = 'right'
autocmd FileType dbui nmap <buffer> v <Plug>(DBUI_SelectLineVsplit)

">>>>>>>>>>>>>>>>>>Rest Client"
let g:vim_http_tempbuffer = 1
let g:vim_http_split_vertically = 1
let g:vim_http_clean_before_do = 0

">>>>>>>>>>>>>>>>>>DAP"
lua <<EOF
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

EOF

">>>>>>>>>>>>>>>>>>Keybindings"
map <C-d> :TagbarOpen fjc<CR>
map <C-t> :NERDTreeToggle<CR>
nmap <C-r> :NERDTreeRefreshRoot<CR>
map <C-e> :SyntasticCheck  <bar> :Errors<CR>
nmap <C-b> :BookmarkToggle <CR>
nmap <C-l> :BookmarkNext <CR>
nmap <C-k> :BookmarkShowAll <CR>
nmap <C-j> :BookmarkPrev <CR>
nmap <C-h> :Http<CR>
map <C-Down> :call g:IndentDown() <CR>
map <C-Up> :call g:IndentUp() <CR>
nmap <C-a> :DBUIToggle <CR>
nnoremap <silent> <expr> <c-o> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
" tap indent movement
vmap <S-Tab>  mm<`m:<C-U>exec "normal ".&shiftwidth."h"<CR>mmgv`m
vmap <Tab>    mm>`m:<C-U>exec "normal ".&shiftwidth."l"<CR>mmgv`m
vmap <C-r> :call g:ExecuteSelected() <CR>
nmap <silent> <C-S-Up> :wincmd k<CR>
nmap <silent> <C-S-Down> :wincmd j<CR>
nmap <silent> <C-S-Left> :wincmd h<CR>
nmap <silent> <C-S-Right> :wincmd l<CR>
nmap <silent> f1 :set foldlevel=1<CR>
nmap <silent> f2 :set foldlevel=2<CR>
nmap <silent> f3 :set foldlevel=3<CR>
nmap <silent> f4 :set foldlevel=4<CR>
nmap <silent> f5 :set foldlevel=5<CR>
nmap <silent> f6 :set foldlevel=6<CR>
nmap <silent> f7 :set foldlevel=7<CR>
nmap <silent> f8 :set foldlevel=8<CR>
nmap <silent> f9 :set foldlevel=9<CR>
nmap <silent> f0 :set foldlevel=99999<CR>
map <C-Bslash> :call CommentToggle()<CR>
nnoremap <leader>. :b <Tab>

"Debug"
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <C-z> <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <C-S-z> <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

"Tab out or COC"
inoremap <expr> <Tab> search('\%#[]>)}''".,;{(`]:', 'n') ? '<Right>' : 
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()
