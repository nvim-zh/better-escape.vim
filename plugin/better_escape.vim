if !has('patch-7.4.1730')
  call better_escape#log('patch-7.4.1730 must exist for this plugin to work!', 'err')
  finish
endif

if &compatible || exists('g:loaded_better_escape')
  finish
endif

let g:loaded_better_escape = 1

let g:better_escape_interval = get(g:, "better_escape_interval", 150)

let g:better_escape_shortcut = get(g:, "better_escape_shortcut", ['jk',])

if type(g:better_escape_shortcut) == v:t_string
  let g:better_escape_shortcut = [g:better_escape_shortcut, ]
elseif type(g:better_escape_shortcut) != v:t_list
  call better_escape#log('Option g:better_escape_shortcut must be a string or list.', 'err')
  finish
endif

" We should check the validity of option given by user.
for shortcut in g:better_escape_shortcut
  if strchars(shortcut) != 2
    call better_escape#log('Only two-character shortcuts are supported! '
          \ . 'Make sure that all your shortcuts are made of two characters', 'err')
    finish
  endif
endfor

let g:better_escape_debug = get(g:, "better_escape_debug", 0)

function! s:get_initial_char() abort
  let initial_chars = []
  for l:shortcut in g:better_escape_shortcut
    let l:ch = better_escape#CharAtIdx(l:shortcut, 0)
    let initial_chars += [l:ch]
  endfor

  return initial_chars
endfunction

" The first character in each shortcut
let g:better_escape_shortcut_initials = s:get_initial_char()

" The time when the first char is pressed in each shortcut
let g:better_escape_initial_press_time = {}
for ch in g:better_escape_shortcut_initials
  let g:better_escape_initial_press_time[ch] = []
endfor

augroup ins_char
  autocmd!
  autocmd InsertCharPre * call better_escape#LogKeyPressTime()
augroup END

function! s:get_shortcut_keymap() abort
  let key_map = {}
  for l:shortcut in g:better_escape_shortcut
    let l:ch1 = better_escape#CharAtIdx(l:shortcut, 0)
    let l:ch2 = better_escape#CharAtIdx(l:shortcut, 1)
    if has_key(key_map, l:ch2)
      let key_map[l:ch2] += [l:ch1]
    else
      let key_map[l:ch2] = [l:ch1]
    endif
  endfor

  return key_map
endfunction

let s:shortcut_map = s:get_shortcut_keymap()

for k in keys(s:shortcut_map)
  let first_chars = s:shortcut_map[k]
  execute printf('inoremap <expr> %s better_escape#EscapeInsertOrNot(%s, "%s")', k, first_chars, k)
endfor
