" Sets leader character to space
	let mapleader = ' '
" Imports my plugins
	call plug#begin(stdpath('config').'/autoload/plugged')
	    Plug 'neoclide/coc.nvim', {'branch': 'release'}
	    Plug 'vim-airline/vim-airline'
	    Plug 'junegunn/goyo.vim'
	    Plug 'luochen1990/rainbow'
	    Plug 'lambdalisue/battery.vim'
	    Plug 'qpkorr/vim-renamer'
	    Plug 'tpope/vim-commentary'
	call plug#end()
" Sets vim defaults
	set encoding=utf-8
	set hidden
	set noruler
	set relativenumber number
	set splitbelow splitright
	set nobackup
	set nowritebackup
	set noshowmode
	set noshowcmd
" Yank to clipboard
	set clipboard+=unnamedplus
" Enables autocompletion
	set wildmode=longest,list,full
" Turns off autocomment
	autocmd FileType * setlocal formatoptions-=cro
" Set leader characters
	map <leader>a :<C-u>CocList diagnostics<CR>
	map <leader>g :Goyo<CR>
	map <silent> <leader>h :nohlsearch<CR>
	map <leader>o :setlocal spell! spelllang=en_us<CR>
	map <leader>r :Rename<CR>
" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
" Allow for updated diagnostic messages
	set updatetime=300
" don't give |ins-completion-menu| messages.
	set shortmess+=cS
" Set coc data home
	let g:coc_data_home = stdpath('config').'/coc'
" Use `[c` and `]c` to navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
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
" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
	command! -nargs=? Fold :call CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
	command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
" Bracket higlighting
	let g:rainbow_active = 1
" Adds extensions to the status bar
	let g:airline#extensions#whitespace#enabled = 0
	let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|groff|markdown|markdown.pandoc|org|rst|tex|text'
	let g:airline#extensions#battery#enabled = 1
" Sets file handling by file extension
	autocmd BufNewFile,BufRead *.ms set filetype=groff
" Java abbreviations
	autocmd FileType java imap <silent> _xc <C-R>=expand('%:t:r')<CR>
	autocmd FileType java imap _pc public class _xc {<CR>}<esc>O
 	autocmd FileType java imap _psvm public static void main(String[] args) {<CR>}<esc>O
	autocmd FileType java imap _po System.out.print("z");<esc>Fzcw
	autocmd FileType java imap _pl System.out.println("z");<esc>Fzcw
	autocmd FileType java imap _pf System.out.printf("z");<esc>Fzcw
	autocmd FileType java imap _pe System.err.println("z");<esc>Fzcw
	autocmd FileType java imap _f for (int i = 0; i < z; i++) {<esc>Fzcw
	autocmd FileType java imap _t try {<CR>z<CR>} catch (Exception ex) {<CR>ex.printStackTrace();<CR>}<esc>3k0fzcw
	autocmd FileType java imap _c public static final int
	autocmd FileType java imap _m System.currentTimeMillis()
	autocmd FileType java imap _s try {<CR>Thread.sleep(z);<CR>} catch (Exception ex) {<CR>ex.printStackTrace();<CR>}<esc>3k0fzcw
	autocmd FileType java imap _hi _pc_psvm_plHello, world!<esc>G
