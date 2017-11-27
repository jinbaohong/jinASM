assume cs:code, ds:data, ss:stack

stack segment
	dw 20 dup (0)
stack ends

data segment
	db 'Welcome to masm!', 0
data ends

code segment
start:
	mov dh, 8
	mov dl, 3
	mov cl, 2
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 40
	mov si, 0
	call show_str
	
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
	ret

code ends

end start
