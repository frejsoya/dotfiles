set modeline


fun SetupVAM()
  " YES, you can customize this vam_install_path path and everything still works!
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " * unix based os users may want to use this code checking out VAM
  " * windows users want to use http://mawercer.de/~marc/vam/index.php
  "   to fetch VAM, VAM-known-repositories and the listed plugins
  "   without having to install curl, unzip, git tool chain first
  if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
    " I'm sorry having to add this reminder. Eventually it'll pay off.
    " call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
    exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
    " VAM run helptags automatically if you install or update plugins
    exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
  endif

  call vam#ActivateAddons(["pyflakes2441","bufexplorer.zip","taglist","Color_Sampler_Pack","reload","supertab","The_NERD_tree","The_NERD_Commenter","surround","matchit.zip","AutoAlign","LanguageTool","L9","FuzzyFinder","vcscommand","fugitive","SpellChecker","LaTeX_Box","TeX-PDF","snipmate","github:honza/snipmate-snippets","Solarized","virtualenv","preview3344"], {'auto_install': 0 })
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
  " where 'pluginA' could be "git://" "github:YourName" or "snipmate-snippets" see vam#install#RewriteName()
  " also see section "5. Installing plugins" in VAM's documentation
  " which will tell you how to find the plugin names of a plugin
endf
call SetupVAM()
" au GUIEnter * call SetupVAM()
" experimental: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]



let NERDTreeIgnore=['\.uo','\.ui']
colorscheme darkblue
set visualbell

set nocompatible
filetype on
filetype plugin on
syntax on

let mapleader = ","

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

"Concealment 
set conceallevel=2
let g:tex_conceal= 'adgm'
highlight Conceal guifg=fg guibg=bg

let g:tex_comment_nospell= 1
let g:tex_fold_enabled=1
let g:LatexBox_viewer = "open"
let g:LatexBox_ref_pattern = '\c\\\a*ref\*\?\_\s*{'

"let b:atp_TexCompiler = "lualatex"
"let b:atp_Viewer      = "open"
"let g:atp_status_notification = 1
"let b:atp_TexOptions = "--synctex=1 --enable-write18" 
"let b:atp_auruns     = 2
map <silent> <leader>v :silent !/Applications/Skim.app/Contents/SharedSupport/displayline 
  \ <c-r>=line('.')<cr> "<c-r>=LatexBox_GetOutputFile()<cr>" "%:p" <cr>

map  <silent> <buffer> ¶ :call LatexBox_JumpToNextBraces(0)<CR>
map  <silent> <buffer> § :call LatexBox_JumpToNextBraces(1)<CR>
imap <silent> <buffer> ¶ <C-R>=LatexBox_JumpToNextBraces(0)<CR>
imap <silent> <buffer> § <C-R>=LatexBox_JumpToNextBraces(1)<CR>


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



augroup csrc
  au!
  autocmd FileType * set nocindent 
  autocmd FIletype c,cpp set cindent
augroup END

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
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*



"File "LLvmPrint.sml", line 107-108, characters 6-56:
"! ......ppBinOp Add = $"add"
"!      |   ppBinOp Sub = $"sub"
"! Warning: pattern matching is not exhaustive
"set errorformat+=File\ \"%f\"\\,\ line\ %l-%l\\,characters\ %c-%c: 
"set errorformat+=File\ \"%f\"%.%*

set efm+=%AFile\ \"%f\"\\,\ line\ %l%.%#characters\ %c%.%#:,
         \%-C!\ \.,
         \%-C!\ \ 


" fuzzy finder
"
let g:fuzzy_ignore = "*.ui;*.uo;*.pyc;log/**;.svn/**;.git/**;.hg/**;pip-log.txt;*.gif;*.jpg;*.jpeg;*.png;**media/admin/**;**media/ckeditor/**;**media/filebrowser/**;**media/pages/**;**src/**;**build/**;**_build/**;**media/cache/**"
let g:fuzzy_matching_limit = 70


"
nnoremap <silent> sj     :FufBuffer<CR>
nnoremap <silent> sk     :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> sK     :FufFileWithFullCwd<CR>
nnoremap <silent> s<C-k> :FufFile<CR>
nnoremap <silent> sl     :FufCoverageFile<CR>
nnoremap <silent> sL     :FufCoverageFileChange<CR>
nnoremap <silent> s<C-l> :FufCoverageFileRegister<CR>
nnoremap <silent> sd     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> sD     :FufDirWithFullCwd<CR>
nnoremap <silent> s<C-d> :FufDir<CR>
nnoremap <silent> sn     :FufMruFile<CR>
nnoremap <silent> sN     :FufMruFileInCwd<CR>
nnoremap <silent> sm     :FufMruCmd<CR>
nnoremap <silent> su     :FufBookmarkFile<CR>
nnoremap <silent> s<C-u> :FufBookmarkFileAdd<CR>
vnoremap <silent> s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
nnoremap <silent> si     :FufBookmarkDir<CR>
nnoremap <silent> s<C-i> :FufBookmarkDirAdd<CR>
nnoremap <silent> st     :FufTag<CR>
nnoremap <silent> sT     :FufTag!<CR>
nnoremap <silent> s<C-]> :FufTagWithCursorWord!<CR>
nnoremap <silent> s,     :FufBufferTag<CR>
nnoremap <silent> s<     :FufBufferTag!<CR>
vnoremap <silent> s,     :FufBufferTagWithSelectedText!<CR>
vnoremap <silent> s<     :FufBufferTagWithSelectedText<CR>
nnoremap <silent> s}     :FufBufferTagWithCursorWord!<CR>
nnoremap <silent> s.     :FufBufferTagAll<CR>
nnoremap <silent> s>     :FufBufferTagAll!<CR>
vnoremap <silent> s.     :FufBufferTagAllWithSelectedText!<CR>
vnoremap <silent> s>     :FufBufferTagAllWithSelectedText<CR>
nnoremap <silent> s]     :FufBufferTagAllWithCursorWord!<CR>
nnoremap <silent> sg     :FufTaggedFile<CR>
nnoremap <silent> sG     :FufTaggedFile!<CR>
nnoremap <silent> so     :FufJumpList<CR>
nnoremap <silent> sp     :FufChangeList<CR>
nnoremap <silent> sq     :FufQuickfix<CR>
nnoremap <silent> sy     :FufLine<CR>
nnoremap <silent> sr     :FufRenewCache<CR>


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

if filereadable($VIRTUAL_ENV . '/.vimrc')
  source $VIRTUAL_ENV/.vimrc
endif
