//
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

_start:
	li t0, 255; //Final
	li t1, 1; //ultimo
	li t2, 0; //penultimo
	li t3, 0; //suma
	.inicio:

		add t1, zero, 1;//Inicializamos el ultimo en uno

		add t2, zero ,0;//Limpiamos el penultimo en cero
				 //Para comenzar nuevamente la serie

		.sigueSumando://Bucle para calcular la serie

			add t3, t2, t1;//sumamos ultimo y penultimo

			bge t3, t0, .inicio;//Verificamos que la suma no se
					    //pase de la variable final=255.
					    //Salto a .inicio si suma>=final

			add t2, t1, 0;//penultimo = ultimo
			add t1, t3, 0;//ultimo = suma

			jal x1, .sigueSumando//Saltamos a .sigueSumando

j _start
