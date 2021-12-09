; START
.org 0x00
	rjmp	config

; INTERRUPTION
.org 0x20
	rcall	on1ms
	reti

.include "pause.inc"
.include "lib.inc" 

;---------------CONFIG---------------
; CONFIG
config:
	;		Config Ports
	load	DDRD, 0xFF
	load	DDRB, 0x0F
	load	PORTB, 0x30

	;		Start Registers
	ldi		R20, 0
	ldi		R21, 0
	ldi		R22, 0
	ldi		R23, 0
	ldi		R24, 0

	;		Modo Normal
	load	TCCR0A, 0x00
	;		Clock de TCNT0
	load	TCCR0B, 0x03
	;		Habilita Timer 0 Overflow Interrupt
	store	TIMSK0, 0x01
	;		Inicia Contador com 6
	load	TCNT0, 6
	sei

	rjmp main

;---------------MAIN---------------
; MAIN LOOP
main:
	b1:
		sbic	PINB, 4
		rjmp	b2
		load	TCCR0B, 0x03
	b2:
		sbic	PINB, 5
		rjmp	disp
		load	TCCR0B, 0x00
	disp:
		set_display R21, 0
		pause_i_ms	5
		set_display R22, 1
		pause_i_ms	5
		set_display R23, 2
		pause_i_ms	5
		set_display R24, 3
		pause_i_ms	5
	rjmp	main

;---------------SET SEGMENT---------------
; TABLE SEGMENTS
segments:
	.db		0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x00, 0x00

; SEGMENT R16
segment_R16:
	;		Recupera as posicoes da tabela
	ldi		ZL, LOW(segments * 2)
	ldi		ZH, HIGH(segments * 2)
	;		Adiciona ao index desejado
	add		ZL, R16
	ldi		R16, 0
	adc		ZH, R16
	;		Pega o valor da memoria
	lpm		R16, Z
	ret

; SET R16 IN DISPLAY R17
set_R16_in_display_R17:
	;		Apaga Displays
	load	PORTB, 0x30
	;		Converte 0-9 em 7 segmentos
	rcall	segment_R16
	cpi		R17, 0
	breq	end_set_R16_in_display_R17
	cpi		R17, 2
	breq	end_set_R16_in_display_R17
	rcall	add_dp
end_set_R16_in_display_R17:
	out		PORTD, R16
	ret

; ADD DECIMAL POINT
add_dp:
	push	R17
		ldi		R17, 0x80
		add		R16, R17
	pop		R17
	ret

;---------------INTERRUPTION---------------
; ON 1 MS
on1ms:
	push	R16
		in		R16, SREG
		push	R16
			load	TCNT0, 6
			rcall	start_inc
		pop		R16
		out		SREG, R16
	pop		R16
	ret

; INCREMENT
start_inc:
inc20:
	inc_to	R20, 100
inc21:
	inc_to	R21, 10
inc22:
	inc_to	R22, 10
inc23:
	inc_to	R23, 6
inc24:
	inc_to	R24, 10
end_inc:
	ret