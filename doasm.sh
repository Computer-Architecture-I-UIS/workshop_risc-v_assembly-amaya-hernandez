#!/bin/bash

# clean previos program
./reset.sh

#create folder if not exist

if [ ! -d dumped_files ]; then
  mkdir dumped_files
fi
#clean the shared folder
rm -rf ./dumped_files/*

# Compile the assembly (just assembly)
riscv64-unknown-elf-gcc -c $1 -o ./dumped_files/obj.o -march=rv32im -mabi=ilp32


# assemble your program
riscv64-unknown-elf-gcc ./dumped_files/obj.o -o ./dumped_files/exe.elf -march=rv32im -mabi=ilp32 -Os -ffreestanding -nostdlib -Wl,-Bstatic,-T,./assembly/ram.lds,-Map,./dumped_files/prog.map,--strip-debug


# Just dump the assembly, for fun
riscv64-unknown-elf-objdump -D ./dumped_files/exe.elf > ./dumped_files/boot.dump


# Get the binary machine code
riscv64-unknown-elf-objcopy -O binary ./dumped_files/exe.elf ./dumped_files/prog.bin

# Get the hex file for verilog techbench
od -t x4 -An -w4 -v ./dumped_files/prog.bin > ./dumped_files/boot.mem

cat ./dumped_files/boot.dump

echo "------------------------------------------------"

cat ./dumped_files/boot.mem
echo "The number of instructions its: "
< ./dumped_files/boot.mem wc -l

cp ./dumped_files/boot.mem ./verilog/ram.mem
cp ./dumped_files/boot.mem ./verilog/boot.mem
