;=======================================================================================================================
; Voltoid ExOS Bootloader
; Copyright (c) 2013 Voltoid Technologies
; All Rights Reserved
;=======================================================================================================================
; Authors:
;   Adrian Collado <acollado@citlink.net>
;=======================================================================================================================
; This software is licensed under the Voltoid Source-Only License. To view this license, please visit:
;  https://github.com/ChosenOreo/volt-exos/docs/License-SO.txt
;=======================================================================================================================
bits 16
cpu 8086

org 0x7c00

Entry:
    jmp Main
    
;=======================================================================================================================
; Include Files
;=======================================================================================================================
; Floppy Disk Includes
%include "disk/fat12.asm"
%include "disk/floppy.asm"
; Video Includes
%include "video/video.asm"
; Error Includes
%include "error/abort.asm"
; Message Includes
%include "string/messages.asm"

;=======================================================================================================================
; Main Code
;=======================================================================================================================
Main:
    ; First, we clear segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    
    ; And we setup the stack.
    mov ss, ax
    mov sp, 0xffff
    
    ; We load a value into the FAT block
    mov [ExtFatBlock.DriveNumber], dl
    
    ; Now, we initialize standard text mode.
    call InitVideo
    mov si, Messages.VideoTest
    call PrintString
    
    ; Next, we load 7 sectors, starting at lba 1 into RAM at location 0x500
    mov ax, 0x0001
    mov bx, 0x0000
    mov es, bx
    mov bx, 0x0500
    mov cx, 0x0007
    call ReadSectors
    
    ; If reading failed, we abort
    jc Abort
    
    ; Finally, we execute stage 2
    jmp 0x0000:0x0500
    
times 510 - ($-$$) db 0
dw 0xaa55
