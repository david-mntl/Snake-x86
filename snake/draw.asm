draw_snake_head:	
	pusha
	mov ah, 0x0c			;Write graphics pixel
	mov bh, 0x00 			;page #0
	mov byte al, [snake_head_color]	;Set head color
	mov word cx, [snake_head_x] 		;Set x as cx = snake head x pos
	mov word dx, [snake_head_y]			;Set y as dx = snake head y pos
	int 0x10 				;Draw the x,y pixel
	inc dx          		;increment dx by 1
	int 0x10    			;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10        		;call BIOS video for print pixel
	sub dx, 2       		;reduce dx y 2
	inc cx					;incremente cx
	int 0x10				;call BIOS video for print pixel
	inc cx 					;increment cx
	int 0x10				;call BIOS video for print pixel
	dec cx					;decrement cx
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	dec dx					;decrement dx
	inc cx					;increment cx
	int 0x10				;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	popa
	ret

;Draw a 4x4 dot in the center of a 20x20 grid
draw_snake_body:
	pusha
	mov ah, 0x0c			;Write graphics pixel
	mov bh, 0x00 			;page #0
	mov byte al, [snake_body_color]	;Set body color
	mov word cx, [snake_xTmp] 		;Set x as cx = snake body[i] x pos
	mov word dx, [snake_yTmp]		;Set y as dx = snake body[i] y pos
	inc dx
	int 0x10 						;Draw the x,y pixel
	inc cx							;Set x as cx+10
	int 0x10 						;Draw the x,y pixel
	dec cx							;Set x as cx+9
	inc dx 							;Set y as dx+10
	int 0x10 						;Draw the x,y pixel
	inc cx							;Set x as cx+10
	int 0x10 						;Draw the x,y pixel
	popa
	ret

;Draw a 4x4 dot in the center of a 20x20 grid
draw_food:
	pusha
	mov ah, 0x0c			;Write graphics pixel
	mov bh, 0x00 			;page #0
	mov byte al, [food_color]		;Set food color
	mov word cx, [food_x] 			;Set x as cx = snake body[i] x pos
	mov word dx, [food_y]			;Set y as dx = snake body[i] y pos
	int 0x10 				;Draw the x,y pixel
	inc dx          		;increment dx by 1
	int 0x10    			;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10        		;call BIOS video for print pixel
	sub dx, 2       		;reduce dx y 2
	inc cx					;incremente cx
	int 0x10				;call BIOS video for print pixel
	inc cx 					;increment cx
	int 0x10				;call BIOS video for print pixel
	dec cx					;decrement cx
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	dec dx					;decrement dx
	inc cx					;increment cx
	int 0x10				;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	popa
	ret

;Draw a 4x4 dot in the center of a 20x20 grid
clear_food:
	pusha
	mov ah, 0x0c			;Write graphics pixel
	mov bh, 0x00 			;page #0
	mov byte al, 0		;Set food color
	mov word cx, [food_x] 			;Set x as cx = snake body[i] x pos
	mov word dx, [food_y]			;Set y as dx = snake body[i] y pos
	int 0x10 				;Draw the x,y pixel
	inc dx          		;increment dx by 1
	int 0x10    			;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10        		;call BIOS video for print pixel
	sub dx, 2       		;reduce dx y 2
	inc cx					;incremente cx
	int 0x10				;call BIOS video for print pixel
	inc cx 					;increment cx
	int 0x10				;call BIOS video for print pixel
	dec cx					;decrement cx
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	dec dx					;decrement dx
	inc cx					;increment cx
	int 0x10				;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	popa
	ret

draw_black:
	pusha
	mov ah, 0x0c			;Write graphics pixel
	mov bh, 0x00 			;page #0
	mov al, 0x0				;Set black color
	mov word cx, [snake_black_x] 	;Set x as cx = snake black[i] x pos
	mov word dx, [snake_black_y] 	;Set y as dx = snake black[i] y pos
	int 0x10 				;Draw the x,y pixel
	inc dx          		;increment dx by 1
	int 0x10    			;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10        		;call BIOS video for print pixel
	sub dx, 2       		;reduce dx y 2
	inc cx					;incremente cx
	int 0x10				;call BIOS video for print pixel
	inc cx 					;increment cx
	int 0x10				;call BIOS video for print pixel
	dec cx					;decrement cx
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	dec dx					;decrement dx
	inc cx					;increment cx
	int 0x10				;call BIOS video for print pixel
	inc dx					;increment dx
	int 0x10				;call BIOS video for print pixel
	popa
	ret
;Drawing a large box
draw_large_box:
	pusha			;Push registers onto the stack
	mov ah, 0x0c			;Write graphics pixel
	mov bh, 0x00 			;page #0
	;Create the large boxes
	mov al, 0x4		;Set dark gray color
	mov cx, 80		;Set column (x) to 20
	mov dx, 35		;Set row (y) to 20	
	int 0x10		;Draw initial pixel
	mov bx, cx		;Move initial x position to bx
	add bx, 160		;Add 160 to determine the final position of the block
	call draw_line_x	;Draw top horizontal line
	sub cx, 160		; Substract 160 to obtain initial value
	add dx, 130		; Add 130 to determine the position of the down horizontal line
	call draw_line_x 	; Draw bottom horizontal line
	sub dx, 130		; Substract 130 to obtain initial value
	sub cx, 160		; Substract 160 to obtain initial value
	mov bx, dx		; Move dx to bx
	add bx, 130		; Add 130 to obtain final value
	call draw_line_y	;Draw left vertical line
	add cx, 160		; Add 160 to obtain second vertical line initial position
	sub dx, 130		; Substract 130 to obtain initial value
	call draw_line_y	;Draw right vertical line
	popa			;Pops registers from the stack
	ret				; Return

;Drawing a large box
draw_level_box:
	pusha			;Push registers onto the stack
	int 0x10		;Draw initial pixel
	mov bx, cx		;Move initial x position to bx
	add bx, 132		;Add 160 to determine the final position of the block
	call draw_line_x	;Draw top horizontal line
	sub cx, 132		; Substract 80 to obtain initial value
	add dx, 20		; Add 70 to determine the position of the down horizontal line
	call draw_line_x 	; Draw bottom horizontal line
	sub dx, 20		; Substract 70 to obtain initial value
	sub cx, 132		; Substract 80 to obtain initial value
	mov bx, dx		; Move dx to bx
	add bx, 20		; Add 70 to obtain final value
	call draw_line_y	;Draw left vertical line
	add cx, 132		; Add 80 to obtain second vertical line initial position
	sub dx, 20		; Substract 70 to obtain initial value
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