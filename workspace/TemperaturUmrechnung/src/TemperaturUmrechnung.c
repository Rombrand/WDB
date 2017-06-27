/*
 ============================================================================
 Name        : TemperaturUmrechnung.c
 Author      : Christopher Wendt
 Version     :
 Copyright   : Your copyright notice
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>

int main(void) {
	const int umrech = 273;
	int merker;

		while(1)
		{
			printf ("Geben Sie eine Temeratur in Grad-Kelvin ein: ");

			scanf("%d", &merker);

			printf("%d Grad-Kelvin = %d Grad-Celsius\n",merker , merker-umrech);

		}

	return 0;
}
