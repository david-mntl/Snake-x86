
; constants

%define GAME_WIDTH 30

; clear the cursor blinking
mov	ah, 0x01
mov	cx, 0x2000
int 	0x10

; calculate game screen position
mov	ah, 0x0F
int	0x10 ; load the number of columns
sub byte ah, 1
sub ah, GAME_WIDTH
sar ah, 1
mov [display_offset], ah


jmp main

%include "./src/keyboard.asm"
%include "./src/displayGame.asm"
%include "./src/mainGame.asm"
%include "./src/playerMovement.asm"

%include "./src/boardCage.asm"
%include "./src/arena.asm"

; main loop
main:
  mov ah, [program_state]
  cmp ah, 1
  je .game
.intro:
  call intro
  jmp main
.game:
  call game
  jmp main



;-------FUNCTIONS-----------
intro:
  call clear_screen

  mov ax, intro_string_t ;; STRING TO WRITE ON THE WINDOW
  mov bx, intro_string_o
  call print_window  ;; INTRO SCREEN

.wait:
  call get_key
  mov al, [key_pressed]
  cmp al, ' '
  je .game
  ;cmp al, '1'
  ;je .game
  ;CODIGO al level 2
  ;cmp al, '2'
  ;je .game
  ;CODIGO al level 2
  jmp .wait
.game:
  mov byte [program_state], 1
  ret

; game loop
game:
  call init_game
.loop:

; check the current program state
  cmp byte [program_state], 1
  jne .done

  ; get key if available
  call check_key

  ; INSERT WIN or LOSE CONDITIONS
  ;
  ; llllllllllllllllllllllllllllll
  ;
  ;

  ; execute a game step
  jmp .execute

.execute:
  ; move Snake
  call move_Snake

  ; render
  call clear_screen
  call render_arena;draw_boardCage

  call render_player
  

.continue:
  mov cx, 0x0000  ; 0.05 seconds (cx:dx)
  mov	dx, 0x1388  ; 0x00001388 = 5000
  call sleep
  jmp	.loop

.done:
  mov byte [program_state], 2
  ret

.wait:
  call get_key
  mov al, [key_pressed]
  cmp al, 'r'
  je .game
  jmp .wait
.game:
  mov byte [program_state], 1
  ret


; window
window_bar db "######################", 0
window_space db "#                    #", 0
window_space2 db "|                           |", 0
window_levels dw " ------------------------------", 0
window_level2 dw "|  Press 2 to start level two  |" , 0
window_level3 dw "| Press 3 to start level three |" , 0
window_exit dw   "|      Press Esc to exit       |" , 0

; intro
intro_string_t db "#       SNAKE        #", 0
intro_string_o db "#   SPACE to start   #", 0

; end
end_string_w db "#    PLAYER  wins    #", 0
end_string_l db "#    INVADERS win    #", 0
end_string_o db "# Press R to restart #", 0

; controls
left_string db "A = move left", 0
right_string db "D = move right", 0
shoot_string db "SPACE = shoot", 0


; program state
; 0: start screen
; 1: game screen
; 2: end screen
program_state db 0

segment .bss
  ; display properties
  display_offset resb 1

  ; keyboard
  key_pressed resb 1

  ; game
  ; 0: player wins
  ; 1: invaders win
  winner resb 1

  ; player
  player_pos resw 1
  ; invaders

