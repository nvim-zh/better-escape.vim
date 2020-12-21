if !has('patch-7.4.1730')
  call better_escape#log('patch-7.4.1730 must exist for this plugin to work!', 'err')
  finish
endif

if &compatible || exists('g:loaded_better_escape')
  finish
endif

let g:loaded_better_escape = 1

if !exists('g:better_escape_interval')
  let g:better_escape_interval = 150
endif

if !exists('g:better_escape_shortcut')
  let g:better_escape_shortcut = ['jk', ]
else
  if type(g:better_escape_shortcut) == v:t_string
    let g:better_escape_shortcut = [g:better_escape_shortcut, ]
  elseif type(g:better_escape_shortcut) != v:t_list
    call better_escape#log('Type of option g:better_escape_shortcut must be String or List.', 'err')
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
endif

if !exists('g:better_escape_debug')
  let g:better_escape_debug = 0
endif

function! s:get_initial_char() abort
  let l:init_ch_freq = {}
  for l:shortcut in g:better_escape_shortcut
    let l:ch = better_escape#CharAtIdx(l:shortcut, 0)
    if !has_key(l:init_ch_freq, l:ch)
      let l:init_ch_freq[l:ch] = 1
    else
      let l:init_ch_freq[l:ch] += 1
    endif
  endfor

  return keys(l:init_ch_freq)
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

for shortcut in g:better_escape_shortcut
  let [ch1, ch2] = split(shortcut, '\zs')
  execute printf('inoremap <expr> %s better_escape#EscapeInsertOrNot("%s", "%s")', ch2, ch1, ch2)
endfor
