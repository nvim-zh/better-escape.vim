function! better_escape#EscapeInsertOrNot() abort
  " If k is preceded by j, then remove j and go to normal mode.
  let line_text = getline('.')
  let cur_ch_idx = better_escape#CursorCharIdx()
  let pre_char = better_escape#CharAtIdx(line_text, cur_ch_idx-1)

  let l:ch1 = g:better_escape_shortcut[0]
  let l:ch2 = g:better_escape_shortcut[1]
  let l:ret_ch = l:ch2

  if pre_char ==# l:ch1 && exists('b:prev_ins_j_time')
      " time interval in milliseconds between last time you press j in insert
      " mode and the time you press k now
      let b:t_interval_from_j = reltimefloat(reltime(b:prev_ins_j_time)) * 1000
      if g:better_escape_debug == 1
        call better_escape#log(printf('Time interval between %s and %s: %.2f ms', l:ch1, l:ch2, b:t_interval_from_j), 'msg')
      endif
      if b:t_interval_from_j < g:better_escape_interval
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

