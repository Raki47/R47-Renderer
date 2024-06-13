.386
.model flat, stdcall
option casemap:none

include windows.inc
include user32.inc
include kernel32.inc
includelib masm32\lib\user32.lib
includelib masm32\lib\kernel32.lib

.DATA
ClassName db "SimpleWindowClass",0
AppName db "Simple Window Manager",0

.DATA?
hInstance HINSTANCE ?
hWnd HWND ?

.CODE
start:
    ; Get the instance handle
    invoke GetModuleHandle, NULL
    mov hInstance, eax

    ; Register the window class
    invoke RegisterClassEx, ADDR wc
    test eax, eax
    jz end_program

    ; Create the window
    invoke CreateWindowEx, NULL, ADDR ClassName, ADDR AppName, WS_OVERLAPPEDWINDOW,
                          CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
                          NULL, NULL, hInstance, NULL
    mov hWnd, eax
    test hWnd, hWnd
    jz end_program

    ; Show and update the window
    invoke ShowWindow, hWnd, SW_SHOWNORMAL
    invoke UpdateWindow, hWnd

    ; Enter the message loop
msg_loop:
    invoke GetMessage, ADDR msg, NULL, 0, 0
    test eax, eax
    jz end_program
    invoke TranslateMessage, ADDR msg
    invoke DispatchMessage, ADDR msg
    jmp msg_loop

end_program:
    invoke ExitProcess, 0

; Window procedure to handle messages
WndProc PROC hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    .IF uMsg == WM_DESTROY
        invoke PostQuitMessage, 0
    .ELSE
        invoke DefWindowProc, hWnd, uMsg, wParam, lParam
        ret
    .ENDIF
    xor eax, eax
    ret
WndProc ENDP

.DATA
wc WNDCLASSEX <SIZEOF WNDCLASSEX, CS_HREDRAW or CS_VREDRAW, OFFSET WndProc, 0, 0, NULL, NULL, NULL, COLOR_WINDOW+1, NULL, ADDR ClassName, NULL>
msg MSG <>

END start
