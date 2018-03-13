;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FOR ARENA;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

draw_boardCage:
    mov ah, 0x00 	;Set video mode
	mov al, 0x13	;graphics, 320x200 res, 8x8 pixel box
	int 0x10

	mov ah, 0x0c	;Write graphics pixel
	mov bh, 0x00 	;page #0	


	;mov     CX, 0FH
	;mov     DX, 1B30H;4240H
	;mov     AH, 86H
	;int     15H
  ;; PRINT CAGE FOR THE SNAKE

    ;Create the large boxes
	mov al, 0x8		;Set dark gray color
	mov cx, 20		;Set column (x) to 20
	mov dx, 30		;Set row (y) to 20
	call draw_large_box

	

	; start delay

	;mov bp, 2690
	;mov si, 2690
	delay2:
	dec bp
	nop
	jnz delay2
	dec si
	cmp si,0    
	jnz delay2
	; end delay

	 
    ;        mov     cx, 003H
    ;delRep: push    cx
    ;        mov     cx, 145C0H
    ;delDec: dec     cx
    ;        jnz     delDec
    ;        pop     cx
    ;        dec     cx
    ;        jnz     delRep
    ;        ret	

	;call return







  ;Drawing a large box
draw_large_box:
	pusha			;Push registers onto the stack
	int 0x50		;Draw initial pixel
	mov bx, cx		;Move initial x position to bx
	add bx, 80		;Add 80 to determine the final position of the block
	call draw_line_x	;Draw top horizontal line
	sub cx, 80		; Substract 80 to obtain initial value
	add dx, 100		; Add 70 to determine the position of the down horizontal line
	call draw_line_x 	; Draw bottom horizontal line
	sub dx, 100		; Substract 70 to obtain initial value
	sub cx, 80		; Substract 80 to obtain initial value
	mov bx, dx		; Move dx to bx
	add bx, 100		; Add 70 to obtain final value
	call draw_line_y	;Draw left vertical line
	add cx, 80		; Add 80 to obtain second vertical line initial position
	sub dx, 100		; Substract 70 to obtain initial value
	call draw_line_y	;Draw right vertical line
	popa			;Pops registers from the stack
	ret				; Return

;Horizontal line from cx to bx
draw_line_x:
	cmp cx, bx 		;Compare if currrent x equals desired x
	je return		;Returns if true
	inc cx			;Increments x coordinate (cx)
	int 0x10 		;Writes graphics pixel
	jmp draw_line_x	;Loops to itself


;Vertical line from dx to bx
draw_line_y:
	cmp dx, bx 		;Compare if currrent y equals desired y
	je return		;Returns if true
	inc dx			;Increments y coordinate (dx)
	int 0x10 		;Writes graphics pixel
	jmp draw_line_y	;Loops to itself

    ;Return from procedure
return:
	ret