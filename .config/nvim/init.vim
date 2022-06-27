" cSpell:disable

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
set smarttab
set shiftwidth=4
set mouse=a
set ignorecase
set termbidi
set clipboard+=unnamedplus "making neovim to use the system clipboard
syntax enable
filetype plugin on

"plugins
call plug#begin()
Plug 'akinsho/toggleterm.nvim'
" Plug 'Mofiqul/dracula.nvim'
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
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
call plug#end()

colorscheme PaperColor

" Plugin settings:

" Vimwiki settings
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:mkdp_browser = 'surf'
" let g:vimwiki_folding = 'syntax'
au filetype vimwiki silent! iunmap <buffer> <Tab>

" Airline settings
let g:airline_powerline_fonts = 1 "to show the powerline fonts correctly in the airline. Appropriate powerline fonts need to be installed beforehand. I use MesloLGS NF font.
let g:airline_theme = "atomic"
let g:airline#extensions#tabline#enabled = 1

" coc.nvim settings
"making tab the auto-completion key for coc.nvim
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : '<Tab>'

" vim-pandoc settings
" augroup pandoc_syntax
"     au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
" augroup END
augroup pandoc_syntax
   autocmd! FileType vimwiki set syntax=markdown.pandoc
augroup END
"
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
" nnoremap <C-l> :call WriteAndLoad()<CR>   
nnoremap <C-d> :call GetJalaliDate()<CR>
nnoremap <C-f> :Telescope find_files<CR>
nnoremap <C-l> :nohls<CR>
" nnoremap <C-m> :set keymap=persian<CR>
nnoremap <C-x> :bd<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
