;******************************************************
;       boot1.asm
;           - A simple bootloader
;
;       Operating System Tutorial
;******************************************************
[org 0x7c00]
[bits 16]

start:
    jmp loader




loader:
    cli
    hlt

times 510 - ($-$$) db 0
dw 0xAA55

