assume cs:code

code segment
start:
	mov ax, cs
	mov ds, ax
	mov si, offset show_str
	mov ax, 0
	mov es, ax
	mov di, 200h
	mov cx, offset send-offset show_str
	cld
	rep movsb

	mov ax, 0
	mov es, ax
	mov word ptr es:[7ch*4], 200h
	mov word ptr es:[7ch*4+2], 0

	mov ax, 4c00h
	int 21h

show_str:
	push es
	push bx
	push ax

main:
	mov ax, 0b800h
	mov es, ax

	mov al, 0A0h
	mul dh
	mov dh, 0
	add dl, dl
	add ax, dx	; align screen location at ax
	mov bx, ax


s0:
	mov di, cx
	mov cl, [si]
	mov ch, 0
	jcxz ok
	mov byte ptr es:[bx], cl
	mov cx, di
	mov byte ptr es:[bx+1], cl
	inc si
	add bx, 2
	jmp short s0
ok:
	pop ax
	pop bx
	pop es
	iret
send:
	nop

code ends

end start
