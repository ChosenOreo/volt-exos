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
%ifndef _VOLT_BOOT64_VIDEO_ASM_
%define _VOLT_BOOT64_VIDEO_ASM_

%define VIDEO_STATE_TABLE   0x7bc0

VideoCardFlags:     db  0
VideoDisplayPage:   db  0

InitVideo:
    mov ax, 0x1a00
    stc
    int 0x10
    
    cmp al, 0x1a
    jne .Done
    
    xor dx, dx
    or dl, 0x01
    mov byte [VideoCardFlags], dl
    
    .CheckTextMode:
        mov ax, 0x1b00
        
        xor bx, bx
        mov es, bx
        
        mov di, VIDEO_STATE_TABLE
        
        int 0x10
        
        cmp al, 0x1b
        jne .SetDefaultMode
        
        mov dl, byte [VideoCardFlags]
        or dl, 0x02
        mov byte [VideoCardFlags], dl
        
        cmp byte [di + 0x04], 0x03
        jne .SetDefaultMode
        
        cmp byte [di + 0x05], 80
        jne .SetDefaultMode
        
        cmp byte [di + 0x22], 25
        je .DefaultMode
        cmp byte [di + 0x22], 24
        je .DefaultMode
        
    .SetDefaultMode:
        mov ax, 0x0003
        int 0x10
        
    .DefaultMode:
        mov ah, 0x01
        mov cx, 0x2d0e
        int 0x10
        
        mov ax, 0x1003
        xor bx, bx
        int 0x10
        
        xor bx, bx
        mov ah, 0x0f
        int 0x10
        mov [VideoDisplayPage], bh
        
    .Done:
        ret
        
VideoDisplayChar:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    
    mov ah, 0x0e
    mov bh, [VideoDisplayPage]
    int 0x10
    
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
    
PrintString:
    cmp byte [VideoCardFlags], 0
    jne .Print
    ret
    
    .Print:
        push ax
        push si
        
        cld
        jmp .Init
        
        .Loop:
            call VideoDisplayChar
            
        .Init:
            lodsb
            or al, al
            jnz .Loop
            
    .Return:
        pop si
        pop ax
        
        ret

%endif ;_VOLT_BOOT64_VIDEO_ASM_
