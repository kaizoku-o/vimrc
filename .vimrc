autocmd!
source ~/mswin.vim
set selectmode=
set history=100
set modelines=5
syntax on
set autoindent
set hls
set nowrap
set nu
set showmode
set showcmd
set autochdir
set tags+=./tags;
set ic
set wrapscan
set mouse=a
set mousemodel=popup
syntax enable
set expandtab
filetype on
filetype plugin on
set nocp
"set ts=8
"set sw=4
"set wm=5
"set sts=4
au FileType c,cpp,cc,hh,h set noexpandtab
au FileType c,cpp,cc,hh,h set sts=4
au FileType c,cpp,cc,hh,h set ts=8
au FileType c,cpp,cc,hh,h set sw=4
au FileType c,cpp,cc,hh,h set textwidth=81
set ai
set spell
set spelllang=en_us
set incsearch
set cursorline
set ignorecase
"Matching parenthesis
set sm
" Allow backspace to delete
set bs=2
" Make F5 reload .vimrc
map <A-F5> :source ~/.vimrc<CR>
" Make the window title reflect the file being edited
set title
set titlestring=VIM:\ %F
" At command line, complete longest common string, then list alternatives.
set wildmode=longest,list
" Turn ruler on
set ruler
" Make command line two lines high
set ch=2
set noexpandtab
set autochdir
set tags=./tags;
set wildmenu
map <F2> :vsp `FILE=%; echo ${FILE/.h/.cc}`<CR>
map <F3> :vsp `FILE=%; echo ${FILE/.cc/.h}`<CR>
highlight Normal guibg=black guifg=white
set background=dark
au FileType c,cpp,cc,hh,h highlight OverLength ctermbg=red ctermfg=black guibg=#592929
au FileType c,cpp,cc,hh,h match OverLength /\%81v.*/
colorscheme koehler
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 2
let OmniCpp_ShowScopeInAbbr = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_MayCompleteScope = 1
set cot="longest"

" set ack as default search program
set grepprg=ack\ --noheading\ --nobreak
set guifont=Menlo:h12
set viminfo='10,\"100,:20,%,n~/.viminfo

" open tag in preview window
" map <C-]> b"zyw :ptj <C-R>z<CR>
map <C-]> :call PreviewWord()<CR>
func PreviewWord()
    if &previewwindow   " don't do this in the preview window
    return
    endif
    let w = expand("<cword>")  " get the word under cursor
    if w =~ '\a'   " if the word contains a letter
    " Delete any existing highlight before showing another tag
    silent! wincmd P   " jump to preview window
    if &previewwindow   " if we really get there...
    match none   " delete existing highlight
    wincmd p   " back to old window
    endif

" Try displaying a matching tag for the word under the cursor
    try
    exe "ptj " . w
    catch
    return
    endtry

   silent! wincmd P   " jump to preview window
   if &previewwindow  " if we really get there...
   if has("folding")
   silent! .foldopen  " don't want a closed fold
   endif
   call search("$", "b")  " to end of previous line
   let w = substitute(w, '\\', '\\\\', "")
   call search('\<\V' . w . '\>') " position cursor on match
   " Add a match highlight to the word at this position
   hi previewWord term=bold ctermbg=green guibg=green
   exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
   wincmd p   " back to old window
   endif
   endif
endfun
"set ack as default search program
"set grepprg=ack\ --noheading\ --nobrea
