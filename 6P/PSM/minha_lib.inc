
.macro pausa_1_ciclo
	nop
.endm

.macro pausa_4_ciclos
	push	R16	; <- 2 ciclos
	pop		R16 ; <- 2 ciclos
.endm

.macro	je
	cpi		@0,@1
	breq	@2
.endm

.macro	jne
	cpi		@0,@1
	brne	@2
.endm

.macro pause_R16_us
	push	R16
	rcall	pause_R16_us_
	pop		R16
.endm

.macro	pause_i_us
	push	R16
	ldi		R16,@0
	rcall	pause_R16_us_
	pop		R16
.endm

.macro pause_i_ms
	push	R16
	ldi		R16,@0
	rcall	pause_R16_ms_
	pop		R16
.endm

pause_R16_us_:
	nop
pause_R16_us_loop_:
	je		R16, 1, pause_R16_us_end_
	dec		R16
	pausa_4_ciclos
	pausa_4_ciclos
	pausa_1_ciclo
	pausa_1_ciclo
	pausa_1_ciclo
	rjmp	pause_R16_us_loop_
pause_R16_us_end_:
	ret

pause_R16_ms_:
pause_R16_ms_loop_:
	pause_i_us	250
	pause_i_us	250
	pause_i_us	250
	pause_i_us	249
	pausa_1_ciclo
	je		R16,1,pause_R16_ms_fim_
	dec		R16
	pausa_4_ciclos
	pausa_4_ciclos
	pausa_1_ciclo
	pausa_1_ciclo
	rjmp	pause_R16_ms_loop_
pause_R16_ms_fim_:
	ret








