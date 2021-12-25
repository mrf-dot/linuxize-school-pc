" Sets leader character to space
	let mapleader = ' '
" Imports my plugins
	call plug#begin(stdpath('config').'/autoload/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'junegunn/goyo.vim'
	Plug 'qpkorr/vim-renamer'
	Plug 'tpope/vim-commentary'
	Plug 'vimwiki/vimwiki'
	Plug 'tpope/vim-surround'
	call plug#end()
" Buffer behavior
	set hidden
	set relativenumber number
	set signcolumn=number
	set splitbelow splitright
" Don't backup files
	set nobackup nowritebackup
" Unclutter statusbar
	set noshowmode
	set noshowcmd
	set laststatus=0
" Make tabs 4 spaces instead of 8
	set tabstop=4
	set shiftwidth=4
" Yank to clipboard
	set clipboard+=unnamedplus
" Enables autocompletion
	set wildmode=longest,list,full
" Replace all is aliased to S
	nnoremap S :%s//g<Left><Left>
" Turns off autocomment
	autocmd FileType * setlocal formatoptions-=cro
" Set leader characters
	map <silent> <leader>a :<C-u>CocList diagnostics<CR>
	map <silent> <leader>c :exe 'edit '.stdpath('config').'/init.vim'<CR>
	map <silent> <leader>e :Lex<CR>
	map <silent> <leader>g :Goyo \| set linebreak<CR>
	map <silent> <leader>h :nohlsearch<CR>
	map <silent> <leader>o :setlocal spell! spelllang=en_us<CR>
	map <silent> <leader>r :Rename<CR>
" Remap arrow keys to buffer movement
	map <LEFT> <C-w>h
	map <DOWN> <C-w>j
	map <UP> <C-w>k
	map <RIGHT> <C-w>l
" Delete trailing whitespace on save
	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
" Allow for updated diagnostic messages
	set updatetime=300
" don't give |ins-completion-menu| messages.
	set shortmess+=acs
" Set coc data home
	let g:coc_data_home = stdpath('config').'/coc'
" Use `[c` and `]c` to navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Use K to show documentation in preview window
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		elseif (coc#rpc#ready())
	    	call CocActionAsync('doHover')
	  	else
	    	execute '!' . &keywordprg . " " . expand('<cword>')
	  	endif
	endfunction
" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
	command! -nargs=? Fold :call CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
	command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
" Sets file handling by file extension
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.txt,*.md,*.ms,*.me,*.mom,*.man set textwidth=79
" Java abbreviations
	autocmd FileType java imap <silent> _xc <C-R>=expand('%:t:r')<CR>
	autocmd FileType java imap _pc public class _xc {<CR>}<esc>O
 	autocmd FileType java imap _psvm public static void main(String[] args) {<CR>}<esc>O
	autocmd FileType java imap _po System.out.print(z);<esc>Fzcw
	autocmd FileType java imap _pl System.out.println(z);<esc>Fzcw
	autocmd FileType java imap _pf System.out.printf(z);<esc>Fzcw
	autocmd FileType java imap _pe System.err.println(z);<esc>Fzcw
	autocmd FileType java imap _f for (int i = 0; i < z; i++) {<esc>Fzcw
	autocmd FileType java imap _t try {<CR>z<CR>} catch (Exception ex) {<CR>ex.printStackTrace();<CR>}<esc>3k0fzcw
	autocmd FileType java imap _c public static final int
	autocmd FileType java imap _m System.currentTimeMillis()
	autocmd FileType java imap _s try {<CR>Thread.sleep(z);<CR>} catch (Exception ex) {<CR>ex.printStackTrace();<CR>}<esc>3k0fzcw
	autocmd FileType java imap _hi _pc_psvm_pl"Hello, world!"<esc>G
