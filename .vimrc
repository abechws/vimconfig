set nocompatible
set nu
set backspace=indent,eol,start
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set list
set listchars=tab:>-,trail:.
set ignorecase
set hlsearch
set ruler
syntax enable

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('tpope/vim-rails')
call dein#add('slim-template/vim-slim')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('scrooloose/nerdtree')
call dein#add('itchyny/lightline.vim')
call dein#add('tomasr/molokai')
call dein#add('kmnk/vim-unite-giti')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('cohama/lexima.vim')
call dein#end()

filetype plugin indent off

function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'  
  return s
endfunction "}}}

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'  
endfor

"補完周り
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
endfor

imap <expr> . pumvisible() ? "\<C-E>.\<C-X>\<C-O>\<C-P>" : ".\<C-X>\<C-O>\<C-P>"

nnoremap <silent> [Tag]c :tablast <bar> tabnew<CR>
nnoremap <silent> [Tag]x :tabclose<CR>
nnoremap <silent> [Tag]n :tabnext<CR>
nnoremap <silent> [Tag]p :tabprevious<CR>

" NERDTree用
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" colorscheme
colorscheme molokai
highlight Normal ctermbg=none

" unite-giti
nnoremap <silent>gl :<C-U>Unite -no-start-insert -horizontal giti/log<CR>
nnoremap <silent>gs :<C-U>Unite -no-start-insert -horizontal giti/status<CR>
nnoremap <silent>gb :<C-U>Unite -no-start-insert giti/branch_all<CR>

nnoremap ; :
nnoremap : ;
