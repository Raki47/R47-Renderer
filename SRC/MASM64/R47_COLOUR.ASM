; ***************************************************************************************************************************************************
; MASM64 version of the R47 colour library
;
; creating macros of different colour hex codes for easy use when making GUI
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
;
; ADDITIONAL GUI COLOUR DESIGN TIP - You should avoid using pure white or black for making Interfaces,  It'll look far better when you use a slight 
; different shade e.g. swap out white with Azure or WhiteSmoke, swap out black with some form of Dark Grey
;
; ***************************************************************************************************************************************************
; 01/06/2024
; **********
; I have converted from '#RRGGBB' format to '0xRRGGBB' format to ensure that It works now.
;
; To make this file truly good, I will have to expand It, turn all definitions Into globals to be able to use In C, then create a C header that
; Interprets these Assembly definitions. Originally the C header was simple and platform Independant but now It's a little more complex and factors
; In Assembly language
;
; I theorise that this will create extremely subtle performance optimisation, If this proves to be wrong It would not negatively affect performance.
; Regardless of whether It creates barely noticable performance Increases, decreases or no change, It will serve as a good, simple training exercise
; for learning Assembly as I've always wanted to do.
; ***************************************************************************************************************************************************

; File Is now complete but, I may add more colours In the future despite there being plenty, I also will likely turn them Into globals so I can use It In C rather than writing It twice.
.data

; R47 GUI special colours
; In the "special" colours section I have listed colours that stood out to me In particular, whether It's for looking modern, attention grabbing or generally aesthetically pleasing
LIME equ 0x00FF00
GHOSTWHITE equ 0xF8F8FF
; Had to Include cyan as homage to Terry A. Davis. Rest In peace, your contributions to software engineering created despite your significant personal/mental struggles will forever be an Inspiration.
CYAN equ 0x00FFFF
ALICEBLUE equ 0xF0F8FF
LIGHTCYAN equ 0xE0FFFF
LAVENDER equ 0xE6E6FA
GAINSBORO equ 0xDCDCDC
LIGHTGREY equ 0xD3D3D3
SILVER equ 0xC0C0C0
GREY equ 0xA9A9A9
DARKLIGHTGREY equ 0x4D4D4D
DARKMIDGREY equ 0x3B3A3A
DARKGREY equ 0x212121
RAKIGREY equ 0x474747
BLUEVIOLET equ 0x8A2BE2
DARKVIOLET equ 0x9400D3
CRIMSON equ 0xDC143C
GOLDENROD equ 0xDAA520
DARKGOLDENROD equ 0xB8860B
DARKORANGE equ 0xFF8C00

; Basic colours
WHITE equ 0xFFFFFF
SNOW equ 0xFFFAFA
LINEN equ 0xFAF0E6
ANTIQUEWHITE equ 0xFAEBD7
NAVAJOWHITE equ 0xFFDEAD
CADETBLUE equ 0x5F9EA0
STEELBLUE equ 0x4682B4
CORNFLOWERBLUE equ 0x6495ED
DEEPSKYBLUE equ 0x00BFFF
DARKTURQUOISE equ 0x00CED1
ROYALEBLUE equ 0x4169E1
MEDIUMBLUE equ 0x0000CD
BLUE equ 0x0000FF
DARKBLUE equ 0x00008B
NAVY equ 0x000080
MIDNIGHTBLUE equ 0x191970
PURPLE equ 0x800080
DARKMAGENTA equ 0x8B008B
DARKORCHID equ 0x9932CC
INDIGO equ 0x4B0082
MAGENTA equ 0xFF00FF
ORCHID equ 0xDA70D6
MEDIUMORCHID equ 0xBA55D3
VIOLET equ 0xEE82EE
LIGHTSALMON equ 0xFFA07A
LIGHTCORAL equ 0xF08080
LIGHTRED equ 0xFF4040
RED equ 0xFF0000
DARKRED equ 0x8B0000
MAROON equ 0x800000
ORANGE equ 0xFFA500
ORANGERED equ 0xFF4500
BURLYWOOD equ 0xDEB887
ROSYBROWN equ 0xBC8F8F
TOMATO equ 0xFF6347
INDIANRED equ 0xCD5C5C
FIREBRICK equ 0xB22222
BROWN equ 0xA52A2A
SIEANNA equ 0xA0522D
OLIVE equ 0x808000
GOLD equ 0xFFD700
YELLOW equ 0xFFFF00
YELLOWGREEN equ 0x9ACD32
GREENYELLOW equ 0xADEE2E
GREEN equ 0x328032
SEAGREEN equ 0x3CB371
SPRINGGREEN equ 0x00FF7F
DARKSEAGREEN equ 0x8FBC8F
DIMGREY equ 0x696969
BLACK equ 0x000000

