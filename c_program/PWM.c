
void main()
{
	int * PWM = (int *) 0x20000020;
	int * contador = (int *) 0x20000060;
	int * duty = (int *) 0x20000064;
	int * periodo = (int *) 0x20000068;
	int * ciclos = (int *) 0x2000006C;
	*(PWM+1) = 0;
	*duty = 10;
	*periodo = 20;
	*ciclos=0;
	while(*ciclos<=10)
	{
	for(int i=1;i<=(*periodo);i++)
		{
		
		if(i<=(*duty)){*PWM=0x8;}
		else {*PWM = 0x0;}
		*contador = i;
		}
	(*ciclos)++;
	}
}
