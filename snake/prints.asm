print_score_msg:
	mov si, score_msg
	mov bl, 0xA   ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 1	;Set char print row
	mov dl, 1	;Set char print column

print_score_msg2:	
	mov ah, 0x2	;Set cursor position interrupt
	int 10h
	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return
	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp print_score_msg2	;Loop to itself	

print_level_msg:
	mov si, level_msg
	mov bl, 0xA   ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 2	;Set char print row
	mov dl, 1	;Set char print column

print_level_msg2:	
	mov ah, 0x2	;Set cursor position interrupt
	int 10h

	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return

	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp print_level_msg2	;Loop to itself	



print_escape_msg:
	mov si, exit_msg
	mov bl, 0xA   ;Set green color
	mov bh, 0   ;Set page 0
	mov cx, 1	;Set number of times
	mov dh, 1	;Set char print row
	mov dl, 25	;Set char print column

print_escape_msg2:	
	mov ah, 0x2	;Set cursor position interrupt
	int 10h
	lodsb		;Move si pointer contents to al
	or al, al	;Break if end of string
	jz return
	mov ah, 0xa	;Teletype output interrupt
	int 10h		;
	inc dl		;Increment column index
	jmp print_escape_msg2	;Loop to itself	

print_int: ; print the int in ax
push bp ; save bp on the stack
mov bp, sp ; set bp = stack pointer

push_digits:
xor dx, dx ; clear dx for division
mov bx, 10 ; set bx to 10
div bx ; divide by 10
push dx ; store remainder on stack
test ax, ax ; check if quotient is 0
jnz push_digits ; if not, loop

pop_and_print_digits:
pop ax ; get first digit from stack
add al, '0' ; turn it into ascii digits
call print_char ; print it
cmp sp, bp ; is the stack pointer is at where we began?
jne pop_and_print_digits ; if not, loop
pop bp ; if yes, restore bp
ret

print_char:
mov ah, 0x0E ;t ell BIOS that we need to print one charater on screen
mov bh, 0x00 ; page number
mov bl, 0x07 ; text attribute 0x07 is lightgrey font on black background
int 0x10
ret