########################################################################################################################
# Voltoid ExOS Bootloader
# Copyright (c) 2013 Voltoid Technologies
# All Rights Reserved
########################################################################################################################
# Authors:
#   Adrian Collado <acollado@citlink.net>
########################################################################################################################
# This software is licensed under the Voltoid Source-Only License. To view this license, please visit:
#  https://github.com/ChosenOreo/volt-exos/docs/License-SO.txt
########################################################################################################################

########################################################################################################################
# Variables
########################################################################################################################
# ASSEMBLER                                                 #
#   Defines the assembler to use.                           #
# ASMFLAGS                                                  #
#   Defines the options for the assembler.                  #
#############################################################
ASSEMBLER = nasm
ASMFLAGS = -fbin

all: asmflp

asmflp:
	$(ASSEMBLER) $(ASMFLAGS) -oStage1_Floppy.bin entry_flp.asm

clean:
	rm *.bin
