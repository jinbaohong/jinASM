assume cs:code, ss:stack

stack segment
	dw 10 dup (0)
stack ends

code segment
start:
	mov ax, stack
	mov ss, ax
	mov sp, 20

	mov bx, ax
	mov cl, 3
	shl bx, cl
	shl ax, 1
	add ax, bx

	mov ax, 4c00h
	int 21h

code ends

end start
