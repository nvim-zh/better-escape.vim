if &compatible || exists('g:loaded_better_escape')
  finish
endif

let g:loaded_better_escape = 1

if !exists('g:better_escape_interval')
  let g:better_escape_interval = 150
endif

if !exists('g:better_escape_shortcut')
  let g:better_escape_shortcut = 'jk'
endif

if len(g:better_escape_shortcut) != 2
  echoerr 'Option g:better_escape_shortcut takes exactly two characters!'
  finish
endif

if !exists('g:better_escape_debug')
  let g:better_escape_debug = 0
endif

let s:char1 = g:better_escape_shortcut[0]
let s:char2 = g:better_escape_shortcut[1]

augroup ins_char
  autocmd!
  autocmd InsertCharPre * if v:char ==# s:char1 | let b:prev_ins_j_time = reltime() | endif
augroup END

execute printf('inoremap <expr> %s better_escape#EscapeInsertOrNot()', s:char2)
