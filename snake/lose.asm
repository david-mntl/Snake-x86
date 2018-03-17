
lose_window:
	mov ah, 0x00 	;Set video mode
	mov al, 0x13	;graphics, 320x200 res, 8x8 pixel box
	int 0x10
	
	call lose_msg1
	call retry_msg1
	call goMenu_msg
	call menu_msg3
	call wait_for_key

wait_for_key:
	mov	ah, 0x00
	int	0x16
	cmp	al, ' '
	je	init
	cmp al, 'r'
	je retry
	jmp	wait_for_key

retry:
	jmp main
	

lose_msg1:
	mov si, lose_msg
	mov bl, 0x4   ;Set red color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 2	;Set char print row
	mov dl, 13	;Set char print column
	jmp lose_msg2

lose_msg2:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp lose_msg2	;Loop to itself

retry_msg1:
	mov si, retry_msg
	mov bl, 0x2   ;Set red color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 4	;Set char print row
	mov dl, 13	;Set char print column

retry_msg2:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp retry_msg2	;Loop to itself

goMenu_msg:
	mov si, go_menu
	mov bl, 0xA   ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 6	;Set char print row
	mov dl, 14	;Set char print column
	jmp goMenu_msg2

goMenu_msg2:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp goMenu_msg2	;Loop to itself