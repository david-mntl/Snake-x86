; ******************************************************
;  * move
;  *****************************************************
move_Snake:
  push ax
  push dx

  ; load data
  mov dx, [player_pos]
  mov al, [key_pressed]

  cmp al, 'a'
  je .left
  cmp al, 'd'
  je .right
  cmp al, 'w'
  je .up
  cmp al, 's'
  je .down
  ;cmp al, ' '
  ;je .shoot
  jmp .check
;.shoot:
;  call create_player_bullet
;  jmp .check
.left:
  mov al, 3
  call move
  jmp .check
.right:
  mov al, 1
  call move
  jmp .check
.down:
  mov al, 2
  call move
  jmp .check
.up:
  mov al, 4
  call move
  jmp .check

.check:
 ; call check_bullet_collisions
  mov [player_pos], dx
.done:
  pop dx
  pop ax
  ret


; ******************************************************
;  * render
;  *****************************************************
render_player:
  push ax
  push dx
  mov dx, [player_pos]
  cmp dx, 0x0000
  je .done
  mov al, 'M'
  call print_object 
.done:
  pop dx
  pop ax 
  ret