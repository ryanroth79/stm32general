	// First example from vivonomicon's blog
	.syntax unified
	.cpu cortex-m3
	.fpu softvfp
	.thumb

	// Global memory locations
	.global vtable
	.global reset_handler

	/* The actual vector table */
	.type vtable, %object
	vtable :
	.word _estack
	.word reset_handler
	.size vtable, .-vtable

	// The reset handler
	.type reset_handler, %function
reset_handler:
	//set the stack pointer to the end of the stack
	// _estack is defined in the ld script
	LDR r0, =_estack
	MOV sp, r0

	// Set a value we can see in the debugger
	LDR r7 , =0xDEADBEEF
	MOV r0, #0
main_loop:
	// Add 1 to r0 until it overflows... Then repeat... forever...
	ADDS r0, r0, #1
	// Jump to the start of the loop again
	B main_loop

	.size reset_handler, .-reset_handler
	
