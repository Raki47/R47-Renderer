; ***************************************************************************************************************************************************
; MASM64 Image Handling Universal
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
; - I forgot to add a way to clear/unload Images after loading It, I am doing It here so that It's written once for use with all Image types.
;
; ***************************************************************************************************************************************************

section .text
    extern  GetProcessHeap
    extern  HeapFree

    global free_image_data

free_image_data:
    ; Function to free allocated memory
    ; RDI: pointer to the memory to free
    mov rcx, rdi               ; rcx = pointer to memory
    call GetProcessHeap        ; rax = handle to the process heap
    mov rdx, rax               ; rdx = handle to the process heap
    mov rcx, rdi               ; rcx = pointer to memory
    xor r8, r8                 ; flags = 0
    call HeapFree
    ret
free_image_data endp
