;clear entire snake (turn it into black)
clear_snake:
	call draw_black				;made snake head black -- ;go to draw.asm file for more detail 	
;made all the body in balck
clear_body:
	mov word cx, [snake_x1] 		;put head x into cx register
	mov word dx, [snake_y1]			;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y
	call draw_black
	mov word cx, [snake_x2] 		;put head x into cx register
	mov word dx, [snake_y2]			;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	cmp byte [score], 1
	je clear_body3
	cmp byte [score], 2
	je clear_body4
	cmp byte [score], 3
	je clear_body5
	cmp byte [score], 4
	je clear_body6
	cmp byte [score], 5
	je clear_body7
	cmp byte [score], 6
	je clear_body8
	cmp byte [score], 7
	je clear_body9
	cmp byte [score], 8
	je clear_body10
	;mov word cx, [snake_head_x]	;save snake head x into cx
	;mov word dx, [snake_head_y]	;save snake head y into dx
	;mov word [snake_black_x], cx 	;update body x1
	;mov word [snake_black_y], dx 	;update body x1
	ret
	
clear_body3:
	mov word cx, [snake_x3] 		;put head x into cx register
	mov word dx, [snake_y3]			;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	ret
clear_body4:
	call clear_body3
	mov word cx, [snake_x4] 		;put head x into cx register
	mov word dx, [snake_y4]			;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	ret

clear_body5:
	call clear_body3
	call clear_body4
	mov word cx, [snake_x5] 		;put head x into cx register
	mov word dx, [snake_y5]			;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	ret


clear_body6:
	call clear_body3
	call clear_body4
	call clear_body5
	mov word cx, [snake_x6] 		;put head x into cx register
	mov word dx, [snake_y6]			;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	ret

clear_body7:
	call clear_body3
	call clear_body4
	call clear_body5
	call clear_body6
	mov word cx, [snake_x7] 	;put head x into cx register
	mov word dx, [snake_y7]		;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	ret

clear_body8:
	call clear_body3
	call clear_body4
	call clear_body5
	call clear_body6
	call clear_body7
	mov word cx, [snake_x8] 		;put head x into cx register
	mov word dx, [snake_y8]			;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	ret

clear_body9:
	call clear_body3
	call clear_body4
	call clear_body5
	call clear_body6
	call clear_body7
	call clear_body8
	mov word cx, [snake_x9] 		;put head x into cx register
	mov word dx, [snake_y9]			;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	ret

clear_body10:
	call clear_body3
	call clear_body4
	call clear_body5
	call clear_body6
	call clear_body7
	call clear_body8
	call clear_body9
	mov word cx, [snake_x10]	 	;put head x into cx register
	mov word dx, [snake_y10]		;put head y into dx register
	mov word [snake_black_x], cx	;update snake_x
	mov word [snake_black_y], dx	;update snake_y	
	call draw_black	
	ret
	;initial draw of the game
draw:		
	call draw_large_box 	;go to draw.asm file for more detail -- draw the box that limits the game zone
	;call reset_register
	;call draw_snake 		;print snake 
	call draw_food 			;go to draw.asm file for more detail -- draw food
	ret

;draw the entire snake
draw_snake: 		
	call draw_snake_head 		;go to draw.asm file for more detail -- draw snake head
	mov word cx, [snake_x1] ;put head x into cx register
	mov word dx, [snake_y1]	;put head y into dx register	 	
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body
	mov word cx, [snake_x2] ;put head x into cx register
	mov word dx, [snake_y2]	;put head y into dx register	 	
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body
	cmp byte [score], 1
	je draw_body3
	cmp byte [score], 2
	je draw_body4
	cmp byte [score], 3
	je draw_body5
	cmp byte [score], 4
	je draw_body6
	cmp byte [score], 5
	je draw_body7
	cmp byte [score], 6
	je draw_body8
	cmp byte [score], 7
	je draw_body9
	cmp byte [score], 8
	je draw_body10
	ret


draw_body3:
	mov word cx, [snake_x3] 		;put head x into cx register
	mov word dx, [snake_y3]			;put head y into dx register
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body
	ret
