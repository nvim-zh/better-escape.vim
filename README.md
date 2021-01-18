# Description

A lot of people have been mapping `jk` or `kj` or `kk` to <kbd>ESC</kbd> in
order to escape insert mode quickly. However, when we press the first key in
these mappings, Vim will wait for [`timeoutlen`](https://neovim.io/doc/user/options.html#'timeoutlen')
milliseconds before writing this char to buffer. The apparent lag caused by
this behaviour is annoying.

Better-escape.vim is a plugin to help Vim/Nvim users escape from insert mode
quickly using their customized key combinations, **without experiencing the
lag**.

# Install

Use your favorite plugin manager to install it:

+ Use [vim-plug](https://github.com/junegunn/vim-plug): `Plug 'jdhao/better-escape.vim'`
+ Use [dein](https://github.com/Shougo/dein.vim): `call dein#add('jdhao/better-escape.vim')`

# How to use?

The default shortcut for leaving insert mode is `jk`: first press `j`, then
**quickly** press `k`, you will leave insert mode.

By default, the time interval threshold between pressing `j` and `k` is set to
150 ms. That is, if the time interval between pressing of `k` and `j` is above
the threshold, `jk` will be inserted literally. Otherwise, we assume you want
to leave insert mode. The time interval can be customized via option `g:better_escape_interval`:

```vim
" set time interval to 200 ms
let g:better_escape_interval = 200
```

If you want to use other shortcut, you can customize via option `g:better_escape_shortcut`:

```vim
" use jj to escape insert mode.
let g:better_escape_shortcut = 'jj'
```

## Multiple shortcuts

Some people may prefer to use multiple shortcuts. This is also supported:

```vim
let g:better_escape_shortcut = ['jk', 'jj', 'kj', 'лл']
```

# Doc

See [`:h better-escape.txt`](doc/better-escape.txt).
