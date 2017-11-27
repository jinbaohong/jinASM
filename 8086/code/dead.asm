assume cs:code
code segment
	mov ax, 0h
	mov ds, ax
	mov ds:[26h], ax 
	
	mov ax, 4c00h
	int 21h
code ends
end
