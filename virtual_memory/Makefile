
RISCV_GCC ?= riscv64-unknown-elf-gcc
OBJDUMP ?= riscv64-unknown-elf-objdump
SIM ?= spike
FLAGS ?= -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -O0
LINKER ?= link.ld
TARGET ?= src/entry.S src/*.c
OUT ?= build/bin_o

default: all

all: $(TARGET) | build
	$(RISCV_GCC) $(FLAGS) -T$(LINKER) -o $(OUT) $^

asm: $(TARGET) | build
	$(RISCV_GCC) $(FLAGS) -S -T$(LINKER) -o $(OUT) $^

build:
	mkdir -p build

run: $(OUT)
	$(SIM) -d $^

dump: $(OUT)
	$(OBJDUMP) -d $^

.PHONY: clean
clean:
	rm -rf build
