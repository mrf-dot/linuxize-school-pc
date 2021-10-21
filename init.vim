" Store this in ~\AppData\Local\nvim\init.vim
" Imports my plugins
call plug#begin('C:\Users\username\AppData\Local\nvim\autoload\plugged')
    Plug 'scrooloose/NERDTree'
    Plug 'jiangmiao/auto-pairs'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'luochen1990/rainbow'
    Plug 'lambdalisue/battery.vim'
call plug#end()

" Sets vim defaults
set title
set noshowmode
set encoding=utf-8
set hidden
set noruler
set nobackup
set nowritebackup
set cmdheight=2
set laststatus=2
set relativenumber number
set formatoptions-=o
set splitbelow splitright
" Copy paste to clipboard
set clipboard+=unnamedplus
" Enables autocompletion
set wildmode=longest,list,full
" Spell-check set to <leader>o
map <leader>o :setlocal spell! spelllang=en_us<CR>
" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Scroll through documentation
set mouse=a
"Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
set autoindent
set smartindent
syntax enable
let g:rainbow_active = 1
filetype plugin indent on
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|groff|markdown|markdown.pandoc|org|rst|tex|text'
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:coc_data_home = "C:/Users/username/AppData/Local/coc"

" Adds extensions to the status bar
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:airline#extensions#battery#enabled = 1
let g:battery#update_tabline = 1    " For tabline.
let g:battery#update_statusline = 1 " For statusline.
