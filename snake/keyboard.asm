check_keyboard:
	mov ah, 0x01
	int 0x16		;interrupt bios to get keayboard
	jz move_alone 	;if there is no key press jump to move
	mov ah, 0x00
	int 0x16
	cmp	al, 'e' 	;if the user press e
	je	init		;the exit
	in al, 0x60		;open port 0x60
	cmp byte al, 0x48	
	je .keyUpdate
	cmp byte al, 0x50
	je .keyUpdate
	cmp byte al, 0x4b
	je .keyUpdate
	cmp byte al, 0x4d
	je .keyUpdate

	jmp move_alone
	ret
	
;set the key_pressed as an arrow key	
.keyUpdate:
	mov byte [key_pressed], al
	ret

;actions taken when the snake move right
right:	
	call check_right_border ;verify if snake head hit border
	call check_food			;verify if the snake head eat food	
	call clear_snake 		;clear the snake
	mov byte [last_move], al	;update last move
	call update_body			;update body position
	add word [snake_head_x], 2
	call check_body_collision ;verify if the snake hit itself
	call draw_snake
	ret

down:		
	call check_down_border ;verify if snake head hit border	
	call check_food			;verify if the snake head eat food	
	call clear_snake 		;clear the snake
	mov byte [last_move], al	;update last move
	call update_body			;update body position
	add word [snake_head_y], 2
	call check_body_collision ;verify if the snake hit itself
	call draw_snake		
	ret

left:		
	call check_left_border ;verify if snake head hit border	
	call check_food			;verify if the snake head eat food	
	call clear_snake 		;clear the snake
	mov byte [last_move], al	;update last move
	call update_body			;update body position
	sub word [snake_head_x], 2
	call check_body_collision ;verify if the snake hit itself
	call draw_snake
	ret

up:		
	call check_up_border ;verify if snake head hit border	
	call check_food			;verify if the snake head eat food	
	call clear_snake 		;clear the snake
	mov byte [last_move], al	;update last move
	call update_body			;update body position
	sub word [snake_head_y], 2
	call check_body_collision ;verify if the snake hit itself
	call draw_snake		
	ret

;to move the snake even if no key was pressed
move_alone:
	mov byte ch , [key_pressed] ;move key_pressed to ch
	cmp ch, 0x4b				;compere if its moving to the left
	je left
	cmp ch, 0x4d				;compere if its moving to the ritgh
	je right 
	cmp ch, 0x48				;compere if its moving up
	je up
	cmp ch, 0x50				;compere if its moving down
	je down  
	ret