;check if snake head hit left border
check_left_border:
	cmp word [snake_head_x], 81		;compare head x
	jle lose_window
	ret
;check if snake head hit right border
check_right_border:
	cmp word [snake_head_x], 236	;compare head x
	jge lose_window
	ret

;check if snake head hit up border
check_up_border:		
	cmp word [snake_head_y], 37		;compare head y
	jle lose_window
	ret

;check if snake head hit down border
check_down_border:
	cmp word [snake_head_y], 162	;compare head y
	jge lose_window
	ret

;check if the snake head hit the food
check_food:
	mov word ax, [snake_head_x]
	cmp word [food_x],ax	;compare head x
	je check_food2
	inc ax
	cmp word [food_x],ax	;compare head x
	je check_food2
	ret

check_food2:
	mov word ax, [snake_head_y]
	cmp word [food_y],ax 	;compare head y
	je addPoints
	inc ax
	cmp word [food_y],ax	;compare head y
	je addPoints
	ret

;add points and compare if next level is available
addPoints:
	call clear_food
	inc byte [score]
	cmp byte [score], 8
	je win_level
	inc byte [snake_size]
	call random
	call draw_food
	ret

check_Owncollision:
	mov ah, 0x0d	;Get graphics pixel video mode
	mov bh, 0x0 	;Page 0
	int 0x10  		;BIOS Video interrupt
	cmp al, 0x04 	;If pixel is green, collision
	je 0x06	;Increase points
	ret

check_body_collision:
	mov word cx, [snake_head_x]
	mov word dx, [snake_head_y]
	call check_Owncollision
	;call check1
	;call check2	
	;cmp byte [score], 1
	;je check3
	;cmp byte [score], 2
	;je check4
	;cmp byte [score], 3
	;je check5
	;cmp byte [score], 4
	;je check6
	;cmp byte [score], 5
	;je check7
	;cmp byte [score], 6
	;je check8
	;cmp byte [score], 7
	;je check9
	;cmp byte [score], 8
	;je check10
	ret

check1:
	cmp word [snake_x1], cx	;compare x1 pos to snake head x
	je check1_2
	ret
check1_2: 
	cmp word [snake_y1], dx	;compare x1 pos to snake head x
	je lose_window
	ret

check2:
	cmp word [snake_x2], cx	;compare x1 pos to snake head x
	je check2_2
check2_2:
	cmp word [snake_y2], dx	;compare x1 pos to snake head x
	je lose_window
	ret

check3:
	cmp word [snake_x3], cx	;compare x1 pos to snake head x
	je check3_2
check3_2:
	cmp word [snake_y3], dx	;compare x1 pos to snake head x
	je lose_window
	ret

check4:
	cmp word [snake_x4], cx	;compare x1 pos to snake head x
	je check4_2
check4_2:
	cmp word [snake_y4], dx	;compare x1 pos to snake head x
	je lose_window
	ret

check5:
	cmp word [snake_x5], cx	;compare x1 pos to snake head x
	je check5_2
	ret
check5_2:
	cmp word [snake_y5], dx	;compare x1 pos to snake head x
	je lose_window
	ret

check6:
	cmp word [snake_x6], cx	;compare x1 pos to snake head x
	je check6_2
	ret
check6_2:
	cmp word [snake_x6], dx	;compare x1 pos to snake head x
	je lose_window
 	ret

check7:
	cmp word [snake_x7], cx	;compare x1 pos to snake head x
	je check7_2
	ret
check7_2:
	cmp word [snake_x7], dx	;compare x1 pos to snake head x
	je lose_window
	ret

check8:
	cmp word [snake_x8], cx	;compare x1 pos to snake head x
	je check8_2
	ret

check8_2:
	cmp word [snake_y8], dx	;compare x1 pos to snake head x
	je lose_window
	ret

check9:
	cmp word [snake_x9], cx	;compare x1 pos to snake head x
	je check9_2
	ret
check9_2:
	cmp word [snake_y9], dx	;compare x1 pos to snake head x
	je lose_window
	ret

check10:
	cmp word [snake_x10], cx	;compare x1 pos to snake head x
	je check10_2
	ret
check10_2:
	cmp word [snake_y10], dx	;compare x1 pos to snake head x
	je lose_window
	ret