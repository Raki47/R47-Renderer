; ***************************************************************************************************************************************************
; MASM64 BMP Image Loader
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
; 03/06/2024 *
; ************
; - Created a function to load .bmp files
;
; ***************************************************************************************************************************************************


; Constants for BMP error codes
BMP_ERROR_NONE              equ 0
BMP_ERROR_FILE_OPEN         equ -1
BMP_ERROR_READ              equ -2
BMP_ERROR_MEMORY            equ -3

; BMP Header Structure
bmp_file_header STRUCT
    bf_type          WORD    ?
    bf_size          DWORD   ?
    bf_reserved1     WORD    ?
    bf_reserved2     WORD    ?
    bf_off_bits      DWORD   ?
ENDS

bmp_info_header STRUCT
    bi_size          DWORD   ?
    bi_width         LONG    ?
    bi_height        LONG    ?
    bi_planes        WORD    ?
    bi_bit_count     WORD    ?
    bi_compression   DWORD   ?
    bi_size_image    DWORD   ?
    bi_x_pels_per_meter LONG ?
    bi_y_pels_per_meter LONG ?
    bi_clr_used      DWORD   ?
    bi_clr_important DWORD   ?
ENDS

; Function to load a BMP file
load_bmp PROC file_name:LPSTR
    LOCAL file_handle:HANDLE
    LOCAL bytes_read:DWORD
    LOCAL file_header:bmp_file_header
    LOCAL info_header:bmp_info_header
    LOCAL pixel_data:QWORD

    ; Open the BMP file
    invoke CreateFile, file_name, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    mov file_handle, rax
    cmp file_handle, INVALID_HANDLE_VALUE
    je bmp_file_error

    ; Read the BMP file header
    invoke ReadFile, file_handle, addr file_header, SIZEOF bmp_file_header, addr bytes_read, NULL
    cmp bytes_read, SIZEOF bmp_file_header
    jne bmp_read_error

    ; Read the BMP info header
    invoke ReadFile, file_handle, addr info_header, SIZEOF bmp_info_header, addr bytes_read, NULL
    cmp bytes_read, SIZEOF bmp_info_header
    jne bmp_read_error

    ; Allocate memory for the pixel data
    mov rdx, info_header.bi_width
    imul rdx, info_header.bi_height
    imul rdx, info_header.bi_bit_count
    mov rdx, rdx / 8 ; Convert bits to bytes
    invoke HeapAlloc, GetProcessHeap(), 0, rdx
    mov pixel_data, rax
    cmp pixel_data, 0
    je bmp_memory_error

    ; Read the pixel data
    invoke ReadFile, file_handle, pixel_data, rdx, addr bytes_read, NULL
    cmp bytes_read, rdx
    jne bmp_read_error_after_alloc

    ; Close the file
    invoke CloseHandle, file_handle

    ; Return the pointer to the pixel data
    mov rax, pixel_data
    ret

bmp_file_error:
    mov rax, BMP_ERROR_FILE_OPEN
    ret

bmp_read_error:
    invoke CloseHandle, file_handle
    mov rax, BMP_ERROR_READ
    ret

bmp_memory_error:
    invoke CloseHandle, file_handle
    mov rax, BMP_ERROR_MEMORY
    ret

bmp_read_error_after_alloc:
    invoke HeapFree, GetProcessHeap(), 0, pixel_data
    invoke CloseHandle, file_handle
    mov rax, BMP_ERROR_READ
    ret

load_bmp ENDP
