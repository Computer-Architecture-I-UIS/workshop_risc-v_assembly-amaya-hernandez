// Organize array of unsigned 8-bit integers in decreasing order (in place)
//      meaning list[0] will have the highest number, and list[15] the lowest

void main()
{
	char * list = (char *) 0x20000060;
    char arraySize = 16;

    // Random numbers generated using https://www.browserling.com/tools/random-hex
    (*((int *) 0x20000060)) = 0x6cff6afe; // regtest1 reg0
    (*((int *) 0x20000064)) = 0xd4bba61f; // regtest1 reg1
    (*((int *) 0x20000068)) = 0x552a1d58; // regtest1 reg2
    (*((int *) 0x2000006C)) = 0xfcfae142; // regtest1 reg3

    int * isOrdered = (int *) 0x20002080; // regtest2 reg0
    (*isOrdered) = 0;
    char tempIsOrdered = 0;

    while(!tempIsOrdered){
        tempIsOrdered = 1;
        for (char i = 1; i < arraySize; i++){
            if (list[i-1] < list[i]){
                char tmp = list[i-1];
                list[i-1] = list[i];
                list[i] = tmp;
                tempIsOrdered = 0;
            }
        }
    }
    (*isOrdered) = 1;
}