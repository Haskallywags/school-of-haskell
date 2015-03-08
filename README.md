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

   ```
   $ brew install ghc cabal-install
   ```

2. Add `$HOME/.cabal/bin` to your shell's `$PATH` variable
3. Install only the Haskell modules required globally. Everything else will be
   installed in project-specific sandboxes.

   ```
   $ cabal update
   $ cabal install hspec
   ```

## Enabling a great Haskell toolset (using Vim)

Part of what makes Haskell so fantastic is the tooling that can be built around
a compiler that can infer so much about its programs. These instructions are
for those using Vim, but similar instructions should be available for Emacs or
other text editors.

1. Install GHC-mod

   ```
   $ cabal install happy
   $ cabal install ghc-mod
   ```

2. Install the [GHC-mod plugin for Vim][4]. If you are inexperienced with
   installing Vim plugins, I recommend using [Vundle][5].

  [4]: https://github.com/eagletmt/ghcmod-vim
  [5]: https://github.com/gmarik/Vundle.vim

3. (Optional) Add shortcut keys for the GHC-mod commands. Mine are listed
   below, which can be listed in your `$HOME/.vimrc` file.

   ```viml
   au FileType haskell nnoremap <buffer> <Leader>ht :GhcModType<CR>
   au FileType haskell nnoremap <buffer> <Leader>hh :GhcModTypeClear<CR>
   au FileType haskell nnoremap <buffer> <Leader>hc :GhcModCheck<CR>
   au FileType haskell nnoremap <buffer> <Leader>hl :GhcModLint<CR>
   ```

**NOTE:** If you've installed GHC via a package manager, you're probably using
version 7.8.4 or less (which you can check via `$ ghc --version`. If so, you
_must_ use Cabal version 1.20.0.6 or less for ghc-mod to function properly.
You may force the Cabal version via `$ cabal install cabal-install-1.20.0.6`.

## Beginning a homework assignment

Before beginning a homework, you should:

1. Branch this project

   ```
   $ git branch [an appropriate branch name for the homework]
   ```

2. Initialize a Cabal sandbox in the current homework directory and install
   any required packages. For example:

   ```
   $ cd cis194/homework-1
   $ cabal sandbox init
   $ cabal install --only-dependencies --enable-tests
   $ cabal configure --enable-tests
   ```

3. Run the specs to ensure they fail

   ```
   $ cabal test --show-details=always --test-options="--color"
   ```

You're now ready to begin replacing the `undefined` functions with actual
function definitions. Running and passing the specs as you write functions
will ensure that your later work is built upon previous correct work.

## Discovering functions

Haskell doesn't come packaged with a standard library as do many other
languages. Instead, it has the [Haskell Platform][6]—a collection of curated
packages deemed most useful and of high quality. While it's **not
recommended** that you install the platform _per se_, I do recommend that you
consult the [Haskell Platform documentation][7] as your first place to
discover new libraries and functions and install the libraries as needed.

  [6]: https://www.haskell.org/platform/
  [7]: http://lambda.haskell.org/platform/doc/current/frames.html

Another great way to discover functions is via [Hoogle][8], the Haskell
function search engine. With Hoogle, functions may be discovered by name _or_
type signature.

  [8]: http://www.haskell.org/hoogle/
