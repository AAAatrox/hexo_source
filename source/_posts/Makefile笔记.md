---
title: Makefile笔记
updated: 1558057719
date: 2019-04-17 22:20:21
tags:
 - c
 - Makefile
---


```makefile
CC       := gcc
CFLAGS   := -lpthread -g
TARGETS  := shit
INC      := $(shell find -L ./ -name "*.h")

a:
	gcc a.c ${INC} $(par) ${CFLAGS} -o shit # example: make a run par="-O2"

run:
	./shit

clean:
	rm ./shit

fuck:
	@echo $(par) # example: make fuck par="fuck you"

dump:
	objdump ./shit -S > fuck

gdb:
	gdb ./shit -tui

cgdb:
	cgdb ./shit
```

- 头文件

```makefile
SRCS    := $(shell find ./src/ -maxdepth 1 -name "*.cpp")
INC     := -I./include
CFLAGS  := -Wall -Werror

run:    
	g++ $(CFLAGS) $(INC) $(SRCS) -o md_parser
	./md_parser
```
