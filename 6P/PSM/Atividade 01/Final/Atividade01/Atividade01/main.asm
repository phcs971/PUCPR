;
; Atividade01.asm
;
; Created: 27/08/2021 09:56:02
; Author : phcs9
;


; Replace with your application code
setup:
    sbi DDRD,6
	sbi DDRD,5
	sbi PORTD,4
	sbi PORTD,3
	sbi PORTD,2
start:
	sbis PIND,4
	rjmp check_3
	rjmp check_3_inversed
check_3:
	sbis PIND,3
	rjmp led01_off
	rjmp led01_on_off
check_3_inversed:
	sbis PIND,3
	rjmp led01_on_on
	rjmp led01_off
led01_off:
	cbi PORTD,6
	rjmp check_2
led01_on_off:
	sbi PORTD,6
	rjmp check_2_inversed
led01_on_on:
	sbi PORTD,6
	rjmp check_2
check_2:
	sbis PIND,2
	rjmp led02_off
	rjmp led02_on
check_2_inversed:
	sbis PIND,2
	rjmp led02_on
	rjmp led02_off
led02_on:
	sbi PORTD,5
	rjmp start
led02_off:
	cbi PORTD,5
	rjmp start

