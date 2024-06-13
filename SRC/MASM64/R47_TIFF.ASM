; ***************************************************************************************************************************************************
; MASM64 TIFF Image Loader
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
; - Created a function to load .tif/.tiff files
;
; ***************************************************************************************************************************************************


; Constants for TIFF error codes
TIFF_ERROR_NONE              equ 0
TIFF_ERROR_FILE_OPEN         equ -1
TIFF_ERROR_READ              equ -2
TIFF_ERROR_MEMORY            equ -3

; TIFF Header Structure
tiff_header STRUCT
    endian_flag      WORD    ?
    magic_number     WORD    ?
    ifd_offset       DWORD   ?
ENDS

; Function to load a TIFF file
load_tiff PROC file_name:LPSTR
    LOCAL file_handle:HANDLE
    LOCAL bytes_read:DWORD
    LOCAL header:tiff_header
    LOCAL pixel_data:QWORD
    LOCAL image_width:DWORD
    LOCAL image_height:DWORD
    LOCAL bits_per_sample:WORD

    ; Open the TIFF file
    invoke CreateFile, file_name, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    mov file_handle, rax
    cmp file_handle, INVALID_HANDLE_VALUE
    je tiff_file_error

    ; Read the TIFF header
    invoke ReadFile, file_handle, addr header, SIZEOF tiff_header, addr bytes_read, NULL
    cmp bytes_read, SIZEOF tiff_header
    jne tiff_read_error

    ; Read image dimensions and bits per sample (simplified, actual TIFF reading is more complex)
    ; In a real implementation, you'd parse the IFD (Image File Directory) entries to get these values
    ; Here we assume some fixed values for simplicity
    mov image_width, 800
    mov image_height, 600
    mov bits_per_sample, 24

    ; Allocate memory for the pixel data
    mov rdx, image_width
    imul rdx, image_height
    imul rdx, bits_per_sample
    mov rdx, rdx / 8 ; Convert bits to bytes
    invoke HeapAlloc, GetProcessHeap(), 0, rdx
    mov pixel_data, rax
    cmp pixel_data, 0
    je tiff_memory_error

    ; Read the pixel data (assuming a fixed offset and size for simplicity)
    ; In a real implementation, you'd need to read from the correct offset based on the IFD entries
    mov rcx, header.ifd_offset
    add rcx, 8 ; Skip the first 8 bytes of the IFD
    invoke SetFilePointer, file_handle, rcx, NULL, FILE_BEGIN
    invoke ReadFile, file_handle, pixel_data, rdx, addr bytes_read, NULL
    cmp bytes_read, rdx
    jne tiff_read_error_after_alloc

    ; Close the file
    invoke CloseHandle, file_handle

    ; Return the pointer to the pixel data
    mov rax, pixel_data
    ret

tiff_file_error:
    mov rax, TIFF_ERROR_FILE_OPEN
    ret

tiff_read_error:
    invoke CloseHandle, file_handle
    mov rax, TIFF_ERROR_READ
    ret

tiff_memory_error:
    invoke CloseHandle, file_handle
    mov rax, TIFF_ERROR_MEMORY
    ret

tiff_read_error_after_alloc:
    invoke HeapFree, GetProcessHeap(), 0, pixel_data
    invoke CloseHandle, file_handle
    mov rax, TIFF_ERROR_READ
    ret

load_tiff ENDP
