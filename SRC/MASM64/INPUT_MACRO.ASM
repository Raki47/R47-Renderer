; ***************************************************************************************************************************************************
; Input Macro Library for MASM32 projects
; ***************************************************************************************************************************************************
; Copyright (c) 2024 Filip Rancic
;
; Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
; to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
; and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
; OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
; DEALINGS IN THE SOFTWARE.
; ***************************************************************************************************************************************************

.data

; Creating global definitions
.global KEY_LMB
.global KEY_RMB
.global KEY_ESC
.global KEY_RTN
.global KEY_CTRL
.global KEY_ALT
.global KEY_SPC
.global KEY_BKSPC
.global KEY_LSHFT
.global KEY_RSHFT
.global KEY_0
.global KEY_1
.global KEY_2
.global KEY_3
.global KEY_4
.global KEY_5
.global KEY_6
.global KEY_7
.global KEY_8
.global KEY_9
.global KEY_N0
.global KEY_N1
.global KEY_N2
.global KEY_N3
.global KEY_N4
.global KEY_N5
.global KEY_N6
.global KEY_N7
.global KEY_N8
.global KEY_N9
.global KEY_LAK
.global KEY_UAK
.global KEY_DAK
.global KEY_RAK
.global KEY_A
.global KEY_B
.global KEY_C
.global KEY_D
.global KEY_E
.global KEY_F
.global KEY_G
.global KEY_H
.global KEY_I
.global KEY_J
.global KEY_K
.global KEY_L
.global KEY_M
.global KEY_N
.global KEY_O
.global KEY_P
.global KEY_Q
.global KEY_R
.global KEY_S
.global KEY_T
.global KEY_U
.global KEY_V
.global KEY_W
.global KEY_X
.global KEY_Y
.global KEY_Z

; Mouse keys
KEY_LMB equ 01h
KEY_RMB equ 02h

; Special keys
KEY_ESC equ 1Bh
KEY_RTN equ 0Dh
KEY_CTRL equ 11h
KEY_ALT equ 0A3h
KEY_SPC equ 20h
KEY_BKSPC equ 08h
KEY_LSHFT equ 0A0h
KEY_RSHFT equ 0A1h

; Number keys
KEY_0 equ 30h
KEY_1 equ 31h
KEY_2 equ 32h
KEY_3 equ 33h
KEY_4 equ 34h
KEY_5 equ 35h
KEY_6 equ 36h
KEY_7 equ 37h
KEY_8 equ 38h
KEY_9 equ 39h

; Numpad keys
KEY_N0 equ 60h
KEY_N1 equ 61h
KEY_N2 equ 62h
KEY_N3 equ 63h
KEY_N4 equ 64h
KEY_N5 equ 65h
KEY_N6 equ 66h
KEY_N7 equ 67h
KEY_N8 equ 68h
KEY_N9 equ 69h

; Arrow keys
KEY_LAK equ 25h
KEY_UAK equ 26h
KEY_DAK equ 27h
KEY_RAK equ 28h

; Letter keys
KEY_A equ 41h
KEY_B equ 42h
KEY_C equ 43h
KEY_D equ 44h
KEY_E equ 45h
KEY_F equ 46h
KEY_G equ 47h
KEY_H equ 48h
KEY_I equ 49h
KEY_J equ 4Ah
KEY_K equ 4Bh
KEY_L equ 4Ch
KEY_M equ 4Dh
KEY_N equ 4Eh
KEY_O equ 4Fh
KEY_P equ 50h
KEY_Q equ 51h
KEY_R equ 52h
KEY_S equ 53h
KEY_T equ 54h
KEY_U equ 55h
KEY_V equ 56h
KEY_W equ 57h
KEY_X equ 58h
KEY_Y equ 59h
KEY_Z equ 5Ah

.code
main PROC
    ; Possible future code here

    ; Exit the program
    mov rcx, 0
    call ExitProcess
main ENDP

END main ; End of the file