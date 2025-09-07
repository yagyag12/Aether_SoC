RISCV_TOOLCHAIN_DIR = /opt/riscv32i/bin
GCC = $(RISCV_TOOLCHAIN_DIR)/riscv32-unknown-elf-gcc
OBJ_DUMP = $(RISCV_TOOLCHAIN_DIR)/riscv32-unknown-elf-objdump
OBJ_COPY = $(RISCV_TOOLCHAIN_DIR)/riscv32-unknown-elf-objcopy

INC_DIR = inc
SRC_DIR = src
ASM_SRC_DIR = .
RESULT_DIR = .
MEM_SIZE = 2048

# Automatically find all .c files in src and create corresponding .o files
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c, $(RESULT_DIR)/%.o, $(SRC_FILES))

# Add main.o and startup file
OBJ_FILES += $(RESULT_DIR)/main.o $(ASM_SRC_DIR)/start.o

all: $(RESULT_DIR)/firmware.hex $(RESULT_DIR)/dumpfile

$(RESULT_DIR)/firmware.hex: $(RESULT_DIR)/firmware.bin makehex.py
	python3 makehex.py $< $(MEM_SIZE) > $@

$(RESULT_DIR)/firmware.bin: $(RESULT_DIR)/firmware.elf
	$(OBJ_COPY) -O binary $< $@

$(RESULT_DIR)/dumpfile: $(RESULT_DIR)/firmware.elf
	$(OBJ_DUMP) -d $^ > $@

# Compile firmware ELF file with all detected object files
$(RESULT_DIR)/firmware.elf: $(OBJ_FILES) sections.lds
	$(GCC) -Og -mabi=ilp32 -march=rv32i -ffreestanding -nostdlib -o $@ \
		-Wl,--build-id=none,-Bstatic,-T,sections.lds,-Map,$(RESULT_DIR)/firmware.map,--strip-debug $(OBJ_FILES) -lgcc

# Generic rule to compile all .c files in src automatically
$(RESULT_DIR)/%.o: $(SRC_DIR)/%.c
	$(GCC) -c -I$(INC_DIR) -mabi=ilp32 -march=rv32i -Og --std=c99 -ffreestanding -nostdlib -o $@ $<

# Compile main.o from main.c
$(RESULT_DIR)/main.o: main.c
	$(GCC) -c -I$(INC_DIR) -I$(SRC_DIR) -mabi=ilp32 -march=rv32i -Og --std=c99 -ffreestanding -nostdlib -o $@ $<

# Compile startup assembly code
$(ASM_SRC_DIR)/start.o: $(ASM_SRC_DIR)/start.S
	$(GCC) -c -mabi=ilp32 -march=rv32i -o $@ $<

clean:
	rm -f $(RESULT_DIR)/*.o dumpfile *.elf *.hex *.bin *.map

