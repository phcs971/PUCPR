rjmp config

.include "lib.inc"

;---------------CONFIG---------------

; Configura Registradores
config:
	;		Config Baudrate
    store	UBRR0H, 0x00
	store	UBRR0L, 0xCF

	;		Config USART0
	store	UCSR0A, 0x02
	store	UCSR0B, 0x18
	store	UCSR0C, 0x06

	;		Config ADC
	store	ADMUX, 0x60
	store	ADCSRA, 0x87

;---------------MAIN---------------

; Loop Principal
main:
	rcall	rx_R16
	rcall	check_input
	rcall	adc_conv
	rcall	send_name
	rcall	adc_to_hex
	send '\n'
	rjmp	main

;---------------SERIAL---------------

; Envia a Informação do R16
tx_R16:
	push	R16
tx_R16_loop:
	;		Espera poder enviar informação
	lds		R16, UCSR0A
	sbrs	R16, UDRE0
	rjmp	tx_R16_loop
	pop		R16
	;		Envia a Informação em R16
	sts		UDR0, R16
	ret

; Recebe Informação no R16
rx_R16:
rx_R16_loop:
	;		Espera receber informação
	lds		R16, UCSR0A
	sbrs	R16, RXC0
	rjmp	rx_R16_loop
	;		Salva a informação em R16
	lds		R16, UDR0
	ret

;---------------CHECK---------------

; Verifica se recebeu um +
check_input:
	jne		R16, '+', main
	ret

;---------------ADC---------------

; Recebe os valores do Conversor ADC
adc_conv:
	;		Seleciona o Canal
	store	ADMUX, 0x60
	pause_i_us 10
	;		Inicia Conversão
	store	ADCSRA, 0xC7
	push	R16
adc_conv_loop:
	;		Espera finalizar Conversão
	lds		R16, ADCSRA
	sbrc	R16, ADSC
	rjmp	adc_conv_loop
	pop		R16
	;		Carrega a Conversão em R16
	lds		R16, ADCH
	ret

;---------------TABLE---------------

; Envia o nome por Tx
send_name:
	push	R16
	;		Inicia com index 0
	ldi		R16, 0
send_name_loop:
	push	R16
	;		Pega o valor de indice R16
	rcall	tabela_R16
	;		Envia o valor
	rcall	tx_R16
	pop		R16
	;		Incrementa o indice
	inc		R16
	;		Verifica se acabou
	jne		R16, 15, send_name_loop
send_name_end:
	pop		R16
	ret

; Tabela contendo: "PEDRO:	ADC = 0x"
tabela:
	.db		'P', 'E', 'D', 'R', 'O', ':', 0x09, 'A', 'D', 'C', ' ', '=', ' ', '0', 'x', 0x00

; Pega o valor R16 da tabela
tabela_R16:
	;		Recupera as posições da tabela
	ldi		ZL, LOW(tabela * 2)
	ldi		ZH, HIGH(tabela * 2)
	;		Adiciona ao index desejado
	add		ZL, R16
	ldi		R16, 0
	adc		ZH, R16
	;		Pega o valor da memória
	lpm		R16, Z
	ret

;---------------HEX---------------

; Converte um número em string hexa
adc_to_hex:
	push	R16
	;		Envia os bits mais significativos
	rcall	h4_to_hex
	pop		R16
	;		Envia os bits menos significativos
	left_shift_R16
	rcall	h4_to_hex
	ret

; Converte e envia os 4 bits mais significativos em Hexa
h4_to_hex:
	right_shift_R16
	;		Compara com 10 para ajustar nos valores A ... F
	cpi		R16, 10
	brsh	R17_as_55
	;		Ajuste de 48 para 0 -> '0'
	ldi		R17, 48
	rjmp	R16_to_hex_end
R17_as_55:
	;		Ajuste de 55 para 10 -> 'A'
	ldi		R17, 55
R16_to_hex_end:
	;		Ajusta e envia o valor
	add		R16, R17
	rcall	tx_R16
	ret
