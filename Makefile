# Files
SRCS = $(wildcard sources/*.asm)
OBJS = $(patsubst sources/%.asm, build/%.o, $(SRCS))
EXE = bin/prog

all: $(EXE)

run: all
	./$(EXE)

dev: all
	gdb $(EXE)

$(EXE): $(OBJS) | bin
	gcc -no-pie $(OBJS) -o $@

build/%.o: sources/%.asm | build
	nasm -g -f elf64 $< -o $@

bin build:
	mkdir -p $@

clean:
	rm -rf bin build

.PHONY: all clean run dev