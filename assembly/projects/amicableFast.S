// Version de amicable.S que dura menos ciclos en encontrar el resultado
// 		Para revisar si un número es divisible por 2, en vez de usar el método general de restas sucesivas, lo que se hace es ver el bit menos significativo

// Busca el primer par de 'amicable numbers'
// https://en.wikipedia.org/wiki/Amicable_numbers
// 		"Amicable numbers are two different numbers related in such a way that the sum of the proper divisors of each is equal to the other number" 

	addi x1, zero, 0
	addi x2, zero, 0
	addi x3, zero, 0
	addi x4, zero, 0
	addi x5, zero, 0
	addi x6, zero, 0
	addi x7, zero, 0
	addi x8, zero, 0
	addi x9, zero, 0
	addi x10, zero, 0
	addi x11, zero, 0
	addi x12, zero, 0
	addi x13, zero, 0
	addi x14, zero, 0
	addi x15, zero, 0
	addi x16, zero, 0
	addi x17, zero, 0
	addi x18, zero, 0
	addi x19, zero, 0
	addi x20, zero, 0
	addi x21, zero, 0
	addi x22, zero, 0
	addi x23, zero, 0
	addi x24, zero, 0
	addi x25, zero, 0
	addi x26, zero, 0
	addi x27, zero, 0
	addi x28, zero, 0
	addi x29, zero, 0
	addi x30, zero, 0
	addi x31, zero, 0

// t0 = A
// t1 = Sumdiva = B
// t2 = Sumdivb
// t3 = divisor
// t4 = Residuo
// t5 = A/2
// t6 = finished


_start:
	li t0, 1; // A
	li t4, 0; // Residuo
	li t5, 0; // A/2
	li t6, 0; // finished = 0

	.counter:
	li t6, 1;

	li t1, 1; // B ,Sumdiva = 1
	li t2, 1; // Sumdivb    = 1
	li t3, 1; // divisor = 1  
	add t0, t0, 1;  // A++
	srli t5, t0, 1; // A/2 = A >> 1
	
	// check if 2 is a divisor
	and a3, t0, 1; // a2 = t3 & 1 = LSB(t0) = LSB(A) // bit menos significativo del número
	
	li a2, 2;

	li a1, 1;
	beq a3, a1, .divisorsa; // LSB(A) == 1 -> Impar
	
	li a2, 1;
	li t3, 2; // divisor = 2

	add t1, t1, 2; // sumdiva += 2

		.divisorsa:
		li t6, 2;

		add t4, t0, zero; // Residuo = A
		add t3, t3, a2;    // divisor += a2 // a2 es 1 para números pares, y es 2 para números impares

		bgt t3, t5, .equality; // divisor > A/2

			.divisiona:
			li t6, 3;

			blt t4, t3, .divisorsa;	// Residuo < divisor
			sub t4, t4, t3;			// Residuo -= divisor	

			bne t4, zero, .divisiona;	// Residuo != 0

			add t1, t1, t3;			// sumdiva += divisor

			j .divisorsa	

		.equality:
		li t6, 4;

		beq t0, t1, .counter; // A = B
		li t3, 1;	// divisor = 1

		srli t5, t1, 1; // B/2 = B >> 1

		// check if 2 is a divisor
		and a3, t1, 1; // a2 = t3 & 1 = LSB(t1) = LSB(B) // bit menos significativo del número
		
		li a2, 2;

		li a1, 1;
		beq a3, a1, .divisorsb; // LSB(B) == 1 -> Impar
		
		li a2, 1;
		li t3, 2; // divisor = 2

		add t2, t2, 2; // sumdivb += 2

		.divisorsb: // B divisors
		li t6, 5;

		add t4, t1, zero; // Residuo = B
		add t3, t3, a2;    // divisor += a2 // a2 es 1 para números pares, y es 2 para números impares

		bgt t3, t5, .check; // divisor > A/2		

			.divisionb:
			li t6, 6;

			blt t4, t3, .divisorsb;	// Residuo < divisor
			sub t4, t4, t3;			// Residuo -= divisor	

			bne t4, zero, .divisionb;	// Residuo != 0

			add t2, t2, t3;			// sumdivb += divisor

			j .divisorsb

		.check:
		li t6, 7;
		bne t0, t2, .counter;	// A =! sumdivb
		li t6, 8;	// finished = 1


j _start
