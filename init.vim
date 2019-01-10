"" file syntax
set number relativenumber
syntax enable

"" search
set incsearch
set hlsearch
set ignorecase
set smartcase

"" colors
set background=light

"" perf
set ttyfast
set lazyredraw
set regexpengine=1

"" netrw setting
set nocp
filetype plugin on
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

"" custom statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\

"" highlight unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"" tabs -> spaces
set expandtab
set shiftwidth=2

"" jsx config
let g:jsx_ext_required = 0

"" plugin config
call plug#begin('$HOME/.config/nvim/.plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'w0rp/ale'
Plug 'bling/vim-bufferline'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tomlion/vim-solidity'
Plug 'jparise/vim-graphql'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'herringtondarkholme/yats.vim'
Plug 'ambv/black'
call plug#end()

"" ALE config
let g:ale_linters = {'javascript': ['eslint'], 'clojure': ['joker']}
""let g:ale_linters = {'javascript': [''], 'clojure': ['joker']}
""let g:ale_fixers = {'javascript': ['prettier-standard']}
let g:ale_fix_on_save = 1
let g:ale_fixers = {'javascript': ['prettier']}
