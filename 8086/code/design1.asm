assume cs:codesg, ss:stack, ds:data

stack segment
dw 8 dup (0)
stack ends

data segment
db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
db '1993', '1994', '1995'

dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
dw 11542, 14430, 15257, 17800

dw 5, 3, 42, 104, 85, 210, 123, 111, 105, 125, 140, 136, 153, 211, 199, 209
dw 224, 239, 260, 304, 333
data ends


codesg segment
start:
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax
	mov sp, 16
	mov si, 0
	
	mov cx, 20
ms:	mov ax, 1
	mov bx, 1
	mov dh, ax
	mov dl, bx
	push cx
	mov cl, 2
	call show_str
	inc ax
	inc bx
	pop cx
	loop ms

	mov bx, 0
	mov cx, 21
s:	mov ax, [bx + 0]
	mov es:[si + 0], ax
	mov ax, [bx + 2]
	mov es:[si + 2], ax

	mov ax, ds:[bx + 84]
	mov es:[si + 5], ax
	mov ax, ds:[bx + 86]
	mov es:[si + 7], ax

	mov ax, ds:[bx + 0a8h]
	mov es:[si + 10], ax
	
	add bx, 4
	add si, 10h
	loop s

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

codesg ends

end start
