/* memory setup and definitions */
/* Following the example in "bare-metal" stm32 vivonomicon's blog */
_estack = 0x20001000;

MEMORY
{
  FLASH { rx } : ORIGIN = 0x08000000, LENGTH = 32K
		   RAM { rwx } : ORIGIN = 0x20000000, LENGTH = 4K
}
