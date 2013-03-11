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
%ifndef _VOLT_BOOT64_ABORT_ASM_
%define _VOLT_BOOT64_ABORT_ASM_

AbortMessage:	db	"Aborting Boot!", 0x0a, 0x0d, 0x00

Abort:
    mov si, AbortMessage
    call PrintString
    
    .Stop:
        hlt
        jmp .Stop
        
%endif ;_VOLT_BOOT64_ABORT_ASM_
