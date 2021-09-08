#!/bin/bash

# clean previos program
./reset.sh

#create folder if not exist
if [ ! -d dumped_files ]; then
  mkdir dumped_files
fi

linker="./c_program/start/ram.lds"
start="./c_program/start/start.S"


# Compile the progInC (just a dummy progInC)
riscv64-unknown-elf-gcc -c $start -o ./dumped_files/start.o -march=rv32im -mabi=ilp32


# Compile the your program to assembly
riscv64-unknown-elf-gcc -c ./$1 -o ./dumped_files/main.S -march=rv32im -mabi=ilp32 -S


# Compile the assembly to object
riscv64-unknown-elf-gcc -c ./dumped_files/main.S -o ./dumped_files/main.o -march=rv32im -mabi=ilp32

# assemble your program
riscv64-unknown-elf-gcc ./dumped_files/start.o ./dumped_files/main.o -o ./dumped_files/boot.elf -march=rv32im -mabi=ilp32 -Os -ffreestanding -nostdlib -Wl,-Bstatic,-T,$linker,-Map,./dumped_files/boot.map,--strip-debug -lgcc



# Just dump the assembly, for fun
riscv64-unknown-elf-objdump -D ./dumped_files/boot.elf -M no-aliases,numeric > ./dumped_files/boot.noaliases.dump

riscv64-unknown-elf-objdump -D ./dumped_files/boot.elf > ./dumped_files/boot.dump


# Get the binary machine code
riscv64-unknown-elf-objcopy -O binary ./dumped_files/boot.elf ./dumped_files/boot.bin

# Get the hex file for verilog techbench
od -t x4 -An -w4 -v ./dumped_files/boot.bin > ./dumped_files/boot.mem

cat ./dumped_files/boot.dump

echo "------------------------------------------------"

cat ./dumped_files/boot.mem
echo "The number of instructions its: "
< ./dumped_files/boot.mem wc -l

cp ./dumped_files/boot.mem ./verilog/ram.mem
cp ./dumped_files/boot.mem ./verilog/boot.mem
