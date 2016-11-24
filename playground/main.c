#include <stdio.h>
//#include <windows.h>

int main()
{
	char c;
	// Hier fuege ich nur ein Kommentatr ein
	printf("\nBla Hellseher\n\n");

	printf("Mit welchem Buchstaben beginnt ihr Vorname? \t");
	c = getchar();
	printf("\nIch weiss jetzt, dass Ihr Vorname mit '%c' beginnt.\n\n", c);

	//HANDLE hConsole;
	//hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

	//SetConsoleTextAttribute(hConsole, 14); // 14 = Beliebige Zahl von 1-255 Z.B. 15 = Weiss
	printf("haha!\n\n");

	return 0;
}
