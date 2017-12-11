assume cs:code, ss:stack

stack segment
	dw 10 dup (0)
stack ends

data segment
	db 9,8,7,4,2,0
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 20

	mov di, 0
	mov si, 0
	mov cx, 6
main:
	push cx
	mov al, [di]
	out 70h, al
	in al, 71h
	inc di

	mov ah, al
	mov cl, 4
	shr ah, cl
	and al, 00001111b

	add ah, 30h
	add al, 30h

	mov bx, 0b800h
	mov es, bx
	mov byte ptr es:[160*12+40*2+si], ah
	mov byte ptr es:[160*12+40*2+si+2], al
	mov byte ptr es:[160*12+40*2+si+4], 2fh
	add si, 6
	pop cx
	loop main
	
	mov ax, 4c00h
	int 21h

code ends

end start
