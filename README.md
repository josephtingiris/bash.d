# bash.d

Most linux distributions use /etc/profile.d as a system-wide autoload for bash environment profiles.  For years, I've always mimic'ed this ability in my own ~/.bashrc looking in ~/etc/profile.d.  Years.  Many, many years.

Recently, I've wanted to be able to source (functions) prior to anything being sourced from etc/profile.d.  I needed a better, smarter, and a little more extensible bit of shell.

This is the repo for that.

bash.d

### typically; do one or the other, not both ...

* `etc/profile.d/000-bash.d.sh` is intended to be sourced _first_ in `/etc/profile.d`.  it can be linked, or copied there.
* `etc/profile.d/000-bash.d.sh` is intended to be sourced _first_ in `~/etc/profile.d`.  it can be linked, or copied there.

or, if you're like me, also linked or copied in your ~/etc/profile.d


## objectives

* pure bash; no subshells
* no loops; definite, predictable order of execution
* don't break /etc/profile.d
* don't rely on /etc; doesn't need root access
* work _with_ /etc/bash.d, /etc/profile.d, ~/etc/bash.d & ~/etc/profile.d; profile.d should always be last (and win)
* no duplicate executions
