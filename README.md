# `rbtree`

Simple balanced binary search tree (red-black tree) library.

Copyright (C) 2011-2014  **John Tsiombikas** <*nuclear@member.fsf.org*>

`rbtree` is free software, feel free to use, modify, and redistribute it, under
the terms of the 3-clause BSD license. See `COPYING` for details.

# Note about this fork

First, no more `configure` or `Makefile.in`. Second,  a big refactoring 
of the `Makefile` to fit my needs.

## Compilation 

To debug:

```bash
make dbg='-g' all
```

To optimize:

```bash
make opt='-O3' all
```

## Installation

You can edit `Makefile` and change the `PREFIX` value. The best way to do it is 
by using the command line:

```bash
make PREFIX=/usr/local install
make PREFIX=/usr/local uninstall
```


