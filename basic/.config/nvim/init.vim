set mouse=a
set ignorecase
set nohlsearch
set incsearch
set number relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set shortmess=at
set shellcmdflag=-ic
nnoremap <space> <nop>
let mapleader=" "

call plug#begin() 
Plug 'tpope/vim-surround'
Plug 'sirver/ultisnips'
call plug#end()

filetype plugin indent off

let g:UltiSnipsSnippetDirectories=['~/.config/nvim/usnips/']
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:markdown_fenced_languages = ['sh', 'c', 'cpp', 'python', 'yaml', 'javascript']
let g:tex_flavor = 'tex'

function! Get_selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" go to last position when opening file
autocmd BufReadPost * silent! normal! g`"zvzz

" leader mapping
nnoremap <leader>j G
xnoremap <leader>j G
nnoremap <leader>k gg
xnoremap <leader>k gg
nnoremap <leader>i I
nnoremap <leader>a A
nnoremap <leader>v V
nnoremap <leader>o O
nnoremap <leader>p P
nnoremap <leader>r R
nnoremap <leader>m @q
noremap <leader><leader> :
nnoremap <leader>u <c-r>
xmap <leader>s <Plug>VSurround
noremap <leader>y "+y

" insert mode mappings
inoremap <c-u> <c-o>u<c-o>u
" does not work due to backspace sending C-h
inoremap <C-BS> <C-w>

" better navigation
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <leader>h ^
noremap H ^
noremap <leader>l $
noremap L $
nnoremap <leader>t H
nnoremap <leader>b L

" find
noremap f /
noremap F ?
noremap <leader>f ?
noremap / f
noremap ? F
noremap <leader>/ F
noremap <leader>n N

" easier commands
noremap <leader>w :w<cr>
noremap <leader>q :wq<cr>
noremap <leader>xq :q!<cr>

" escape
inoremap jk <esc>
xnoremap <leader>jk <esc>

" text object
onoremap <silent> i$ :<c-u>normal! T$vt$<cr>
xnoremap i$ T$ot$
