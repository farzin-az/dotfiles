"imports
source /home/farzin/.config/nvim/image-paste.vim "to paste images from clipboard into neovim
" Basic settings
set encoding=utf-8
set number
set noswapfile
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set mouse=a
set smarttab
set shiftwidth=4
set ignorecase
set termbidi
syntax enable
filetype plugin on

" Additional core neovim settings:
"
set clipboard+=unnamedplus "making the neovim to use the system clipboard

" There is a bug in running neovim with alacritty that prevents neovim from
" taking the full width of terminal. The following hack is used to prevent
" this bug. If for any reason this stops working, consider uncommenting the
" following line.

" autocmd VimEnter * :sleep 20m
autocmd VimEnter * silent exec "!kill -s SIGWINCH" getpid()


"plugins
call plug#begin()
Plug 'akinsho/toggleterm.nvim'
Plug 'Mofiqul/dracula.nvim'
Plug 'lambdalisue/suda.vim' 
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/vim-airline/vim-airline-themes' " Status bar themes
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'tricktux/pomodoro.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'vim-pandoc/vim-pandoc'
Plug 'Pocco81/AutoSave.nvim'
Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'airblade/vim-rooter'
Plug 'yever/rtl.vim'
Plug 'azabiong/vim-highlighter'
Plug 'tpope/vim-surround'
call plug#end()

" Plugin settings:
"
" Vimwiki settings
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:mkdp_browser = 'surf'
" let g:vimwiki_folding = 'syntax'
au filetype vimwiki silent! iunmap <buffer> <Tab>

" Airline settings
let g:airline_powerline_fonts = 1 "to show the powerline fonts correctly in the airline. Appropriate powerline fonts need to be installed beforehand. I use MesloLGS NF font.
let g:airline_theme = "base16_ashes"
let g:airline#extensions#tabline#enabled = 1

" coc.nvim settings
"making tab the auto-completion key for coc.nvim
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : '<Tab>'

colorscheme dracula

" vim-pandoc settings
" augroup pandoc_syntax
"     au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
" augroup END
augroup pandoc_syntax
   autocmd! FileType vimwiki set syntax=markdown.pandoc
augroup END
augroup
" pomodoro.vim settings
let g:pomodoro_notification_cmd = "mpg123 -q /home/farzin/.vim/explosion-03.mp3"
 let g:pomodoro_notification_cmd = 'notify-send ="Pomodoro finished'    
let g:pomodoro_do_log = 1 
" autosave settings
lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF

" Custom functions:

" Write todays jalali date
function GetJalaliDate() abort
     let date = '## ' .. system('pcal -t')[:-2] .. ':'
     call append(line('.'), date)
     execute line('.') .. 'd' 
     execute "normal! o\t-  "
     :startinsert
endfunction

func WriteTitle() abort
    let currentFile = @%
    let systemCall = "echo ".. currentFile .. " | awk -F'/' {'print $NF'} | sed 's/.md//'" 
    let fileName =  '# ' .. system(systemCall)
    execute "normal! i" .. fileName
endfunc

" Keybindings
nnoremap <C-t> :NERDTreeToggle<CR>   
nnoremap <C-w> :call WriteTitle()<CR>   
nnoremap <C-l> :call WriteAndLoad()<CR>   
nnoremap <C-d> :call GetJalaliDate()<CR>
nnoremap <C-f> :Telescope find_files<CR>
nnoremap <C-k> :MarkdownPreview<CR>
" nnoremap <C-m> :set keymap=persian<CR>
nnoremap <C-e> :bd<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>


" default key mappings
" let HiSet   = 'f<CR>'
" let HiErase = 'f<BS>'
" let HiClear = 'f<C-L>'
" let HiFind  = 'f<Tab>'

" " find key mappings
" nn -        <Cmd>Hi/next<CR>
" nn _        <Cmd>Hi/previous<CR>
" nn f<Left>  <Cmd>Hi/older<CR>
" nn f<Right> <Cmd>Hi/newer<CR>

" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀   '
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" " airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''
