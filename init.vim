" Store this in ~\AppData\Local\nvim\init.vim

" Turns filetype plugin on
	filetype plugin indent on
" Imports my plugins
	call plug#begin(stdpath('config').'/autoload/plugged')
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
" Spell-check set to leader o
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Turns off autocomment
	autocmd FileType * setlocal formatoptions-=cro
" Set goyo to leader f
	map <leader>f :Goyo<CR>
" Show all diagnostics
	map <leader>a :<C-u>CocList diagnostics<CR>
" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
" Allow for updated diagnostic messages
	set updatetime=300
" don't give |ins-completion-menu| messages.
	set shortmess+=c
" Set coc data home
	let g:coc_data_home = stdpath('config').'/coc'
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
	command! -nargs=? Fold :call CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
	command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
" Syntax higlighting
	syntax enable
	let g:rainbow_active = 1
" Nerd Tree shortcuts
	nnoremap <C-t> :NERDTreeToggle<CR>
	nnoremap <C-f> :NERDTreeFind<CR>
" Adds extensions to the status bar
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
	let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|groff|markdown|markdown.pandoc|org|rst|tex|text'
	let g:airline#extensions#battery#enabled = 1
	let g:battery#update_tabline = 1
	let g:battery#update_statusline = 1
" Sets file handling by file extension
	autocmd BufNewFile,BufRead *.ms set filetype=groff
" java abbreviations
	autocmd FileType java imap <silent> _xc <C-R>=expand('%:t:r')<CR>
	autocmd FileType java imap _pc public class _xc {<CR>}<esc>O
 	autocmd FileType java imap _psvm public static void main(String[] args) {<CR>}<esc>O
	autocmd FileType java imap _p System.out.print("z");<esc>Fzcw
	autocmd FileType java imap _pl System.out.println("z");<esc>Fzcw
	autocmd FileType java imap _pf System.out.printf("z");<esc>Fzcw
	autocmd FileType java imap _pe System.err.println("z");<esc>Fzcw
	autocmd FileType java imap _f for (int i = 0; i < z; i++) {<esc>Fzcw
	autocmd FileType java imap _t try {<CR>z} catch (Exception ex) {<CR>ex.printStackTrace();}<esc>3k0fzcw
	autocmd FileType java imap _c public static final int<space>
	autocmd FileType java imap _m System.currentTimeMillis()
	autocmd FileType java imap _s try {<CR>Thread.sleep(z);} catch (Exception ex) {<CR>ex.printStackTrace();}<esc>3k0fzcw
	autocmd FileType java imap _hi _pc_psvm_plHello, world<esc>G
