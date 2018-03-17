;-------METHOD THAT SET INITIAL DATA------------------
init_data:
	mov word [snake_size], 2		;set the size of the snake of 3
	mov word [snake_head_x], 125		;set initial head x position as 85
	mov word [snake_head_y], 40 		;set initial head y position as 40
	mov word [snake_x1], 122		;set initial head x position as 85
	mov word [snake_y1], 40 		;set initial head y position as 40
	mov word [snake_x2], 119		;set initial head x position as 85
	mov word [snake_y2], 40 		;set initial head y position as 40
	mov word [snake_x3], 116		;set initial head x position as 85
	mov word [snake_y3], 40 		;set initial head y position as 40
	mov word [snake_x4], 113		;set initial head x position as 85
	mov word [snake_y4], 40 		;set initial head y position as 40
	mov word [snake_x5], 110		;set initial head x position as 85
	mov word [snake_y5], 40 		;set initial head y position as 40
	mov word [snake_x6], 107		;set initial head x position as 85
	mov word [snake_y6], 40 		;set initial head y position as 40
	mov word [snake_x7], 104		;set initial head x position as 85
	mov word [snake_y7], 40 		;set initial head y position as 40
	mov word [snake_x8], 101		;set initial head x position as 85
	mov word [snake_y8], 40 		;set initial head y position as 40
	mov word [snake_x9], 98		;set initial head x position as 85
	mov word [snake_y9], 40 		;set initial head y position as 40
	mov word [snake_x10], 95		;set initial head x position as 85
	mov word [snake_y10], 40 		;set initial head y position as 40
	mov word [snake_black_x], 125		;set initial head x position as 85
	mov word [snake_black_y], 40 		;set initial head y position as 40	
	mov word [food_x], 120			;set initial food x position as 85
	mov word [food_y], 50 			;set initial food y position as 40
	mov byte [last_move], 0x4d		;set initial move to the right
	mov byte [key_pressed], 0x4d		;set actual move to the right
	mov word [score], 0				;set inital points as 0
	ret