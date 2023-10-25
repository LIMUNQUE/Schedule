#include <Arduino.h>
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
// Pines
int bt = 4;
int echo = 5;
int trig = 6;

// variables
const float DISTANCIA = 20.0;
const float SONIDO = 34300.0;
char NUM[10] = {0B1000000, 0B1111001, 0B0100100, 0B0110000, 0B0011001, 0B0010010, 0B0000011, 0B1111000, 0B0000000, 0B0011000};
int i = 0;
int sentido = 0; // 0 izq, 1 der

void iniciarTrigger()
{ // Dispara un pulso ultrasónico
  PORTB &= ~(1 << trig);
  _delay_us(2);
  PORTB |= (1 << trig);
  _delay_us(10);
  PORTB &= ~(1 << trig);
}

void setup()
{
  DDRB = (1 << PB0) | (1 << PB1) | (1 << PB2) | (1 << trig); // Pines salida
  DDRB = (0 << echo) & (0 << bt);                            // Pines entrada

  // Habilita interrupciones externas para ECHO_PIN (INT1)
  EICRA |= (1 << ISC11); // Configura INT1 para detectar flanco de bajada
  EIMSK |= (1 << INT1);  // Habilita INT1

  // Configura el timer para medir la duración del pulso del sensor ultrasónico
  TCCR1B |= (1 << ICES1); // Configura el timer para capturar flanco de subida en el pin ICP1
  TIMSK1 |= (1 << ICIE1); // Habilita la interrupción de captura de timer1

  // Habilita las interrupciones globales
  sei();

  PORTB = 0b101;

  DDRD = 0B1111111;
}

void loop()
{
  // Dispara un pulso ultrasónico
  PORTB |= (1 << trig);
  _delay_us(10);
  PORTB &= ~(1 << trig);
  _delay_ms(100); // Espera un tiempo suficiente para la medición

  if (PINB & (1 << bt))
  {
    // si sentido es 1 pasa a 0 y viceversa
    sentido = ~sentido;
    PORTB ^= (1 << PB1) | (1 << PB2); // se habilita para que gire en una sentido
    PORTD = NUM[i];
    i++;
    if (i > 9)
    {
      i = 0;
    }
    _delay_ms(500);
  }
}

// Manejador de interrupción para la captura de timer1 (cuando el pulso del sensor ultrasónico vuelve)
ISR(TIMER1_CAPT_vect)
{
  // Calcula la duración del pulso (en microsegundos)
  unsigned int pulse_duration = ICR1;

  // Convierte la duración a distancia en centímetros (la velocidad del sonido es de aproximadamente 343 m/s)
  unsigned int distance = pulse_duration / 58;

  // Establece un umbral de distancia para encender el LED
  unsigned int threshold_distance = 10; // Ajusta el umbral según tus necesidades

  if (distance < threshold_distance)
  {
    // Apaga motor
    PORTB &= (0 << PB0) | (0 << PB1) | (0 << PB2);
  }
  else
  {
    // Motor normal
    if (sentido == 0)
    {
      PORTB &= (0 << PB1);
      PORTB = (1 << PB2) | (1 << PB0);
    }
    else
    {
      PORTB &= (0 << PB2);
      PORTB = (1 << PB1) | (1 << PB0);
    }
  }
}

int main()
{
  setup();

  while (1)
  {
    loop();
  }
  return 0;
}
