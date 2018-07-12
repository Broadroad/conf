" {{{ Basic config
set nu
set cindent
set smartindent
set tabstop=4
set shiftwidth=4
set hlsearch
set nobackup
set foldmethod=marker
set nowb
set softtabstop=4
set expandtab
set fileencodings=utf8,gbk
set ignorecase
set backspace=start,eol,indent
au FileType make set noexpandtab
set clipboard=unnamed
set cinoptions=g0
set keymodel=startsel,stopsel
set autoread
syntax on
colorscheme darkblue
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_fmt_autosave = 1
"autocmd BufWritePre * execute ':%s/\s*$//g'
" }}}

" {{{Custom config
if has("gui_running")

    if has('gui_macvim')
    else
    endif

	set guioptions-=L
	set guioptions-=T "关闭工具栏
	set guioptions-=l "关闭左边滚动条
	set guioptions-=r "关闭右边滚动条
	set guioptions-=R
else
endif
" }}}

" {{{nerd tree
imap <C-e>  <Esc>:NERDTreeToggle<CR>
map <C-e>  <Esc>:NERDTreeToggle<CR>
map <C-w>  <C-w><C-w>
let NERDTreeIgnore = ['^.*\.out$']
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            elseif winnr("$") == 2
                if bufwinnr("__Tag_List__") != -1
                    q
                endif
            endif
        endif
    endif
endfunction
"}}}

nmap <silent> <leader>d <Plug>DashSearch

" {{{ vundle manager
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'davidhalter/jedi'
Bundle 'plasticboy/vim-markdown'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'
Bundle 'pthrasher/conqueterm-vim'
Bundle 'pydave/vim-man'
Bundle 'Auto-Pairs'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'majutsushi/tagbar'
Bundle 'ftih/vim-go'
filetype on "required
" }}}

" {{{tagbar
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_width=30
function CallTag()
    execute "TagbarToggle"
    for i in range(1, winnr('$'))
        let tmp = bufname(winbufnr(i))
        if tmp =~ "Tagbar"
            execute i . "wincmd w"
        endif
        unlet tmp
    endfor
endfunction


imap <F8> <Esc>:call CallTag()<CR>
map <F8> <Esc>:call CallTag()<CR>
" }}}

" {{{YouCompleteMe
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_auto_jump = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_always_populate_location_list = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_mode_map = {'passive_filetypes' : ['c', 'cpp']}
let g:syntastic_cpp_compiler = '-std=c++11'
imap <C-j>  <Esc>:YcmCompleter GoToDefinitionElseDeclaration<CR>
map <C-j>  <Esc>:YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
let ycm_show_diagnostics_ui = 1             "是否诊断
let g:ycm_key_invoke_completion = 'Tab'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚠'
autocmd BufWrite * pclose
" }}}

" {{{ConqueTer m  
let g:ConqueTerm_Color = 2
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_FastMode = 0
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_ToggleKey = ''
imap <C-h>  <Esc>:call CallZsh()<CR>
map <C-h>  <Esc>:call CallZsh()<CR>
set splitbelow
function CallZsh()
    if !exists("s:my_terminal")
        exec "15new"
        let s:my_terminal = conque_term#open('/bin/zsh')
    else
        for i in range(1, winnr('$'))
            let tmp = bufname(winbufnr(i))
            if tmp =~ "/bin/zsh"
                execute i . "wincmd w"
                execute "q"
                let s:isclosed = 1
            endif
            unlet tmp
        endfor
        if !exists("s:isclosed")
            exec "15new"
            let s:my_terminal = conque_term#open('/bin/zsh')
        else
            unlet s:my_terminal
        endif
        silent! unlet s:iscloseds            
    endif
endfunction
" }}}

" {{{statusline
set laststatus=2
set statusline=%<%F%m%r%w\ fmt=%{&ff}:%{&fenc!=''?&fenc:&enc},type=%Y,ascii=\%b(\%B)%=%v,%l\ of\ %L\ %P
" }}}

" {{{cpp highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
" }}}
