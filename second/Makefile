TARGET = main
LD_SCRIPT = STM32L152R8T6.ld
MCU_SPEC = cortex-m3

TOOLCHAIN = /usr

CC = $(TOOLCHAIN)/bin/arm-none-eabi-gcc
AS = $(TOOLCHAIN)/bin/arm-none-eabi-as
LD = $(TOOLCHAIN)/bin/arm-none-eabi-ld
OC = $(TOOLCHAIN)/bin/arm-none-eabi-objcopy
OD = $(TOOLCHAIN)/bin/arm-none-eabi-objdump
OS = $(TOOLCHAIN)/bin/arm-none-eabi-size

# Assembly flags
ASFLAGS += -c
ASFLAGS += -O0
ASFLAGS += -mcpu=$(MCU_SPEC)
ASFLAGS += -mthumb
ASFLAGS += -Wall
ASFLAGS += -g
# Set error messages to show on 1 line...
ASFLAGS += -fmessage-length=0

# C compiler flags
CFLAGS += -mcpu=$(MCU_SPEC)
CFLAGS += -mthumb
CFLAGS += -Wall
CFLAGS += -g
# Set the errors to be a line here too...
CFLAGS += -fmessage-length=0
# Ignore some junk?
CFLAGS += --specs=nosys.specs

# Linker flags
LSCRIPT = ./$(LD_SCRIPT)
LDFLAGS += -g
LDFLAGS += -mcpu=$(MCU_SPEC)
LDFLAGS += -mthumb
LDFLAGS += -Wall
LDFLAGS += --specs=nosys.specs
LDFLAGS += -nostdlib
LDFLAGS += -lgcc
LDFLAGS += -T$(LSCRIPT)

# more interesting sections...
VECT_TBL = ./vector_table.s
AS_SRC = ./core.s
C_SRC = ./main.c

OBJS = $(VECT_TBL:.s=.o)
OBJS += $(AS_SRC:.s=.o)
OBJS += $(C_SRC:.c=.o)

.PHONY: all
all: $(TARGET).bin

%.o: %.s
	$(CC) -x assembler-with-cpp $(ASFLAGS) $< -o $@

%.o: %.c
	$(CC) -c $(CLFAGS) $(INCLUDE) $< -o $@

main.elf: $(OBJS)
	$(CC) $^ $(LDFLAGS) -o $@

main.bin: $(TARGET).elf
	$(OC) -S -O binary $< $@
	$(OS) $<

.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).elf





