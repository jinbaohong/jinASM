assume cs:code, ss:stack

stack segment
	dw 10 dup (0)
stack ends

code segment
start:
	mov ax, stack
	mov ss, ax
	mov sp, 20

	mov ah, 2
	mov al, 3
	int 7ch
	mov ax, 4c00h
	int 21h

code ends

end start
