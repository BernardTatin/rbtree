#======================================================================
#
# Makefile
#
#======================================================================

PREFIX ?= ${HOME}
VERSION ?= debug

src = $(wildcard src/*.c)
obj = $(addprefix objs/,$(notdir $(src:.c=.o)))
dep = $(obj:.o=.d)


dbg = -g1
opt = -O1
ifeq ($(VERSION), debug)
dbg = -g
opt =
else ifeq ($(VERSION), release)
dbg =
opt = -O3
endif

name = rbtree

AR = ar
CC = gcc
CFLAGS = -pedantic -Wall -Wextra $(dbg) $(opt) -fPIC -std=c11

ifeq ($(shell uname -s), Darwin)
	lib_a = lib/lib$(name).a
	lib_so = lib/lib$(name).dylib
	shared = -dynamiclib
else
	lib_a = lib/lib$(name).a
	devlink = lib$(name).so
	soname = $(devlink).0
	lib_so = lib/$(soname).0
	shared = -shared -Wl,-soname=$(soname)
endif

.PHONY: all
all: dirs $(lib_so) $(lib_a)

.PHONY: dirs
dirs: bin lib objs

bin:
	mkdir -p $@
lib:
	mkdir -p $@
objs:
	mkdir -p $@

$(lib_a): $(obj)
	$(AR) rcs $(lib_a) $(obj)

$(lib_so): $(obj)
	$(CC) -o $@ $(shared) $(obj) $(LDFLAGS)

-include $(dep)

objs/%.o: src/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.d: %.c
	@$(CPP) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@

.PHONY: clean
clean:
	rm -fv $(obj) $(lib_a) $(lib_so)
	rm -fvR lib bin objs

.PHONY: install
install: all
	mkdir -p $(DESTDIR)$(PREFIX)/include $(DESTDIR)$(PREFIX)/lib
	cp src/rbtree.h $(DESTDIR)$(PREFIX)/include/rbtree.h
	cp $(lib_a) $(DESTDIR)$(PREFIX)/lib/$(notdir $(lib_a))
	cp $(lib_so) $(DESTDIR)$(PREFIX)/lib/$(notdir $(lib_so))
	[ -n "$(soname)" ] \
		&& cd $(DESTDIR)$(PREFIX)/lib \
		&& rm -f $(soname) $(devlink) \
		&& ln -s $(notdir $(lib_so)) $(soname) \
		&& ln -s $(soname) $(devlink) \
		|| true

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/include/rbtree.h
	rm -f $(DESTDIR)$(PREFIX)/lib/$(notdir $(lib_a))
	rm -f $(DESTDIR)$(PREFIX)/lib/$(notdir $(lib_so))
	[ -n "$(soname)" ] \
		&& rm -f $(DESTDIR)$(PREFIX)/lib/$(soname) \
		&& rm -f $(DESTDIR)$(PREFIX)/lib/$(devlink) \
		|| true
