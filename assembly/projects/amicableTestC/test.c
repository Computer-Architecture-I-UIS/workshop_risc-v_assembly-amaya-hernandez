// Amicable numbers program written in c as closely as possible to the assembly source to demonstrate that it works

// compile with either gcc or cl (visual studio dev tools):
// gcc test.c
// cl /EHsc .\test.c

#include <stdio.h>

// t0 = A
// t1 = Sumdiva = B
// t2 = Sumdivb
// t3 = divisor
// t4 = Residuo
// t5 = A/2
// t6 = finished

int main(){
	
	int A = 0;
	int Residuo = 0;
	int AH = 0; // A/2
	int finished = 0;
	
	int Sumdiva; // B
	int Sumdivb;
	int divisor;

	counter:;

	Sumdiva = 1; // B ,Sumdiva = 1
	Sumdivb = 1; // Sumdivb    = 1
	divisor = 1; // divisor = 1  
	A++;  // A++
	AH = A >> 1; // A/2 = A >> 1
	
		divisorsa:;

		Residuo = A; // Residuo = A
		divisor++;    // divisor++

		if (divisor > AH) goto equality; // divisor > A/2				

			divisiona:;

			if(Residuo < divisor) goto divisorsa;	// Residuo < divisor
			Residuo -= divisor;		// Residuo -= divisor	

			if (Residuo != 0) goto divisiona;	// Residuo != 0

			Sumdiva += divisor;			// sumdiva += divisor

			goto divisorsa;

		equality:;

		if (A == Sumdiva) goto counter; // A = B
		divisor = 1;	// divisor = 1

		AH = Sumdiva >> 1; // B/2 = B >> 1

		divisorsb:; //B divisors

		Residuo = Sumdiva; // Residuo = B
		divisor++;    // divisor++

		if (divisor > AH) goto check; // divisor > A/2		

			divisionb:;

			if (Residuo < divisor) goto divisorsb;	// Residuo < divisor
			Residuo -= divisor;			// Residuo -= divisor	

			if (Residuo != 0) goto divisionb;	// Residuo != 0

			Sumdivb += divisor;		// sumdivb += divisor

			goto divisorsb;

		check:;
		if (A != Sumdivb) goto counter;	// A =! sumdivb
		finished = 1;	// finished = 1

		printf("Finished, first amicable numbers: %d %d\r\n", A, Sumdiva);
}