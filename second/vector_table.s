	/* Startup Code */
	.syntax unified
	.cpu cortex-m3
	.fpu softvfp
	.thumb

	.global vtable
	.global default_interrupt_handler

	/* The Vector Table */
	.type vtable, %object
	.section .vector_table, "a", %progbits

vtable:
	// 0-15
	.word _estack
	.word reset_handler
	.word NMI_handler
	.word Hard_fault_handler
	.word MemManage_handler
	.word BusFault_handler
	.word UsageFault_handler
	.word 0
	.word 0
	.word 0
	.word 0
	.word SVC_handler
	.word DebugMon_handler
	.word 0
	.word Pending_sv_handler
	.word SysTick_handler
	// 16-31
	.word WWDG_IRQ_handler
	.word PVD_IRQ_handler
	.word Tamper_Stamp_handler
	.word RTC_IRQ_handler
	.word Flash_handler
	.word RCC_handler
	.word EXTI0_handler
	.word EXTI1_handler
	.word EXTI2_handler
	.word EXTI3_handler
	.word EXTI4_handler
	.word DMA1_Channel1_handler
	.word DMA1_Channel2_handler
	.word DMA1_Channel3_handler
	.word DMA1_Channel4_handler
	.word DMA1_Channel5_handler
	.word DMA1_Channel6_handler
	.word DMA1_Channel7_handler
	.word ADC1_handler
	.word USBHP_handler
	.word USBLP_handler
	.word DAC_handler
	.word COMP_TSC_handler
	.word EXTI9_5_handler
	.word LCD_handler
	.word TIM9_handler
	.word TIM10_handler
	.word TIM11_handler
	.word TIM2_handler
	.word TIM3_handler
	.word TIM4_handler
	.word I2C1_EV_handler
	.word I2C1_ER_handler
	.word I2C2_EV_handler
	.word I2C2_ER_handler
	.word SPI1_handler
	.word SPI2_handler
	.word USART1_handler
	.word USART2_handler
	.word USART3_handler
	.word EXTI15_10_handler
	.word RTC_Alarm_handler
	.word USB_FS_Wakeup_handler
	.word TIM6_handler
	.word TIM7_handler
	// (Location to boot from for RAM startup)
	#define boot_ram_base 0xF108F85F
	.word boot_ram_base

	/*
	 * Setup weak aliases for each interrupt handler pointing to the default handler.
	 * The reset_handler is setup separately. These can be overriden later.
	*/

	.weak NMI_handler
	.thumb_set NMI_handler, default_interrupt_handler
	.weak Hard_fault_handler
	.thumb_set Hard_fault_handler, default_interrupt_handler
	.weak SVC_handler
	.thumb_set SVC_handler, default_interrupt_handler
	.weak pending_sv_handler
	.thumb_set pending_sv_handler, default_interrupt_handler
	.weak SysTick_handler
	.thumb_set SysTick_handler, default_interrupt_handler
	.weak window_watchdog_IRQ_handler
	.thumb_set window_watchdog_IRQ_handler, default_interrupt_handler
	.weak PVD_IRQ_handler
	.thumb_set PVD_IRQ_handler, default_interrupt_handler
	.weak RTC_IRQ_handler
	.thumb_set RTC_IRQ_handler, default_interrupt_handler
	.weak flash_IRQ_handler
	.thumb_set flash_IRQ_handler, default_interrupt_handler
	.weak RCC_IRQ_handler
	.thumb_set RCC_IRQ_handler, default_interrupt_handler
	.weak EXT0_1_handler
	.thumb_set EXT0_1_IRQ_handler, default_interrupt_handler
	.weak EXT2_3_IRQ_handler
	.thumb_set EXT_2_3_IRQ_handler, default_interrupt_handler
	.weak EXT_4_5_IRQ_handler
	.thumb_set EXT4_5_IRQ_handler, default_interrupt_handler
	.weak ADC1_IRQ_handler
	.thumb_set ADC1_IRQ_handler, default_interrupt_handler
	.weak TIM1_break_IRQ_handler
	.thumb_set TIM1_break_IRQ_handler, default_interrupt_handler
	.weak TIM1_CC_IRQ_handler
	.thumb_set TIM1_CC_IRQ_handler, default_interrupt_handler
	.weak TIM2_IRQ_handler
	.thumb_set TIM2_IRQ_handler, default_interrupt_handler
	.weak TIM3_IRQ_handler
	.thumb_set TIM3_IRQ_handler, default_interrupt_handler
	.weak TIM14_IRQ_handler
	.thumb_set TIM_14_handler, default_interrupt_handler
	.weak TIM16_IRQ_handler
	.thumb_set TIM16_IRQ_handler, default_interrupt_handler
	.weak TIM17_IRQ_handler
	.thumb_set TIM17_IRQ_handler, default_interrupt_handler
	.weak I2C1_IRQ_handler
	.thumb_set I2C1_IRQ_handler, default_interrupt_handler
	.weak SPI1_IRQ_handler
	.thumb_set SPI1_IRQ_handler, default_interrupt_handler
	.weak USART1_IRQ_handler
	.thumb_set USART1_IRQ_handler, default_interrupt_handler
	.size vtable, .-vtable

	/* A Default Interrupt Handler
	 * Jump to this code if any of the undefined interrupts fire.
	*/
	.section .text.default_interrupt_handler, "ax", %progbits
default_interrupt_handler:
default_interrupt_loop:
	B default_interrupt_loop
	.size default_interrupt_handler, .-default_interrupt_handler

	
