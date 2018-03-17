win_window:
	mov ah, 0x00 	;Set video mode
	mov al, 0x13	;graphics, 320x200 res, 8x8 pixel box
	int 0x10
	
	call win_msg1
	call goMenu_msg
	call menu_msg3
	call wait_for_key

win_msg1:
	mov si, win_msg
	mov bl, 0xA   ;Set red color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 2	;Set char print row
	mov dl, 9	;Set char print column
	jmp win_msg2

win_msg2:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp win_msg2	;Loop to itself


win_level:
	call init_data
	cmp byte [level], 3
	je win_window
	mov ah, 0x00 	;Set video mode
	mov al, 0x13	;graphics, 320x200 res, 8x8 pixel box
	int 0x10
	call menu_msg3
	call winLevel_msg
	mov	ax, [level]	; move the score into ax
  	call print_int	; print it	
	call wait_for_key2

winLevel_msg:
	mov si, winL_msg
	mov bl, 0xA   ;Set red color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 2	;Set char print row
	mov dl, 9	;Set char print column
	jmp winL_msg2

winL_msg2:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp winL_msg2	;Loop to itself


wait_for_key2:
	mov	ah, 0x00
	int	0x16
	cmp	al, ' '
	je	change_level
	jmp	wait_for_key2