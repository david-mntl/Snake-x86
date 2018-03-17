[BITS 16]
[ORG 0x0000]      ; This code is intended to be loaded starting at 0x1000:0x0000
                  ; Which is physical address 0x10000. ORG represents the offset
                  ; from the beginning of our segment.

; Our bootloader jumped to 0x1000:0x0000 which sets CS=0x1000 and IP=0x0000
; We need to manually set the DS register so it can properly find our variables

mov ax, cs
mov ds, ax   	; Copy CS to DS (we can't do it directly so we use AX temporarily)



main:
	mov ah, 0x00 	;Set video mode
	mov al, 0x13	;graphics, 320x200 res, 8x8 pixel box
	int 0x10

	mov ah, 0x0c	;Write graphics pixel
	mov bh, 0x00 	;page #0
	;int 0x10

	call draw_dot
	add cx, 4
	call draw_dot
	add cx, 4
	call draw_dot

	jmp game 			;Game main loop

;Return from procedure
return:
	ret

;Draw a 4x4 dot in the center of a 20x20 grid
draw_dot:
	pusha
	mov al, 0x5		;Set brown color
	add cx, 20		;Set x as cx+9
	add dx, 140		;Set y as dx+9
	int 0x10 		;Draw the x,y pixel
	inc dx          ;
	int 0x10        ;
	inc dx          ;
	int 0x10        ;
	sub dx, 2       ;
	inc cx          ;
	int 0x10        ;
	inc cx          ;
	int 0x10        ;
	dec cx          ;
	inc dx          ;
	int 0x10        ;
	inc dx          ;
	int 0x10        ;
	dec dx          ;
	inc cx          ;
	int 0x10        ;
	inc dx          ;
	int 0x10        ;
	popa            ;
	ret             ;


;Game main loop
game:
	mov cx, 0x01 	;Delay for 100ms
	mov dx, 0x86a0
	mov ah, 0x86
	int 0x15
	jmp game 		;Loop to itself

