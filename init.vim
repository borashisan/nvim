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

";でコマンドを入力できるようにする
noremap ; :

" ヤンクするとクリップボードに保存される
set clipboard+=unnamed

nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
call plug#begin()
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'kassio/neoterm'
Plug 'cohama/lexima.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ngmy/vim-rubocop'
Plug 'APZelos/blamer.nvim'
Plug 'vim-syntastic/syntastic'
call plug#end()

"syntastic
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
"let g:syntastic_ruby_checkers = ['rubocop']

"rubocop"
let g:vimrubocop_config = './.rubocop.yml'

"blamer"
let g:blamer_enabled = 1
let g:blamer_template = '<commit-short> <committer>, <committer-time> • <summary>'

"emmet-vim
let g:user_emmet_settings = {
\  'variables' : {
\    'lang' : "ja"
\  },
\  'indentation' : '  ',
\  'html' : {
\    'snippets' : {
\      'html:5': "<!DOCTYPE html>\n"
\        ."<html lang=\"${lang}\">\n"
\        ."<head>\n"
\        ."\t<meta charset=\"${charset}\" \/>\n"
\        ."\t<link rel=\"stylesheet\" href=\"\" \/>\n"
\        ."\t<meta name=\"description\" content=\"\" \/>\n"
\        ."\t<title></title>\n"
\        ."</head>\n"
\        ."<body>\n\t${child}|\n\t<script type=\"text/javascript\" src=\"\"></script>\n</body>\n"
\        ."</html>",
\    }
\  }
\}
"vim-lsp
"nnoremap <expr> <C-]> execute('LspPeekDefinition') =~ "not supported" ? "\<C-]>" : ":LspDefinition<cr>"

"ctags
"nnoremap <C-]> g<C-]>

" coc
autocmd FileType scss setl iskeyword+=@-@
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <C-t> <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" neoterm
nnoremap <c-t><c-t> :Ttoggle<CR>
let g:neoterm_default_mod = 'belowright'
let g:neoterm_size=20
let g:neoterm_autoinsert = 1

" カラーテーマ
colorscheme codedark

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

"" vim-airline
let g:airline#extensions#tabline#enabled = 1
" ステータスラインに表示する項目を変更する
"let g:airline#extensions#default#layout = [
"  \ [ 'a', 'b', 'c' ],
"  \ ['z']
"  \ ]
"let g:airline_section_c = '%t %M'
"let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
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
"control + p, bでタブ切り替え
nmap <S-Left> <Plug>AirlineSelectPrevTab
nmap <S-Right> <Plug>AirlineSelectNextTab

"アイコンを表示
let g:fern#renderer = 'nerdfont'

"隠しファイル
let g:fern#default_hidden=1

"" fzf.vim
" Ctrl+pでファイル検索を開く
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>
nnoremap <C-e> :History<CR>

" Ctrl+gで文字列検索を開く
" <S-?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" frでカーソル位置の単語をファイル検索する
nnoremap fr vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap fr y:Rg <C-R>"<CR>

" fbでバッファ検索を開く
nnoremap fb :Buffers<CR>
" fpでバッファの中で1つ前に開いたファイルを開く
nnoremap fp :Buffers<CR><CR>
" flで開いているファイルの文字列検索を開く
nnoremap fl :BLines<CR>
" fmでマーク検索を開く
nnoremap fm :Marks<CR>
" fhでファイル閲覧履歴検索を開く
nnoremap fh :History<CR>
" fcでコミット履歴検索を開く
nnoremap fc :Commits<CR>
