;---------------STORE---------------

.macro store
	push	R16
	ldi		R16, @1
	sts		@0, R16
	pop		R16
.endm

;---------------SHIFT---------------

.macro left_shift_R16
	lsl R16
	lsl R16
	lsl R16
	lsl R16
.endm

.macro right_shift_R16
	lsr R16
	lsr R16
	lsr R16
	lsr R16
.endm

;---------------SEND---------------

.macro send
	push	R16
	ldi		R16, @0
	rcall	tx_R16
	pop		R16
.endm

;---------------JUMP---------------

.macro	je ; Jump Equal
	cpi		@0,@1
	breq	@2
.endm

.macro	jne ; Jump Not Equal
	cpi		@0,@1
	brne	@2
.endm

;---------------PAUSE---------------


.macro pausa_11_ciclos
	push	R16	; <- 2 ciclos
	pop		R16 ; <- 2 ciclos
	push	R16	; <- 2 ciclos
	pop		R16 ; <- 2 ciclos
	nop			; <- 1 ciclo
	nop			; <- 1 ciclo
	nop			; <- 1 ciclo
.endm

.macro	pause_i_us
	push	R16
	ldi		R16, @0
	rcall	pause_R16_us_
	pop		R16
.endm

pause_R16_us_:
	nop
pause_R16_us_loop_:
	je		R16, 1, pause_R16_us_end_
	dec		R16
	pausa_11_ciclos
	rjmp	pause_R16_us_loop_
pause_R16_us_end_:
	ret