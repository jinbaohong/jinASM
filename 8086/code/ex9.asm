assume cs:code, ds:data

data segment
;	db 'welcome to masm!'
	db 'Treaty of gjmeer'
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov ax, 0b8a0h
	mov es, ax

	mov bx, 0
	mov cx, 32
s0:	mov byte ptr es:[bx], 71h
	inc bx
	loop s0

	mov bx, 0
	mov cx, 16
s1:	mov di, bx
	mov al, ds:[bx]
	mov es:[bx+di], al
	inc bx
	loop s1

	mov ax, 4c00h
	int 21h
code ends

end start
