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

;*************************************************;
;	OEM Parameter block
;*************************************************;

times 0x0b - $ + start db 0

bpbBytesPerSector:  	DW 512
bpbSectorsPerCluster: 	DB 1
bpbReservedSectors: 	DW 1
bpbNumberOfFATs: 	    DB 2
bpbRootEntries: 	    DW 224
bpbTotalSectors: 	    DW 2880
bpbMedia: 	            DB 0xF0
bpbSectorsPerFAT: 	    DW 9
bpbSectorsPerTrack: 	DW 18
bpbHeadsPerCylinder: 	DW 2
bpbHiddenSectors: 	    DD 0
bpbTotalSectorsBig:     DD 0
bsDriveNumber: 	        DB 0
bsUnused: 	            DB 0
bsExtBootSignature: 	DB 0x29
bsSerialNumber:	        DD 0xa0a1a2a3
bsVolumeLabel: 	        DB "MOS FLOPPY "
bsFileSystem: 	        DB "FAT12   "

msg     db      "Welcome to My Operating System!", 0

print:
    lodsb
    or al, al
    jz .printdone
    mov ah, 0x0e
    int 0x10
    jmp print

.printdone:
    ret


;*************************************************;
;	Bootloader Entry Point
;*************************************************;

loader:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov si, msg
    call print

    xor ax, ax
    int 0x12


    cli
    hlt

times 510 - ($-$$) db 0
dw 0xaa55

