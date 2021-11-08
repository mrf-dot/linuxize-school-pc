" Store this in ~\AppData\Local\nvim\init.vim

" Turns filetype plugin on
	filetype plugin indent on
" Imports my plugins
call plug#begin('C:\Users\username\AppData\Local\nvim\autoload\plugged')
    Plug 'scrooloose/NERDTree'
    Plug 'jiangmiao/auto-pairs'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'junegunn/goyo.vim'
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
set laststatus=2
set relativenumber number
set splitbelow splitright
" Copy paste to clipboard
set clipboard+=unnamedplus
" Enables autocompletion
set wildmode=longest,list,full
" Spell-check set to <leader>o
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Turns off autocomment
	autocmd FileType * setlocal formatoptions-=cro
" Set goyo to leader f
	map <leader>f :Goyo <CR>
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
" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Show all diagnostics
	nnoremap <space>a  :<C-u>CocList diagnostics<cr>
set autoindent
set smartindent
syntax enable
let g:rainbow_active = 1
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:coc_data_home = "C:/Users/username/AppData/Local/coc"

" Adds extensions to the status bar
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
	let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|groff|markdown|markdown.pandoc|org|rst|tex|text'
	let g:airline#extensions#battery#enabled = 1
	let g:battery#update_tabline = 1    " For tabline.
	let g:battery#update_statusline = 1 " For statusline.
" Sets file handling by file extension
	autocmd BufNewFile,BufRead *.ms set filetype=groff
" ide abbreviations
	autocmd FileType java abbr psvm public static void main(String[] args) {<CR>}<esc>O
	autocmd FileType java abbr sop System.out.print("z");<esc>?z<CR>xi
	autocmd FileType java abbr sopl System.out.println("");<esc>2hi
	autocmd FileType java abbr sopf System.out.printf("");<esc>2hi
	autocmd FileType java abbr sep System.err.println("");<esc>2hi
	autocmd FileType java abbr forl for (int i = 0; i <z; i++) {<esc>?z<CR>xi
	autocmd FileType java abbr tryb try {<CR>} catch (Exception ex) {<CR> ex.printStackTrace();<CR>}<esc>hx3ko
	autocmd FileType java abbr const public static final int
	autocmd FileType java abbr ctm System.currentTimeMillis()
	autocmd FileType java abbr slept try {<CR> Thread.sleep();<CR>}<esc>hxA catch(Exception ex) {<CR> ex.printStackTrace();<CR>}<esc>hx3k$hi
