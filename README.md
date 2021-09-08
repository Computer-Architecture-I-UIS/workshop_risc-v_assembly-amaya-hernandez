# RISC-V Assembly First Steps

The following procedure should get you started with a clean running RISC-V Assembly project.

### Prerequisites

#### Please Download & Read:

- [RISC-V Book](http://riscvbook.com/spanish/) cap 1 to 3.
- [RISC-V Green Card](http://riscvbook.com/greencard-20181213.pdf)

#### Please Install:

- RISC-V GNU Compiler Toolchain from [here](https://github.com/riscv/riscv-gnu-toolchain), with **--enable-multilib** option
  - Add to your ~/.bashrc file:

  ```sh
  # assume RISC-V is installed to /opt/riscv/
  export RISCV_PATH=/opt/riscv
  export PATH=$PATH:$RISCV_PATH/bin
  ```
- Icarus Verilog from [here](https://iverilog.fandom.com/wiki/Installation_Guide), **compile from source**
- Download this repository and execeute the following commands to add execution permissions:
  ```sh
  chmod +x doasm.sh
  ```
  ```sh
  chmod +x compile.sh
  ```
  ```sh
  chmod +x reset.sh
  ```


### Test Tools Before Proceeding 

- RISC-V GNU Compiler Toolchain
  ```sh
  riscv64-unknown-elf-gcc --version
  ```
  ```sh
  riscv64-unknown-elf-objcopy --version
  ```
- Iverilog
  - Follow the [guide](https://iverilog.fandom.com/wiki/Getting_Started)

## Fibonacci Sequence in RISC-V Assembly by Cristian Miranda 

Such that each number is the sum of the two preceding ones, starting from 0 and 1. [Ref](https://en.wikipedia.org/wiki/Fibonacci_number)

- 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...

```
_start:
 li t0, 255; //Final
 li t1, 1;   //ultimo
 li t2, 0;   //penultimo
 li t3, 0;   //suma
 .inicio:
		
  add t1, zero, 1;  //Inicializamos el ultimo en uno
		
  add t2, zero ,0;  //Limpiamos el penultimo en cero para comenzar nuevamente la serie
		
   .sigueSumando:  //Bucle para calcular la serie
		
    add t3, t2, t1; //sumamos ultimo y penultimo

    bge t3, t0, .inicio;  //Verificamos que la suma no se pase de la variable final=255.
                          //Salto a .inicio si suma >= final

    add t2, t1, 0;  //penultimo = ultimo
    add t1, t3, 0;  //ultimo = suma

    jal x1, .sigueSumando //Saltamos a .sigueSumando
			
j _start
```


### Run The Compiler

**doasm.sh** script will:

- Compile the asm program
- Assemble your program
- Get the binary mahine code 
- Get the HEX file for Verilog techbench
- Print the dumped file
- Print the number of instructions

```sh
./doasm.sh assembly/projects/fibonacci.S
```

### Run the Simulator

```sh
cd verilog
```
```sh
iverilog -o test *.v
```
```sh
vvp test
```

### Check the Waveform

```sh
gtkwave test.vcd
```

## PWM C program to RISC-V Assembly by Cristian Miranda 

### Run The Compiler

**compile.sh** script will:

- Compile the Start.S program
- Compile the C program
- Assemble your program with the Start.S
- Get the binary mahine code 
- Get the HEX file for Verilog techbench
- Print the dumped file
- Print the number of instructions

```sh
./compile.sh c_program/PWM.c
```

### Then Repet Run the Simulator & Check the Waveform
