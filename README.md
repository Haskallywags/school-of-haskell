# School of Haskell

A guided tour through [BiteMyApp][1]'s comprehensive [Haskell tutorial][2].

  [1]: https://github.com/bitemyapp
  [2]: https://github.com/bitemyapp/learnhaskell

## Installing Haskell

For those just getting started, follow these steps to install the latest
version of **GHC**. For those using OSX, the recommend package manager is
[Homebrew][3]. For those using other OS's, replace `brew install` with your own
package manager in any following shell commands (lines prefixed by a `$`).

  [3]: http://brew.sh/

1. Install GHC (the Haskell compiler) and Cabal (the Haskell package manager)

    $ brew install ghc cabal-install

2. Add `$HOME/.cabal/bin` to your shell's `$PATH` variable
3. Install only the Haskell modules required globally. Everything else will be
   installed in project-specific sandboxes.

    $ cabal update
    $ cabal install hspec

## Enabling a great Haskell toolset (using Vim)

Part of what makes Haskell so fantastic is the tooling that can be built around
a compiler that can infer so much about its programs. These instructions are
for those using Vim, but similar instructions should be available for Emacs or
other text editors.

1. Install GHC-mod

    $ cabal install happy
    $ cabal install ghc-mod

2. Install the [GHC-mod plugin for Vim][4]. If you are inexperienced with
   installing Vim plugins, I recommend using [Vundle][5].

  [4]: https://github.com/eagletmt/ghcmod-vim
  [5]: https://github.com/gmarik/Vundle.vim

3. (Optional) Add shortcut keys for the GHC-mod commands. Mine are listed
   below, which can be listed in your `$HOME/.vimrc` file.

    au FileType haskell nnoremap <buffer> <Leader>ht :GhcModType<CR>
    au FileType haskell nnoremap <buffer> <Leader>hh :GhcModTypeClear<CR>
    au FileType haskell nnoremap <buffer> <Leader>hc :GhcModCheck<CR>
    au FileType haskell nnoremap <buffer> <Leader>hl :GhcModLint<CR>

## TODO: Initializing a new Haskell project