; Turning these macros Into globals to also allow for use In C/C++, names are being changed to avoid name mangling

R47_LIME dq LIME
R47_GHOSTWHITE dq GHOSTWHITE
R47_CYAN dq CYAN
R47_ALICEBLUE dq ALICEBLUE
R47_LIGHTCYAN dq LIGHTCYAN
R47_LAVENDER dq LAVENDER
R47_GAINSBORO dq GAINSBORO
R47_LIGHTGREY dq LIGHTGREY
R47_SILVER dq SILVER
R47_GREY dq GREY
R47_DARKLIGHTGREY dq DARKLIGHTGREY
R47_DARKMIDGREY dq DARKMIDGREY
R47_DARKGREY dq DARKGREY
R47_RAKIGREY dq RAKIGREY
R47_BLUEVIOLET dq BLUEVIOLET
R47_DARKVIOLET dq DARKVIOLET
R47_CRIMSON dq CRIMSON
R47_GOLDENROD dq GOLDENROD
R47_DARKGOLDENROD dq DARKGOLDENROD
R47_DARKORANGE dq DARKORANGE
R47_WHITE dq WHITE
R47_SNOW dq SNOW
R47_LINEN dq LINEN
R47_ANTIQUEWHITE dq ANTIQUEWHITE
R47_NAVAJOWHITE dq NAVAJOWHITE
R47_CADETBLUE dq CADETBLUE
R47_STEELBLUE dq STEELBLUE
R47_CORNFLOWERBLUE dq CORNFLOWERBLUE
R47_DEEPSKYBLUE dq DEEPSKYBLUE
R47_DARKTURQOISE dq DARKTURQUOISE
R47_ROYALEBLUE dq ROYALEBLUE
R47_MEDIUMBLUE dq MEDIUMBLUE
R47_BLUE dq BLUE
R47_DARKBLUE dq DARKBLUE
R47_NAVY dq NAVY
R47_MIDNIGHTBLUE dq MIDNIGHTBLUE
R47_PURPLE dq PURPLE
R47_DARKMAGENTA dq DARKMAGENTA
R47_DARKORCHID dq DARKORCHID
R47_INDIGO dq INDIGO
R47_MAGENTA dq MAGENTA
R47_ORCHID dq ORCHID
R47_MEDIUMORCHID dq MEDIUMORCHID
R47_VIOLET dq VIOLET
R47_LIGHTSALMON dq LIGHTSALMON
R47_LIGHTCORAL dq LIGHTCORAL
R47_LIGHTRED dq LIGHTRED
R47_RED dq RED
R47_DARKRED dq DARKRED
R47_MAROON dq MAROON
R47_ORANGE dq ORANGE
R47_ORANGERED dq ORANGERED
R47_BURLYWOOD dq BURLYWOOD
R47_ROSYBROWN dq ROSYBROWN
R47_TOMATO dq TOMATO
R47_INDIANRED dq INDIANRED
R47_FIREBRICKRED dq FIREBRICKRED
R47_BROWN dq BROWN
R47_SIENNA dq SIENNA
R47_OLIVE dq OLIVE
R47_GOLD dq GOLD
R47_YELLOW dq YELLOW
R47_YELLOWGREEN dq YELLOWGREEN
R47_GREENYELLOW dq GREENYELLOW
R47_GREEN dq GREEN
R47_SEAGREAN dq SEAGREEN
R47_SPRINGGREEN dq SPRINGGREEN
R47_DARKSEAGREEM dq DARKSEAGREAN
R47_DIMGREY dq DIMGREY
R47_BLACK dq BLACK

; Here I am creating an empty function because x64 MASM refuses to compile without It unlike MASM32
.code
main PROC

    ; Exit the program
    mov rcx, 0
    call ExitProcess
main ENDP

END main ; End of the file