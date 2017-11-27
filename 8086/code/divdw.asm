assume cs:code, ss:stack

stack segment
	dw 10 dup (0)
stack ends

code segment
start:
	mov ax, stack
	mov ss, ax
	mov sp, 20

	mov ax, 4240h
	mov dx, 000Fh
	mov cx, 0Ah
	call divdw
	
	mov ax, 4c00h
	int 21h

divdw:
	push ax
	mov ax, dx
	mov dx, 0
	div cx
	mov bx, ax
	pop ax
	div cx
	mov cx, dx
	mov dx, bx
	ret

code ends

end start
