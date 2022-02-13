"バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
 set noswapfile

" init.vimを保存したら自動反映
autocmd BufWritePost  ~/.config/nvim/init.vim  so ~/.config/nvim/init.vim

" エンコーディング
set encoding=utf-8
scriptencoding utf-8

"help日本語化
set helplang=ja

"行番号を表示
set number

set expandtab                                                   " tabを複数のspaceに置き換え
set tabstop=2                                                   " tabは半角2文字
set shiftwidth=2


" ヤンクするとクリップボードに保存される
set clipboard+=unnamed

nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambdalisue/fern.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'kassio/neoterm'
Plug 'cohama/lexima.vim'
call plug#end()

" neoterm
nnoremap <c-t><c-t> :Ttoggle<CR>
tnoremap <c-t><c-t> <C-¥><C-n>:Ttoggle<CR>
let g:neoterm_default_mod = 'belowright'
let g:neoterm_size=15
let g:neoterm_autoinsert = 1

" カラーテーマ
colorscheme codedark

" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

"" vim-airline
let g:airline#extensions#tabline#enabled = 1
" ステータスラインに表示する項目を変更する
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ ['z']
  \ ]
let g:airline_section_c = '%t %M'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
" 変更がなければdiffの行数を表示しない
let g:airline#extensions#hunks#non_zero_only = 1 

" タブラインの表示を変更する
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_close_button = 0

"アイコンを表示
let g:fern#renderer = 'nerdfont'

