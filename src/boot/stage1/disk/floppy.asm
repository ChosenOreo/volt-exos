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
%ifndef _VOLT_BOOT64_FLOPPY_ASM_
%define _VOLT_BOOT64_FLOPPY_ASM_

AbsTrack:       DB  0
AbsSector:      DB  0
AbsHead:        DB  0
DiskAttempts:   DB  0

LBACHS:
    xor dx, dx
    div word [FatBlock.SectorsPerTrack]
    inc dl
    mov byte [AbsSector], dl
    xor dx, dx
    div word [FatBlock.HeadsPerCylinder]
    mov byte [AbsHead], dl
    mov byte [AbsTrack], al
    ret
    
ReadSectors:
    .Main:
        xor dx, dx
        mov [DiskAttempts], dl
    .Loop:
        push ax
        push bx
        push cx
        
        call LBACHS
        
        inc byte [DiskAttempts]
        
        mov ah, 0x02
        mov al, 0x01
        mov ch, byte [AbsTrack]
        mov cl, byte [AbsSector]
        mov dh, byte [AbsHead]
        mov dl, byte [ExtFatBlock.DriveNumber]
        
        push ax
        
        int 0x13
        
        jnc .Success
        
        cmp byte [DiskAttempts], 0x05
        jae .Abort
        
        xor ax, ax
        mov dl, [ExtFatBlock.DriveNumber]
        
        int 0x13
        pop dx
        
        pop cx
        pop bx
        pop ax
        
    .Abort:
        pop dx
        mov dh, 0x0001
        
        stc
        
        pop cx
        pop bx
        pop ax
        ret
        
    .Success:
        pop dx
        
        pop cx
        pop bx
        pop ax
        
        add bx, word [FatBlock.BytesPerSector]
        
        inc ax
        
        dec cx
        jnz .Main
        ret
        
%endif ;_VOLT_BOOT64_FLOPPY_ASM
