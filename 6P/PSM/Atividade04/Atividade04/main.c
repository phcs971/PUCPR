#define F_CPU 16000000
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

ISR(TIMER0_OVF_vect) {
    increment_display();
    write_display();
    TCNT0 = 6;
    reti();
}

ISR(ADC_vect) {
    get_display_value();
    start_adc();
    reti();
}

uint_8t segments[10] = { 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F };
uint_8t shift[4] = { 1, 10, 100, 1000 };

uint_32t display_value;
uint_8t display;

uint_8t get_adc_value() { return ((uint8_t)ADCH << 8) | ADCL; }

void get_display_value() { display_value = ((uint_32t) get_adc_value() * 5000) / 1024; }

void increment_display() {
    if (display == 3) {
        display = 0;
    } else {
        display++;
    }
}

void setup_timer() {
    TCNT0 = 6;
    TCCR0A = 0;
    TCCR0B = (1 << CS01) | (1 << CS00);
    TIMSK0 = (1 << TOIE0);
}

void setup_displays() {
    DDRD = 0xFF;
    DDRB = 0x0F;
}

void setup_adc() {
    ADMUX = (1 << REFS0);
    ADCSRA = (1 << ADEN) | (1 << ADIE) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
	_delay_us(10)
}

void start_adc() { ADCSRA |= (1 << ADSC); }

uint8_t get_display_digit() { return (value / shift[display]) % 10; }

void write_display() {
    uint8_t digit = segments[get_display_digit()];
    if (display == 3) { digit |= (1 << 7); }
    PORTB = 0x00;
    PORTD = digit;
    PORTB = (1 << display);
}

void setup() {
    setup_displays();
	setup_timer();
    setup_adc();
    sei();
}

int main(void) {
	setup();
    start_adc();
    while(1)
}

