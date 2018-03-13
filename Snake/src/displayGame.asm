clear_screen:
  mov ax, 0x0700
  mov bh, 0x0f
  xor cx, cx
  mov dx, 0x1950
  int 0x10
  ret

; print the window
; AX: title
; BX: options
print_window:
  push dx
  push bx
  push ax
  mov dl, [display_offset]
  add dl, 3
  ; top
  mov dh, 0x05
  mov si, window_bar
  call print_string
  ; space 1
  inc dh
  mov si, window_space
  call print_string
  ; title
  inc dh
  pop si
  call print_string
  ; space 2
  inc dh
  mov si, window_space
  call print_string
  ; options
  inc dh
  pop si
  call print_string
  ; space 3
  inc dh
  mov si, window_space
  call print_string
  ; bottom
  inc dh
  mov si, window_bar
  call print_string


;_____________________________________
  ;Start Writing Levels strings
;_____________________________________
  mov dh , 0x10 ; Move the cursor
  mov si, window_levels
  mov dl, 23 ;Offset to print
  call print_string

  ;Level 2 String
  inc dh
  mov si, window_level2
  call print_string

  ;Level 2 String Space
  inc dh
  mov si, window_level3
  call print_string

  ;Level window levels 
  inc dh
  mov si, window_levels
  call print_string
;___________________________________
  ;Exit
  mov dh , 0x15 ; Move the cursor
  mov si, window_levels
  call print_string

  ;Square  
  inc dh 
  mov si, window_exit
  call print_string
  
  inc dh 
  mov si, window_levels
  call print_string

  pop dx
  
  

  ret

; DX position of char
; AL character
print_object:
  add byte dl, [display_offset]
  call move_cursor
  sub byte dl, [display_offset]
  call print_char
  ret

; DX cursor position
move_cursor:
  mov ah, 0x02
  xor bh, bh
  int 0x10
  ret

; AL character
print_char:  
  mov ah, 0x0E	; t ell BIOS that we need to print one charater on screen
  mov bh, 0x01	; page number
  mov bl, 0x07	; text attribute 0x07 is lightgrey font on black background
  int 0x10
  ret

; DX position
; SI string pointer
print_string:
  push ax
  call move_cursor
.loop:
  mov al, [si]
  cmp al, 0x00
  je .done
  call print_char
  inc si
  jmp .loop
.done:
  pop ax
  ret
