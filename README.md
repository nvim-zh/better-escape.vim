# Description

A lot of people have used `jk` or `kj` or `kk` mappings in insert mode in order
to leave the insert mode quickly. However, when you press the first key in
these mappings, Vim will wait for `timeoutlen` milliseconds before writing this
char to buffer, which is annoying.

Better-escape.vim is a Vim/Neovim plugin to enable the users to escape from
insert mode quickly using their customizied key combinations, **without
experiencing the lag**.

# Install

Use your favorite plugin manager to install it.

+ Use [vim-plug](https://github.com/junegunn/vim-plug): `Plug 'jdhao/better-escape.vim'`
+ Use [dein](https://github.com/Shougo/dein.vim): `call dein#add('jdhao/better-escape.vim')`

# How to use?

The default shortcut for leaving insert mode is `jk`. First press `j`, then
**quickly** press `k`, you will leave insert mode.

By default, the time interval threshold for the pressing of `j` and `k` is set
to 150 ms. That is, if the time interval between pressing k and pressing j is
above the threhold, we assume that you want to insert `jk` literally. Otherwise,
we assume you want to leave insert mode. This time interval can be customized via
option `g:better_escape_interval`:

```vim
" set time interval to 200 ms
let g:better_escape_interval = 200
```

If you want to use other shortcut, you can customize via option `g:
better_escape_shortcut`:

```vim
" use jj to escape insert mode.
let g:better_escape_shortcut = 'jj'
```

# Doc

See `:h better-escape.txt`.
