" Sets leader character to space
	let mapleader = ' '
" Imports my plugins
	call plug#begin(stdpath('config').'/autoload/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'junegunn/goyo.vim'
	Plug 'qpkorr/vim-renamer'
	Plug 'tpope/vim-commentary'
	Plug 'vimwiki/vimwiki'
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
" Yank to clipboard
	set clipboard+=unnamedplus
" Enables autocompletion
	set wildmode=longest,list,full
" Replace all is aliased to S
	nmap S :%s//g<Left><Left>
" Turns off autocomment
	autocmd FileType * setlocal formatoptions-=cro
" Set leader characters
	nmap <silent> <leader>a :CocList diagnostics<CR>
	nmap <silent> <leader>c :exe 'edit '.stdpath('config').'/init.vim'<CR>
	nmap <silent> <leader>e :Lex<CR>
	nmap <silent> <leader>g :Goyo \| set linebreak<CR>
	nmap <silent> <leader>h :nohlsearch<CR>
	nmap <silent> <leader>o :setlocal spell! spelllang=en_us<CR>
	nmap <silent> <leader>r :Rename<CR>
" Remap arrow keys to buffer movement
	nmap <LEFT> <C-w>h
	nmap <DOWN> <C-w>j
	nmap <UP> <C-w>k
	nmap <RIGHT> <C-w>l
" Allow for updated diagnostic messages
	set updatetime=300
" Give more concise messages
	set shortmess+=acs
" Set coc data home
	let g:coc_data_home = stdpath('config').'/coc'
" K shows coc diagnostics as well as vim help
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	function! s:show_documentation() abort
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		else
			execute '!' . &keywordprg . " " . expand('<cword>')
		endif
	endfunction
" Use `[c` and `]c` to navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')
" use `:OR` for organize import of current buffer
	command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

augroup DeleteWhitespace
	autocmd!
	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
	autocmd BufWritePre * call cursor(currPos[1], currPos[2])
augroup END

augroup Prose
	autocmd!
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.txt,*.md,*.ms,*.me,*.mom,*.man set textwidth=79
augroup END

augroup JavaShortcuts
	autocmd!
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
augroup END
