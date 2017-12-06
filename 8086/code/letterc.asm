assume cs:code, ss:stack, ds:data

stack segment
	dw 8 dup (0)
stack ends

data segment
	db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends

code segment
begin:
	mov ax, stack
	mov ss, ax
	mov sp, 16
	mov ax, data
	mov ds, ax
	mov si, 0
	call letterc

	mov ax, 4c00h
	int 21h

letterc:
	mov cl, [si]
	mov ch, 0
	jcxz ok
	cmp cl, 61h
	jna s0
	cmp cl, 7Ah
	jnb s0
	and cl, 11011111b
	mov [si], cl
s0:	inc si
	jmp short letterc
ok:	ret
code ends

end begin
