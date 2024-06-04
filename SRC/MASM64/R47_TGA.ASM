; ***************************************************************************************************************************************************
; MASM64 Targa Image Loader
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
TGA_ERROR_MEMORY            equ -3

; TGA Header Structure
tga_header STRUCT
    id_length        BYTE    ?
    color_map_type   BYTE    ?
    image_type       BYTE    ?
    color_map_spec    STRUCT
        first_entry_index WORD ?
        color_map_length  WORD ?
        color_map_entry_size BYTE ?
    ENDS
    image_spec       STRUCT
        x_origin         WORD ?
        y_origin         WORD ?
        width           WORD ?
        height          WORD ?
        bits_per_pixel  BYTE ?
        image_descriptor BYTE ?
    ENDS
ENDS

; Function to load a TGA file
load_tga PROC file_name:LPSTR
    LOCAL file_handle:HANDLE
    LOCAL bytes_read:DWORD
    LOCAL header:tga_header
    LOCAL pixel_data:QWORD

    ; Open the TGA file
    invoke CreateFile, file_name, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    mov file_handle, rax
    cmp file_handle, INVALID_HANDLE_VALUE
    je file_error

    ; Read the TGA header
    invoke ReadFile, file_handle, addr header, SIZEOF tga_header, addr bytes_read, NULL
    cmp bytes_read, SIZEOF tga_header
    jne read_error

    ; Allocate memory for the pixel data
    mov rdx, header.image_spec.width
    imul rdx, header.image_spec.height
    imul rdx, header.image_spec.bits_per_pixel
    mov rdx, rdx / 8 ; Convert bits to bytes
    invoke HeapAlloc, GetProcessHeap(), 0, rdx
    mov pixel_data, rax
    cmp pixel_data, 0
    je memory_error

    ; Read the pixel data
    invoke ReadFile, file_handle, pixel_data, rdx, addr bytes_read, NULL
    cmp bytes_read, rdx
    jne read_error_after_alloc

    ; Close the file
    invoke CloseHandle, file_handle

    ; Return the pointer to the pixel data
    mov rax, pixel_data
    ret

file_error:
    mov rax, TGA_ERROR_FILE_OPEN
    ret

read_error:
    invoke CloseHandle, file_handle
    mov rax, TGA_ERROR_READ
    ret

memory_error:
    invoke CloseHandle, file_handle
    mov rax, TGA_ERROR_MEMORY
    ret

read_error_after_alloc:
    invoke HeapFree, GetProcessHeap(), 0, pixel_data
    invoke CloseHandle, file_handle
    mov rax, TGA_ERROR_READ
    ret

load_tga ENDP
