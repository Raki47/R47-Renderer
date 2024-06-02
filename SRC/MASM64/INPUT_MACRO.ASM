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

section .data

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
KEY_LMB dq 01h
KEY_RMB dq 02h

; Special keys
KEY_ESC dq 1Bh
KEY_RTN dq 0Dh
KEY_CTRL dq 11h
KEY_ALT dq 0A3h
KEY_SPC dq 20h
KEY_BKSPC dq 08h
KEY_LSHFT dq 0A0h
KEY_RSHFT dq 0A1h

; Number keys
KEY_0 dq 30h
KEY_1 dq 31h
KEY_2 dq 32h
KEY_3 dq 33h
KEY_4 dq 34h
KEY_5 dq 35h
KEY_6 dq 36h
KEY_7 dq 37h
KEY_8 dq 38h
KEY_9 dq 39h

; Numpad keys
KEY_N0 dq 60h
KEY_N1 dq 61h
KEY_N2 dq 62h
KEY_N3 dq 63h
KEY_N4 dq 64h
KEY_N5 dq 65h
KEY_N6 dq 66h
KEY_N7 dq 67h
KEY_N8 dq 68h
KEY_N9 dq 69h

; Arrow keys
KEY_LAK dq 25h
KEY_UAK dq 26h
KEY_DAK dq 27h
KEY_RAK dq 28h

; Letter keys
KEY_A dq 41h
KEY_B dq 42h
KEY_C dq 43h
KEY_D dq 44h
KEY_E dq 45h
KEY_F dq 46h
KEY_G dq 47h
KEY_H dq 48h
KEY_I dq 49h
KEY_J dq 4Ah
KEY_K dq 4Bh
KEY_L dq 4Ch
KEY_M dq 4Dh
KEY_N dq 4Eh
KEY_O dq 4Fh
KEY_P dq 50h
KEY_Q dq 51h
KEY_R dq 52h
KEY_S dq 53h
KEY_T dq 54h
KEY_U dq 55h
KEY_V dq 56h
KEY_W dq 57h
KEY_X dq 58h
KEY_Y dq 59h
KEY_Z dq 5Ah

.code
main PROC
    ; Possible future code here

    ; Exit the program
    mov rcx, 0
    call ExitProcess
main ENDP

END main ; End of the file
