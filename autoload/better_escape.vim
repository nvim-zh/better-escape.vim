function! better_escape#EscapeInsertOrNot(ch1, ch2) abort
  let cur_ch_idx = better_escape#CursorCharIdx()
  let pre_char = better_escape#CharAtIdx(getline('.'), cur_ch_idx-1)

  let l:ret_ch = a:ch2

  let l:ch1_press_time = g:better_escape_initial_press_time[a:ch1]
  if pre_char ==# a:ch1 && l:ch1_press_time != []
      " time interval in milliseconds between last time you press `ch1` in insert
      " mode and the time you press `ch2` now
      let l:time_interval = reltimefloat(reltime(l:ch1_press_time)) * 1000
      if g:better_escape_debug == 1
        call better_escape#log(printf('Time interval between pressing %s and %s: %.2f ms', a:ch1, a:ch2, l:time_interval), 'msg')
      endif

      if l:time_interval < g:better_escape_interval
        let l:ret_ch = "\b\e"
      endif
  endif

  return l:ret_ch
endfunction

function! better_escape#CursorCharIdx() abort
  " A more concise way to get character index under cursor.
  let cursor_byte_idx = col('.')
  if cursor_byte_idx == 1
    return 0
  endif

  let pre_cursor_text = getline('.')[:col('.')-2]
  return strchars(pre_cursor_text)
endfunction

function! better_escape#CharAtIdx(str, idx) abort
  " Get char at idx from str. Note that this is based on character index
  " instead of the byte index.
  return strcharpart(a:str, a:idx, 1)
endfunction

function! better_escape#log(msg, level) abort
  if a:level ==# 'err'
    echohl ErrorMsg
  endif
  echomsg '[Better-escape] ' . a:msg
  if a:level ==# 'err'
    echohl None
  endif
endfunction

function! better_escape#LogKeyPressTime() abort
  if has_key(g:better_escape_initial_press_time, v:char)
    let g:better_escape_initial_press_time[v:char] = reltime()
  endif
endfunction
