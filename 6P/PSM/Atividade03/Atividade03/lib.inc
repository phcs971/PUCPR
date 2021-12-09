
; MACRO SET DISPLAY
.macro set_display
	push	R16
		push	R17
			mov		R16, @0
			ldi		R17, @1
			;		Liga o display desejado
			rcall	set_R16_in_display_R17
			sbi		PORTB, @1
		pop		R17
	pop		R16
.endm


; MACRO LOAD (OUT)
.macro load
	push	R16
		ldi		R16, @1
		out		@0, R16
	pop		R16
.endm

; MACRO STORE (STS)
.macro store
	push	R16
		ldi		R16, @1
		sts		@0, R16
	pop		R16
.endm

; MACRO INC_TO
.macro inc_to
	inc		@0
	cpi		@0, @1
	brne	end_inc
	ldi		@0, 0
.endm
