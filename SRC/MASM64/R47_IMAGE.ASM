; ***************************************************************************************************************************************************
; MASM64 Image handling system
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
; 07/05/2024 *
; ************
; - Created a function to load Targa (.tga) files with help from 'ChatGPT 3.5'
;
; ***************************************************************************************************************************************************

; Constants for TGA image types
TGA_TYPE_NO_IMAGE           equ 0
TGA_TYPE_INDEXED_COLOR      equ 1
TGA_TYPE_RGB_COLOR          equ 2
TGA_TYPE_GRAYSCALE          equ 3
TGA_TYPE_RLE_INDEXED_COLOR  equ 9
TGA_TYPE_RLE_RGB_COLOR      equ 10
TGA_TYPE_RLE_GRAYSCALE      equ 11

; Constants for TGA error codes
TGA_ERROR_NONE              equ 0
TGA_ERROR_FILE_OPEN         equ -1
TGA_ERROR_READ              equ -2

; TGA Header Structure
TGA_HEADER STRUCT
    idLength        BYTE    ?
    colorMapType    BYTE    ?
    imageType       BYTE    ?
    colorMapSpec    STRUCT
        firstEntryIndex WORD ?
        colorMapLength  WORD ?
        colorMapEntrySize BYTE ?
    ENDS
    imageSpec       STRUCT
        xOrigin         WORD ?
        yOrigin         WORD ?
        width           WORD ?
        height          WORD ?
        bitsPerPixel    BYTE ?
        imageDescriptor BYTE ?
    ENDS
ENDS

; Function to load a TGA file
LoadTGA PROC fileName:LPSTR
    LOCAL fileHandle:HANDLE
    LOCAL bytesRead:DWORD
    LOCAL header:TGA_HEADER
    LOCAL pixelData:DWORD_PTR

    ; Open the TGA file
    invoke CreateFile, fileName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    mov fileHandle, rax
    cmp fileHandle, INVALID_HANDLE_VALUE
    je FileError

    ; Read the TGA header
    invoke ReadFile, fileHandle, addr header, SIZEOF TGA_HEADER, addr bytesRead, NULL
    cmp bytesRead, SIZEOF TGA_HEADER
    jne ReadError

    ; Allocate memory for the pixel data
    mov rdx, header.imageSpec.width
    imul rdx, header.imageSpec.height
    imul rdx, header.imageSpec.bitsPerPixel
    mov rdx, rdx / 8 ; Convert bits to bytes
    invoke HeapAlloc, GetProcessHeap(), 0, rdx
    mov pixelData, rax

    ; Read the pixel data
    invoke ReadFile, fileHandle, pixelData, rdx, addr bytesRead, NULL
    cmp bytesRead, rdx
    jne ReadError

    ; Close the file
    invoke CloseHandle, fileHandle

    ret

FileError:
    ; Handle file open error
    ret

ReadError:
    ; Handle read error
    ret

LoadTGA ENDP
