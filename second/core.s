	.syntax unified
	.cpu cortex-m3
	.fpu softvfp
	.thumb

	// Global Values
	.global reset_handler

	// Now define it...
	//
	.type reset_handler, %function
reset_handler:
	// Set the stack pointer to the end of the _estack value
	//
	LDR r0, =_estack
	MOV sp, r0

	// Something about copying memory from flash to the data memory... And set some 0s
	//
	MOVS r0, #0
	LDR r1, =_sdata
	LDR r2, =_edata
	LDR r3, =_sidata
	B copy_sidata_loop

copy_sidata:
	LDR r4, [r3, r0] // offset by the progress copying.
	STR r4, [r1, r0] // copy the current word into data and increment.
	ADDS r0, r0, #4 //this is the increment...

copy_sidata_loop:
	// unless all the data is copied, copy the next word.
	ADDS r4, r0, r1
	CMP r4, r2
	BCC copy_sidata

	// When we're done copying the data section to RAM, fill the BSS section with 0s.
	//
	MOVS r0, #0
	LDR r1, =_sbss // start point
	LDR r2, =_ebss // end point
	B reset_bss_loop

	// do the filling of 0s
reset_bss:
	STR r0, [r1]
	ADDS r1, r1, #4

reset_bss_loop:
	CMP r1, r2
	BCC reset_bss //jump to the start of the loop if we're not finished.


	// Finally, lets branch to MAIN!!!
	B main
	.size reset_handler, .-reset_handler
	
