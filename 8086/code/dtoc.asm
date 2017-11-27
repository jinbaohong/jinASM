assume cs:code, ss:stack, ds:data

data segment
	dw 10 dup (0)
data ends

stack segment
	dw 10 dup (0)
stack ends

code segment
start:
	mov ax, stack
	mov ss, ax
	mov sp, 20
	mov ax, data
	mov ds, ax
	mov si, 0

	mov ax, 12666
	mov di, 0
	call dtoc
	
	mov dh, 11
	mov dl, 35
	mov cl, 71h
	call show_str
	mov ax, 4c00h
	int 21h

dtoc:
	mov dx, 0
	mov bx, 10
	div bx
	add dx, 30h
	mov cx, ax
	push dx
	inc di
	jcxz s0
	jmp short dtoc
s0:
	mov bx, 0
	mov cx, di
s1:
	pop ds:[0+bx]
	inc bx
	loop s1
	ret

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


s2:
	mov di, cx
	mov cl, [si]
	mov ch, 0
	jcxz ok
	mov byte ptr es:[bx], cl
	mov cx, di
	mov byte ptr es:[bx+1], cl
	inc si
	add bx, 2
	jmp short s2
ok:
	pop ax
	pop bx
	pop es
	ret
code ends

end start
