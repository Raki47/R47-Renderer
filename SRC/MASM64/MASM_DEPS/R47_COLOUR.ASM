; ***************************************************************************************************************************************************
; MASM32 version of the R47 colour library
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
; 02/06/2024
; **********
; I must of spent ~6 hours On this colour library, a decent bit hand picking colours but mainly because of how time consuming and repetitive It Is to
; Write a massive list of macros, still wasn't too bad until realising I was going to have to hand write 4 times the amount for It to simaultaneously
; work In C. I really should of wrote It all In C or get AI to automate the task of writing It all down but where's the fun In that! I don't have time
; constraints either so It ultimately was fine to get away with.
;
; ***************************************************************************************************************************************************

.DATA

; R47 GUI special colours
; In the "special" colours section I have listed colours that stood out to me In particular, whether It's for looking modern, attention grabbing or generally aesthetically pleasing
LIME equ 0x00FF00
GHOSTWHITE equ 0xF8F8FF
; Had to Include cyan as homage to Terry A. Davis. Rest In peace, your contributions to software engineering created despite your significant personal/mental struggles will forever be an Inspiration.
CYAN EQU 0x00FFFF
ALICEBLUE EQU 0xF0F8FF
LIGHTCYAN EQU 0xE0FFFF
LAVENDER EQU 0xE6E6FA
GAINSBORO EQU 0xDCDCDC
LIGHTGREY EQU 0xD3D3D3
SILVER EQU 0xC0C0C0
GREY EQU 0xA9A9A9
DARKLIGHTGREY EQU 0x4D4D4D
DARKMIDGREY EQU 0x3B3A3A
DARKGREY EQU 0x212121
RAKIGREY EQU 0x474747
BLUEVIOLET EQU 0x8A2BE2
DARKVIOLET EQU 0x9400D3
CRIMSON EQU 0xDC143C
GOLDENROD EQU 0xDAA520
DARKGOLDENROD EQU 0xB8860B
DARKORANGE EQU 0xFF8C00

; Basic colours
WHITE EQU 0xFFFFFF
SNOW EQU 0xFFFAFA
LINEN EQU 0xFAF0E6
ANTIQUEWHITE EQU 0xFAEBD7
NAVAJOWHITE EQU 0xFFDEAD
CADETBLUE EQU 0x5F9EA0
STEELBLUE EQU 0x4682B4
CORNFLOWERBLUE EQU 0x6495ED
DEEPSKYBLUE EQU 0x00BFFF
DARKTURQUOISE EQU 0x00CED1
ROYALEBLUE EQU 0x4169E1
MEDIUMBLUE EQU 0x0000CD
BLUE EQU 0x0000FF
DARKBLUE EQU 0x00008B
NAVY EQU 0x000080
MIDNIGHTBLUE EQU 0x191970
PURPLE EQU 0x800080
DARKMAGENTA EQU 0x8B008B
DARKORCHID EQU 0x9932CC
INDIGO EQU 0x4B0082
MAGENTA EQU 0xFF00FF
ORCHID EQU 0xDA70D6
MEDIUMORCHID EQU 0xBA55D3
VIOLET EQU 0xEE82EE
LIGHTSALMON EQU 0xFFA07A
LIGHTCORAL EQU 0xF08080
LIGHTRED EQU 0xFF4040
RED EQU 0xFF0000
DARKRED EQU 0x8B0000
MAROON EQU 0x800000
ORANGE EQU 0xFFA500
ORANGERED EQU 0xFF4500
BURLYWOOD EQU 0xDEB887
ROSYBROWN EQU 0xBC8F8F
TOMATO EQU 0xFF6347
INDIANRED EQU 0xCD5C5C
FIREBRICKRED EQU 0xB22222
BROWN EQU 0xA52A2A
SIENNA EQU 0xA0522D
OLIVE EQU 0x808000
GOLD EQU 0xFFD700
YELLOW EQU 0xFFFF00
YELLOWGREEN EQU 0x9ACD32
GREENYELLOW EQU 0xADEE2E
GREEN EQU 0x328032
SEAGREEN EQU 0x3CB371
SPRINGGREEN EQU 0x00FF7F
DARKSEAGREEN EQU 0x8FBC8F
DIMGREY EQU 0x696969
BLACK EQU 0x000000

END ; End of file
