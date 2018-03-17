[BITS 16]
[ORG 0x0000]      ; This code is intended to be loaded starting at 0x1000:0x0000
                  ; Which is physical address 0x10000. ORG represents the offset
                  ; from the beginning of our segment.

; Our bootloader jumped to 0x1000:0x0000 which sets CS=0x1000 and IP=0x0000
; We need to manually set the DS register so it can properly find our variables

mov ax, cs
mov ds, ax   	; Copy CS to DS (we can't do it directly so we use AX temporarily)

jmp init

%include "draw.asm"
%include "menu.asm"
%include "init_data.asm"
%include "levels.asm"
%include "prints.asm"
%include "keyboard.asm"
%include "move.asm"
%include "lose.asm"
%include "collision_check.asm"
%include "win.asm"

init:		
	mov byte [level], 1
	call menu  ;go to menu.asm file for more detail -- call make menu


main:		
	mov ah, 0x00 	;Set video mode
	mov al, 0x13	;graphics, 320x200 res, 8x8 pixel box
	int 0x10

	call init_data 	;go to init_data.asm file for more detail -- initialize the variables
	call random
	call draw

	call print_score_msg
	mov	ax, [score]	; move the score into ax
  	call print_int	; print it
  	call print_level_msg
  	mov	ax, [level]	; move the score into ax
  	call print_int	; print it
  	call print_escape_msg

  	jmp game

reset_register:
	and cx, 0
	and dx, 0
	ret

;-----game settings-------------
change_level:				;when the user win a level this is the setup tochange from the actual level to the next
	cmp byte [level], 1
	je change_level12
	cmp byte [level], 2
	je change_level23
	ret

change_level12:				;changed level from 1 t 2
	mov byte [level], 2
	jmp main

change_level23:				;changed level from 2 to 3
	mov byte [level], 3
	jmp main
game:	
	

	call print_score_msg
	mov	ax, [score]	; move the score into ax
  	call print_int	; print it
  	call print_level_msg
  	
  	call check_keyboard

  	
continue:
	;compare in wich level we are and then set the speed 
	cmp byte [level], 0x01
	je speed_level1
	cmp byte [level], 0x02
	je speed_level2
	cmp byte [level], 0x03
	je speed_level3

	jmp game 	; loop

return:
	ret

;Halt execution
halt: 
	hlt
	ret

speed_level1:
	mov	cx, 0x0003	; Sleep for 0,15 seconds (cx:dx)
	mov	dx, 0x49F0	; 0x000349F0 = 150000
	mov	ah, 0x86
	int	0x15		; Sleep
	jmp game

speed_level2:
	mov	cx, 0x0001	; Sleep for 0,15 seconds (cx:dx)
	mov	dx, 0x49F0	; 0x000149F0 = 150000
	mov	ah, 0x86
	int	0x15		; Sleep
	jmp game

speed_level3:
	mov	cx, 0x0000	; Sleep for 0,15 seconds (cx:dx)
	mov	dx, 0xD9F0	; 0x0D9F0 = 150000
	mov	ah, 0x86
	int	0x15		; Sleep
	jmp game

random:
	mov bx, 118;   ; set max value for random call (y-val - 1) 
	call rand  ; generate random value
	push dx   ; save it on the stack
	mov bx, 144;   ; set max value for random call 
	call rand  ; generate random value
	pop cx    ; restore old random into cx
	add dx , 84   ; adds the minimun of the cage in X
	add cx , 40   ; adds te minimum of the cage borders in Y
	mov word [food_x], dx
	mov word [food_y], cx
	ret




; UTILITY FUNCTIONS -----------------------------------------------------------
rand:				; random number between 1 and bx. result in dx
	mov	ah, 0x00
	int	0x1A		; get clock ticks since midnight
	mov	ax, dx		; move lower bits into ax for division
	xor	dx, dx		; clear dx
	div	bx		; divide ax by bx to get remainder in dx
	inc	dx
	ret

;------ SETTING CONSTANT DATA -------------------------------------------
section .data
	win_msg	db 'Has Dominado el juego!!', 0	;when the player win the level
	lose_msg	db 'Has perdido', 0 	;when the player loss
	retry_msg db 'Reintentar (r)', 0	;retry message

	winL_msg db 'Has ganado el Nivel: ',0 ;msg for win level

	go_nextLevel db 'Ir al sig. nivel', 0

	go_menu db 'Ir al menu', 0 				;go to menu message

	exit_msg db 'Exit (e)', 0				;exit game message

	score_msg db 'Score: ', 0				;message for the score	
	level_msg db 'Level: ', 0				;message for the level
	;---------info for menu in spanish ---------------------------------
	menu1	dw 'SNAKE', 0 					;game name
	menu2	dw 'Iniciar', 0					;go to level 1 message
	menu3 	dw '(presione Space)', 0		;press espace message
	menu4	dw 'Nivel 2', 0 				;go to level 2 message
	menu5 	dw '(presione 2)', 0			;press espace message
	menu6	dw 'Nivel 3', 0					;go to level 3 message
	menu7 	dw '(presione 3)', 0			;press espace message
	menu8	dw 'EXIT (e)', 0				;exit the gam	

	;--------info of game colors ----------------------------------------------
	snake_head_color db 0x01,0				;variable that saves the snake head color (blue)
	snake_body_color db 0x06,0				;variable that saves the snake body color 
	food_color db 0xA,0						;variable that saves the food color (green)							


;---------- SETTING VARIABLES -------------------------------------------
section .bss

	last_move resb 1		;variable that saves the last move of the snake
	key_pressed resb 1		;variable that saves the actual move

	snake_size resw 1		;variable that saves the size of the snake

	snake_head_x resw 1		;variable that saves the snake head x position
	snake_head_y resw 1		;variable that saves the snake head y position

	snake_x1 resw 1		;variable that saves the snake x1 position
	snake_y1 resw 1		;variable that saves the snake y1 position
	snake_x2 resw 1		;variable that saves the snake x1 position
	snake_y2 resw 1		;variable that saves the snake y1 position

	snake_x3 resw 1		;variable that saves the snake x1 position
	snake_y3 resw 1		;variable that saves the snake y1 position
	snake_x4 resw 1		;variable that saves the snake x1 position
	snake_y4 resw 1		;variable that saves the snake y1 position

	snake_x5 resw 1		;variable that saves the snake x1 position
	snake_y5 resw 1		;variable that saves the snake y1 position
	snake_x6 resw 1		;variable that saves the snake x1 position
	snake_y6 resw 1		;variable that saves the snake y1 position

	snake_x7 resw 1		;variable that saves the snake x1 position
	snake_y7 resw 1		;variable that saves the snake y1 position
	snake_x8 resw 1		;variable that saves the snake x1 position
	snake_y8 resw 1		;variable that saves the snake y1 position

	snake_x9 resw 1		;variable that saves the snake x1 position
	snake_y9 resw 1		;variable that saves the snake y1 position
	snake_x10 resw 1		;variable that saves the snake x1 position
	snake_y10 resw 1		;variable that saves the snake y1 position	

	snake_xTmp resw 1		;variable that saves the snake body temporal x position
	snake_yTmp resw 1		;variable that saves the snake body temporal x position

	snake_black_x resw 1	;variable that saves the snake body temporal x position
	snake_black_y resw 1	;variable that saves the snake body temporal y position
	
	food_x resw 1			;variable that saves the food x position
	food_y resw 1 			;variable that saves the food y position
	
	level resb 1			;variable that saves the actual level 

	score 	resw 1			;variable that saves the score of the player
