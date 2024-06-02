/*
  ----------------
  | R47_MASM64.H |
  ----------------
  C wrappers and macro imports to avoid name mangling when using content from Assembly In C
*/
/*
Copyright (c) 2024 Filip Rancic

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
*/
/*
 --------------
 | 02/06/2024 |
 --------------
 - Finished Importing Assembly colour Library Into this header to allow use In both languages

*/

// Importing MASM64 colour macro library Into C
extern unsigned long long R47_LIME
extern unsigned long long R47_GHOSTWHITE
extern unsigned long long R47_CYAN
extern unsigned long long R47_ALICEBLUE
extern unsigned long long R47_LIGHTCYAN
extern unsigned long long R47_LAVENDER
extern unsigned long long R47_GAINSBORO
extern unsigned long long R47_LIGHTGREY
extern unsigned long long R47_SILVER
extern unsigned long long R47_GREY
extern unsigned long long R47_DARKLIGHTGREY
extern unsigned long long R47_DARKMIDGREY
extern unsigned long long R47_DARKGREY
extern unsigned long long R47_RAKIGREY
extern unsigned long long R47_BLUEVIOLET
extern unsigned long long R47_DARKVIOLET
extern unsigned long long R47_CRIMSON
extern unsigned long long R47_GOLDENROD
extern unsigned long long R47_DARKGOLDENROD
extern unsigned long long R47_DARKORANGE
extern unsigned long long R47_WHITE
extern unsigned long long R47_SNOW
extern unsigned long long R47_LINEN
extern unsigned long long R47_ANTIQUEWHITE
extern unsigned long long R47_NAVAJOWHITE
extern unsigned long long R47_CADETBLUE
extern unsigned long long R47_STEELBLUE
extern unsigned long long R47_CORNFLOWERBLUE
extern unsigned long long R47_DEEPSKYBLUE
extern unsigned long long R47_DARKTURQUOISE
extern unsigned long long R47_ROYALEBLUE
extern unsigned long long R47_MEDIUMBLUE
extern unsigned long long R47_BLUE
extern unsigned long long R47_DARKBLUE
extern unsigned long long R47_NAVY
extern unsigned long long R47_MIDNIGHTBLUE
extern unsigned long long R47_PURPLE
extern unsigned long long R47_DARKMAGENTA
extern unsigned long long R47_DARKORCHID
extern unsigned long long R47_INDIGO
extern unsigned long long R47_MAGENTA
extern unsigned long long R47_ORCHID
extern unsigned long long R47_MEDIUMORCHID
extern unsigned long long R47_VIOLET
extern unsigned long long R47_LIGHTSALMON
extern unsigned long long R47_LIGHTCORAL
extern unsigned long long R47_LIGHTRED
extern unsigned long long R47_RED
extern unsigned long long R47_DARKRED
extern unsigned long long R47_MAROON
extern unsigned long long R47_ORANGE
extern unsigned long long R47_ORANGERED
extern unsigned long long R47_BURLYWOOD
extern unsigned long long R47_ROSYBROWN
extern unsigned long long R47_TOMATO
extern unsigned long long R47_INDIANRED
extern unsigned long long R47_FIREBRICKRED
extern unsigned long long R47_BROWN
extern unsigned long long R47_SIENNA
extern unsigned long long R47_OLIVE
extern unsigned long long R47_GOLD
extern unsigned long long R47_YELLOW
extern unsigned long long R47_YELLOWGREEN
extern unsigned long long R47_GREENYELLOW
extern unsigned long long R47_GREEN
extern unsigned long long R47_SEAGREEN
extern unsigned long long R47_SPRINGGREEN
extern unsigned long long R47_DARKSEAGREEN
extern unsigned long long R47_DIMGREY
extern unsigned long long R47_BLACK