draw_body4:
	call draw_body3	
	mov word cx, [snake_x4] 		;put head x into cx register
	mov word dx, [snake_y4]			;put head y into dx register
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body
	ret

draw_body5:
	call draw_body3
	call draw_body4
	mov word cx, [snake_x5] 	;put head x into cx register
	mov word dx, [snake_y5]		;put head y into dx register
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body
	ret

draw_body6:
	call draw_body3
	call draw_body4
	call draw_body5
	mov word cx, [snake_x6] 		;put head x into cx register
	mov word dx, [snake_y6]			;put head y into dx register
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body
	ret

draw_body7:
	call draw_body3
	call draw_body4
	call draw_body5
	call draw_body6
	mov word cx, [snake_x7] 	;put head x into cx register
	mov word dx, [snake_y7]		;put head y into dx register
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body
	ret

draw_body8:
	call draw_body3
	call draw_body4
	call draw_body5
	call draw_body6
	call draw_body7
	mov word cx, [snake_x8] 		;put head x into cx register
	mov word dx, [snake_y8]			;put head y into dx register
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body	
	ret

draw_body9:
	call draw_body3
	call draw_body4
	call draw_body5
	call draw_body6
	call draw_body7
	call draw_body8
	mov word cx, [snake_x9] 		;put head x into cx register
	mov word dx, [snake_y9]			;put head y into dx register
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body	
	ret

draw_body10:
	call draw_body3
	call draw_body4
	call draw_body5
	call draw_body6
	call draw_body7
	call draw_body8
	call draw_body9
	mov word cx, [snake_x10]	 	;put head x into cx register
	mov word dx, [snake_y10]		;put head y into dx register
	mov word [snake_xTmp], cx	;update snake_xTmp
	mov word [snake_yTmp], dx	;update snake_yTmp	
	call draw_snake_body	
	ret

;update the body positions
update_body:
	mov word cx, [snake_x9]	;save snake head x into cx
	mov word dx, [snake_y9]	;save snake head y into dx	
	mov word [snake_x10], cx 	;update body x1
	mov word [snake_y10], dx 	;update body x1	
	mov word cx, [snake_x8]	;save snake head x into cx
	mov word dx, [snake_y8]	;save snake head y into dx	
	mov word [snake_x9], cx 	;update body x1
	mov word [snake_y9], dx 	;update body x1	
	mov word cx, [snake_x7]	;save snake head x into cx
	mov word dx, [snake_y7]	;save snake head y into dx	
	mov word [snake_x8], cx 	;update body x1
	mov word [snake_y8], dx 	;update body x1	
	mov word cx, [snake_x6]	;save snake head x into cx
	mov word dx, [snake_y6]	;save snake head y into dx	
	mov word [snake_x7], cx 	;update body x1
	mov word [snake_y7], dx 	;update body x1	
	mov word cx, [snake_x5]	;save snake head x into cx
	mov word dx, [snake_y5]	;save snake head y into dx	
	mov word [snake_x6], cx 	;update body x1
	mov word [snake_y6], dx 	;update body x1	
	mov word cx, [snake_x4]	;save snake head x into cx
	mov word dx, [snake_y4]	;save snake head y into dx	
	mov word [snake_x5], cx 	;update body x1
	mov word [snake_y5], dx 	;update body x1	
	mov word cx, [snake_x3]	;save snake head x into cx
	mov word dx, [snake_y3]	;save snake head y into dx	
	mov word [snake_x4], cx 	;update body x1
	mov word [snake_y4], dx 	;update body x1	
	mov word cx, [snake_x2]	;save snake head x into cx
	mov word dx, [snake_y2]	;save snake head y into dx	
	mov word [snake_x3], cx 	;update body x1
	mov word [snake_y3], dx 	;update body x1	
	mov word cx, [snake_x1]	;save snake head x into cx
	mov word dx, [snake_y1]	;save snake head y into dx	
	mov word [snake_x2], cx 	;update body x1
	mov word [snake_y2], dx 	;update body x1	
	mov word cx, [snake_head_x]	;save snake head x into cx
	mov word dx, [snake_head_y]	;save snake head y into dx
	mov word [snake_x1], cx 	;update body x1
	mov word [snake_y1], dx 	;update body x1
	ret