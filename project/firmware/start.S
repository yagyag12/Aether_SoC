.section .text.start
.global _start
_start:
    nop                 # First cycle stall
    li   sp, 0x400      # Set stack pointer to memory end
    call main           # Call the main function
    ebreak              # Stop execution after main
