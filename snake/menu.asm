menu:
	mov ah, 0x00 	;Set video mode
	mov al, 0x13	;graphics, 320x200 res, 8x8 pixel box
	int 0x10
	mov ah, 0x0c			;Write graphics pixel
	mov bh, 0x00 			;page #0
	
	call menu_draw
	call menu_msg1
	call menu_msg2
	call menu_msg3
	call menu_msg4
	call menu_msg5
	call menu_msg6
	call menu_msg7
	call menu_msg8
	call wait_for_menu

menu_draw:
	;Create the large boxes
	mov al, 0x5		;Set purple color
	mov cx, 85		;Set column (x) to 85
	mov dx, 51		;Set row (y) to 50
	call draw_level_box
	mov dx, 83		;Set row (y) to 80
	call draw_level_box
	mov dx, 115		;Set row (y) to 115
	call draw_level_box
	mov al, 0x4		;Set dark gray color
	mov dx, 160		;Set row (y) to 50
	call draw_level_box
	and cx, 0		;reset register
	and dx, 0		;reset register
	ret

wait_for_menu:
	mov	ah, 0x00
	int	0x16
	cmp	al, ' '
	je	level1
	cmp al, '2'
	je  level2
	cmp al,  '3'
	je  level3
	cmp al,  'e'
	je  halt
	jmp	wait_for_menu

menu_msg1:
	mov si, menu1
	mov bl, 0x3   ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 2	;Set char print row
	mov dl, 16	;Set char print column
	jmp msg_menu1

menu_msg2:
	mov si, menu2
	mov bl, 0x6   ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 6	;Set char print row
	mov dl, 15	;Set char print column
	jmp msg_menu2

menu_msg3:
	mov si, menu3
	mov bl, 15  ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 7	;Set char print row
	mov dl, 11	;Set char print column
	jmp msg_menu3
	
menu_msg4:
	mov si, menu4
	mov bl, 0x6 ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 10	;Set char print row
	mov dl, 15	;Set char print column
	jmp msg_menu4
	
menu_msg5:
	mov si, menu5
	mov bl, 15  ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 11	;Set char print row
	mov dl, 13	;Set char print column
	jmp msg_menu5

menu_msg6:
	mov si, menu6
	mov bl, 0x6   ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 14	;Set char print row
	mov dl, 15	;Set char print column
	jmp msg_menu6

menu_msg7:
	mov si, menu7
	mov bl, 15  ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 15	;Set char print row
	mov dl, 13	;Set char print column
	jmp msg_menu7

menu_msg8:
	mov si, menu8
	mov bl, 0x4   ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 21	;Set char print row
	mov dl, 14	;Set char print column
	jmp msg_menu8

;Print a message given its color
print_msg:
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 12	;Set char print row
	mov dl, 10	;Set char print column
	

msg_menu1:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp msg_menu1	;Loop to itself

msg_menu2:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp msg_menu2	;Loop to itself

msg_menu3:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp msg_menu3	;Loop to itself

msg_menu4:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp msg_menu4	;Loop to itself

msg_menu5:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp msg_menu5	;Loop to itself

msg_menu6:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp msg_menu6	;Loop to itself

msg_menu7:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp msg_menu7	;Loop to itself

msg_menu8:
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp msg_menu8	;Loop to itself
