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
drop-in replacement. `tashk help` should tell you everything you need to know.

In summary, it's like `todo.sh` but more `pass`-like.

## Getting started

 1. Make a git repository somewhere.
 2. Set `$TASHK_DIR` to its location.
 3. Put your todo.txt file in there.

## Bugs
Many. But in particular:

 - No internal directories, yet. All todo.txt files must be on the top level.
 - Only `edit` is properly implemented.

## Tips and Tricks
### How can I make this run faster?
Internally, the commands are wrappers for various POSIX utilities
that would probably be faster if they made use of GNU/BSD extensions.
I haven't gotten around to detecting/toggling the use of said extensions.

Feel free to edit the script to your liking in the meantime.

### How do I receive changes from a remote location?
`tashk git pull origin`. I plan on making this something tashk does automatically
for you, but I'm still thinking about how that should be handled.

### How can I automatically write my changes to a remote location?
In the Git directory of `$TASHK_DIR` (by default, `$TASHK_DIR/.git/`),
put something like this in `hooks/post-commit`:

	git push origin

And, of course, set `origin` to be a private git repo.
It can be github, gitlab, whatever, but ideally it should be a bare repository
on a computer you own or a VPS you have root access on.

The caveat to this, of course, is that it means all commits get pushed
immediately, making `--force` the only real way to delete commits.
This isn't as much a problem since this is a personal organisation program,
so I hope you aren't using a public repo...

### How can I do that periodically?
In your crontab/cron.d/systemd script pile, put:

	tashk git push origin

Then configure your system to do that command however often you please to
automatically write your changes to origin whenever a certain time occurs.

### How do I do that whenever...
I think you get the picture from the last two tips. Git is really neat.
Just run `tashk git push origin` and it'll push your changes to your
super cool open source dropbox alternative.

## TODO (heh)

 - add command-specific flags
 - better help
 - man pages
 - pretty listing
 - better arg support
 - extension system
