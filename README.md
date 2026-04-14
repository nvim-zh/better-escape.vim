# 💡 Motivation

A lot of people have been mapping `jk` or `kj` or `kk` to <kbd>ESC</kbd> in
order to escape insert mode quickly. However, when we press the first key in
these mappings, Vim/Nvim will wait for [`timeoutlen`](https://neovim.io/doc/user/options.html#'timeoutlen')
milliseconds before writing this char to buffer. The apparent lag caused by
this behaviour is annoying.

Better-escape.vim is created to help Vim/Nvim users escape insert mode quickly
using their customized key combinations, **without experiencing the lag**.

# 🚀 Quickstart

## Requirements

+ Neovim: 0.4.4 and above
+ Vim: 8.0 and above (not tested on Vim 7.4)

## Install

+ [vim-plug][vim-plug-github]: `Plug 'nvim-zh/better-escape.vim'`
+ [lazy.nvim][lazy-nvim-github]:
```lua
  { "nvim-zh/better-escape.vim", event = "VeryLazy" },
```

## How to use?

This plugin works out of the box. The default shortcut for escaping insert mode
is `jk`, that is, pressing `j` first, then pressing `k` **quickly**, you will
leave insert mode.

# 🔧 Configuration

## How to change shortcut

If you want to use other shortcuts, you can customize via option `g:better_escape_shortcut`:

```vim
" use jj to escape insert mode.
let g:better_escape_shortcut = 'jj'
```

## Adjust time interval threshold

By default, the time interval threshold between pressing `j` and `k` is 150 ms.
That is, if the time interval between pressing `k` and `j` is above the
threshold, `jk` will be inserted literally. Otherwise, we assume you want to
leave insert mode. The threshold can be customized via option `g:better_escape_interval`:

```vim
" set time interval to 200 ms
let g:better_escape_interval = 200
```

## Using multiple shortcuts?

Some people may prefer to use multiple shortcuts. This is also supported:

```vim
# non-ASCII shortcuts are also supported for non-English keyboard.
let g:better_escape_shortcut = ['jk', 'jj', 'kj', 'лл']
```

## Debug and choose suitable interval

Sometimes, you may wonder why the given escape shortcut does not work as intended.
Maybe it is because you have not pressed the two keys fast enough.
To get the interval between key presses and help you to set a reasonable interval,
use the option `g:better_escape_debug`:

```vim
" enable debug (some message will be shown)
let g:better_escape_debug = 1
```

Then run command `:messages` to check the debug log.

# 📚 Documentation

See [`:h better-escape.txt`](doc/better-escape.txt).

# 📝 License

This plugin is released under the MIT License.

# ❤️  Similar projects

+ https://github.com/Krafi2/jeskape.nvim
+ https://github.com/zhou13/vim-easyescape
+ https://github.com/max397574/better-escape.nvim (a lua re-implementation of this plugin)

<!-- References -->
[lazy-nvim-github]: https://github.com/folke/lazy.nvim
[vim-plug-github]: https://github.com/junegunn/vim-plug
