set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = ","
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'

Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'Lokaltog/vim-easymotion'

Plugin 'rking/ag.vim'
Plugin 'jmcantrell/vim-virtualenv'

Plugin 'dbext.vim'

Plugin 'ervandew/supertab'
"good defaults
Plugin 'tpope/vim-sensible'

" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Various shortcuts 
Plugin 'tpope/vim-unimpaired'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Plugin 'derekwyatt/vim-scala'

call vundle#end()            " required
filetype plugin indent on    " required



"Powerline options
"let g:Powerline_symbols = 'fancy'
"Airline help
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"set guifont=Menlo\ Regular\ for\ PowerLine:h11
set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h11
set visualbell



set background=dark
colorscheme solarized 


"Better search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch
set gdefault
"Easy clearing of highlihgt
nnoremap <leader><space> :noh<cr>

"Long lines
set wrap
"set colorcolumn=85


"SNIPPETS
let g:snips_author = 'Frej Soya'
set expandtab
set tabstop=8
set autoindent
"Default setting of tabstop as recommended in help (width 8) -- printing, etc
set shiftwidth=2
set softtabstop=2
set nu
set smartindent
set smarttab

set ruler
"Save undofile!
set undofile
set relativenumber


" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" Hide toolbar
set guioptions-=T

"Concealment 
set conceallevel=2
let g:tex_conceal= 'adgm'
highlight Conceal guifg=fg guibg=bg

let g:tex_comment_nospell= 1
" let g:tex_fold_enabled=1

"ATP TEX
"let b:atp_TexCompiler="lualatex" 
au BufReadPre *.tex let b:atp_TexCompiler="lualatex"

"wscript is a python file (waf)
au BufNewFile,BufRead wscript* set filetype=python

" LLVM Makefiles can have names such as Makefile.rules or TEST.nightly.Makefile,
" so it's important to categorize them as such.
augroup filetype
  au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Enable syntax highlighting for tablegen files. To use, copy
" utils/vim/tablegen.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
  au! BufNewFile,BufRead *.plt,.gnuplot set filetype=gnuplot
  
augroup END


" Enable syntax highlighting for LLVM files. To use, copy
" utils/vim/llvm.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END
augroup filetype
  au! BufRead,BufNewFile *.sig     set filetype=sml
augroup END


" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g

set encoding=utf-8


" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc

" enable filetype detection, triggers loading of filetype plugins
" (documentation only - this is already implied by :set syntax on)
" configure browser for haskell_doc.vim
"
" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"
"


function! s:set_working_directory_for_project()
  let wd = expand("%:p:h")
  silent exe "cd " . wd

  let git_root = s:git_root()
  if git_root != ""
    silent exe "cd " . git_root
    return
  endif

  let hg_root = s:mercurial_root()
  if hg_root != "" 
    silent exe "cd " . hg_root
    return
  endif

endfunction


function! s:mercurial_root()
  let mercurial_root = system('hg root')

  if v:shell_error != 0
    return ""
  endif
  return mercurial_root
endfunction

function! s:git_root()
  let git_root = system('git rev-parse --show-toplevel')
  if v:shell_error != 0
    return ""
  endif
  return git_root
endfunction
"au BufEnter * call s:set_working_directory_for_project()

au BufNewFile,BufRead *.plt,.gnuplot setf gnuplot

if filereadable($VIRTUAL_ENV . '/.vimrc')
  source $VIRTUAL_ENV/.vimrc
endif



let g:syntastic_always_populate_loc_list =  1

let g:syntastic_javascript_checkers = ['jshint']



"Enable automatic doxygen

let g:load_doxygen_syntax=1
let g:doxygen_enhanced_color=1


"Ag search (silver searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

"merling / ocaml
let g:merlin_ignore_warnings = "true"
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
autocmd FileType ocaml
  \ map <LocalLeader>l :Locate<CR> |
  \ map <LocalLeader>d :Destruct<CR> |
  \ map <LocalLeader>< :ShrinkEnclosing<CR> |
  \ map <LocalLeader>> :GrowEnclosing<CR> |
  nmap <LocalLeader>r  <Plug>(MerlinRename)
  nmap <LocalLeader>R  <Plug>(MerlinRenameAppend)


"  \ hi EnclosingExpr ctermbg=7


au FileType ocaml call SuperTabSetDefaultCompletionType("<c-x><c-o>")

let g:syntastic_ocaml_checkers = ['merlin']

" ## added by OPAM user-setup for vim / base ## 8a3125e39f347f6b9a1b167d8e564281 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  let l:file = s:opam_share_dir . "/vim/syntax/ocp-indent.vim"
  execute "source " . l:file
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  let l:file = s:opam_share_dir . "/vim/syntax/ocpindex.vim"
  execute "source " . l:file
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline, ' ')))
for tool in s:opam_available_tools
  call s:opam_configuration[tool]()
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 38c1f71fce5736312137eeae3b5234d6 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/Users/frej/.opam/4.02.1/share/vim/syntax/ocp-indent.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
