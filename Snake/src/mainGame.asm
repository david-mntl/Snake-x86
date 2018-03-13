; ******************************************************
;  * initialize the game state
;  *****************************************************
init_game:
  ; initialize the player
  mov word [player_pos], 0x1401
  
  ret


; ******************************************************
;  * check whether the game is finished
;  *****************************************************
; AL 0: continue
;    1: Player loses
;    2: Player wins
check_game_state:
    
  ; continue
  mov al, 0
  jmp .done
.done:
  ret


; sleep
; DX Duration in micro-seconds
sleep:
  push ax

  mov	cx, 0x0000	; Sleep for 0,05 seconds (cx:dx)
  mov	dx, 0x1388	; 0x00001388 = 5000
  mov	ah, 0x86
  int	0x15		; Sleep

  pop ax
  ret


; ******************************************************
;  * move an object
;  *****************************************************
; DX position to move
; AL direction
move:
  cmp al, 1
  je .right
  cmp al, 2
  je .down
  cmp al, 3
  je .left
.up:
  ;cmp dh, 0
  ;jle .done
  sub	word dx, 0x0100
	jmp .done
.down:
  ;cmp dh, 24
  ;jge .done
  add	word dx, 0x0100
	jmp .done
.left:
  ;cmp dl, 1
  ;jle .done
  sub	word dx, 0x0001
	jmp .done
.right:
  ;cmp dl, GAME_WIDTH - 1
  ;jge .done
  add	word dx, 0x0001
.done:
  ret