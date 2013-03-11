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
%ifndef _VOLT_BOOT64_FAT12_ASM_
%define _VOLT_BOOT64_FAT12_ASM_

FatBlock:
        .OEMName:               db      "BOOT64  "
        .BytesPerSector:        dw      512
        .SectorsPerCluster:     db      1
        .ReservedSectors:       dw      1
        .NumberOfFATs:          db      2
        .RootEntries:           dw      224
        .TotalSectors:          dw      2880
        .MediaType:             db      0xf0
        .SectorsPerFAT:         dw      9
        .SectorsPerTrack:       dw      18
        .HeadsPerCylinder:      dw      2
        .HiddenSectors:         dd      0
        .TotalSectorsBig:       dd      0
ExtFatBlock:
        .DriveNumber:           db      0
        .Unused:                db      0
        .ExtBootSignature:      db      0x29
        .SerialNumber:          dd      0x02011997
        .VolumeLabel:           db      "ExOS Floppy"
        .FileSystem:            db      "FAT12   "

%endif ;_VOLT_BOOT64_FAT12_ASM_
