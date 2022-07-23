section .text
	global _start

_start:
	
	xor ebx, ebx
	xor eax, eax
	inc eax
	int 80h

section .data

section .bss
