# vim_config
This git is for vim config profile

Part1 Quick install vim plugins
---------------------------------------
Step1 Push the following files to /HOME/.vim/
```
    mis-func.vim
    run-pathogen.sh
    run-pathogen.vim
```
Step2 Push the following files to /HOME/.vimrc
```
    vimrc
```  

Step3 install all plug
```
    bash ~/.vim/run-pathogen.sh -a
```

Step4 Show all plugins
```
$   bash ~/.vim/run-pathogen.sh -l
pathogen                : [OK]
winmanager              : [OK]
bufexplorer             : [OK]
taglist         : [OK]
tagbar          : [OK]
nerdtree_red            : [OK]
lightline               : [OK]
airline         : [OK]
airline_themes          : [OK]
colors_solarized                : [OK]
colorschemes            : [OK]
youcompleteme           : [OK]
coc             : [OK]
global          : [OK]
ctrlp           : [OK]
drawit          : [FAIL]
```

Note: "bash ~/.vim/run-pathogen.sh -i coc" to install coc plugins.


Part2 script part function explanation
-----------------------------------------
1 on/off plugins function,
vim ~/.vim/run-pathogen.vim 
```
"  [Disable it] - let s:bypass_*** = 1
"  [Enable  it] - let s:bypass_*** = 0
" --------------------------------------------------------------------------------------------------
let s:bypass_pathogen         = 0
let s:bypass_winmanager       = 0
let s:bypass_nerd_tree        = 0
let s:bypass_minibufexplorer  = 0
let s:bypass_taglist          = 0
let s:bypass_tagbar           = 0
let s:bypass_lightline        = 0
let s:bypass_airline          = 0
let s:bypass_airline_themes   = 0
let s:bypass_colors_solarized = 0
let s:bypass_colorschemes     = 0
let s:bypass_youcompleteme    = 0
let s:bypass_coc              = 0
let s:bypass_global           = 0
let s:bypass_ctrlp            = 0
let s:bypass_drawit           = 0
```

2 gtags-cscope part(vim ~/.vim/run-pathogen.vim )
```
 if !(exists('s:bypass_global') && s:bypass_global)
 " gtags-cscope
   let GtagsCscope_Auto_Load = 1       " auto loading
   let GtagsCscope_Auto_Map = 1        " To use the default key/mouse mapping
   let GtagsCscope_Quiet = 1           " Do not display error message

   " Find symbol       :cs find 0 or s
   nmap <C-f> :cs find s <C-R>=expand("<cword>")<CR><CR>
   "nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>

   " Find definition   :cs find 1 or g
   nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>

```

3 Tab & space map(vim ~/.vim/mis-func.vim)
```
" 1. Switch Tab width
nnoremap  <F6> :<C-u>call <SID>TabToggle()<CR>
inoremap  <F6> <ESC>:<C-u>call <SID>TabToggle()<CR>i

let g:kiki_4tabs = 2
function! s:TabToggle()
  if exists("g:kiki_4tabs")
    if g:kiki_4tabs == 0
      let g:kiki_4tabs = 1|setl ts=4 sts=4 shiftwidth=4 noet|echom "Use 1 Tab"
    elseif g:kiki_4tabs == 1
      let g:kiki_4tabs = 2|setl ts=4 sts=4 shiftwidth=4 et|echom "Use 4 Space"
    else
      let g:kiki_4tabs = 0|setl ts=2 sts=2 shiftwidth=2 et|echom "Use 2 Space"
    endif
  endif
```
--> F6 to switch table map.

