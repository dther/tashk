# tashk, the unix todo.txt manager

tashk is a minimal CLI for dealing with todo.txt files.
It assumes POSIX utilities (sh, cat, grep, sed, etc),
and deeply integrates with `git`.

Rather than implementing new functionality,
tashk focuses on being a wrapper for various POSIX utilities
and providing an interface for easy transactional synchronisation
via `git`.

It is intended as an alternative to [todo-cli][#todo-cli]
with the benefit of not relying on bash,
and an alternative to Dropbox workflows which rely on storing files on
"the Cloud" (Dropbox's computers),
by supporting automatic synchronisation with a remote `git` repository.
However, it is not compatible with todo-cli and should not be used as a
drop-in replacement.

## Getting started

 1. Make a git repository somewhere.
 2. Set `$TASHK_DIR` to its location.
 3. Put your todo.txt file in there.

## Bugs
Many. But in particular:

 - No internal directories, yet. All todo.txt files must be on the top level.
 - Only `edit` is properly implemented.

## Tips and Tricks

### How can I automatically synchronise my todo-lists?
In the Git directory of `$TASHK_DIR` (by default, `$TASHK_DIR/.git/`),
put something like this in `hooks/post-commit`:

	git push origin

And, of course, set `origin` to be a private git repo.
It can be github, gitlab, whatever, but ideally it should be a bare repository
on a computer you own or a VPS you have root access on.

The caveat to this, of course, is that it means all commits get pushed
immediately, making `--force` the only real way to delete commits.
This isn't as much a problem since I hope you're the only person
with access to this git repo anyway...

## TODO (heh)

 - add command-specific flags
 - better help
 - man pages
 - pretty listing
 - better arg support
 - extension system
