# VIM SnipMate snippets for Fortissimo

This is a Vim plugin for adding SnipMate snippets that help you write
Fortissimo code.

## Installation

Clone this repo into whatever dorectory you normally install plugins
into. In Janus, they go in `~/.janus`

#### Janus

```
$ cd ~/.janus
$ git clone git@github.com:technosophos/vim-fortissimo-snippets.git fortissimo-snippets.after
```

## Usage

To create a new command:

- Create the file, e.g. FooCommand
- Edit the file
- In insert mode, type `fcommand`<tab>

This will scaffold a new command for you.

While building chains, you can use snippets like `->does`, `->using`,
and `->group` to scaffold out. Most of the chaining methods are
snippetized.

## License

MIT.
