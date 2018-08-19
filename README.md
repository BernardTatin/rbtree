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
make version=debug clean all
```

To optimize:

```bash
make version=release clean all
```

At the end of the compilation, you will find objects files in `objs`, libraries 
in `lib` and, in future versions, binaries in `bin`.

## Installation

You can edit `Makefile` and change the `PREFIX` value. The best way to do it is 
by using the command line:

```bash
make PREFIX=/usr/local install
make PREFIX=/usr/local uninstall
```


