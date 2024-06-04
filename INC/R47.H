/*
 ---------------------------
 | R47 2D graphics library |
 ---------------------------
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
---------------------------------------------------------------------------------------------------------
READ BEFORE USING LIBRARY:
---------------------------------------------------------------------------------------------------------
This Is the main public header for the R47 renderer, this is the header that you must Include Into your
project to Incorporate It.

If you want to use the Nuklear library for making modern GUI In your project, you must add the 
following code In your file before including this header:
--------------------------
#define R47_WITH_NUKLEAR
#include "INC/R47.H"
--------------------------
The reason for this design choice Is due to Nuklear being a VERY big library which Is only used for GUI,
by stopping It from being Included when unnecessary  It helps with performance optimisation.

---------------------------------------------------------------------------------------------------------
All Library Functions:
---------------------------------------------------------------------------------------------------------
- List of all special macros/variables In R47_MASM64.H
- Continued list of Important functions In R47_MASM64.H

Dependencies:
There are multiple open source dependencies used for this project with Important functions, I am listing
the names of them as they Include fair too many functions to list a second time here, these are
- nuklear.h
- gl.h
- gles2.h
- vulkan.h
- stb_tilemap_editor.h
- tinycthread (This one Isn't as Important to mention but thought It'd be good to mention all regardless)

Continued list of R47 original functions (that're written In C, not Assembly):

---------------------------------------------------------------------------------------------------------

 --------------
 | 02/06/2024 |
 --------------
 - Wrote 2 error directives for the project and Included R47_MASM64.H

 - I decided to write all the file names In full caps as It helps with readability on my end while creating the renderer, I apologise If It
   throws anyone off or causes any annoyances while making your projects with It.
*/
#pragma once // cleaner and simpler than a traditional header gaurd

// ------------------------------------------------------------------------------------------------------
// Simple Error Directives
// ------------------------------------------------------------------------------------------------------
// Checking for some simple Issues that'll stop you from compiling before you can unsuccesfully compile
// ------------------------------------------------------------------------------------------------------

// Must use extern "C" when Including this header If you're making a C++ application
#ifdef __cplusplus
extern "C"
{

// Define a macro to trigger a compilation error
#define REQUIRE_EXTERN_C extern "C" { \
    void extern_c_required(void); \
    } extern "C" void extern_c_required(void)

// Check if REQUIRE_EXTERN_C is defined, if not, trigger an error
#define USING_EXTERN_C
#ifndef USING_EXTERN_C
	#error "You must use extern "C" when including this header in a C++ file."
#endif

}
#endif

// Check If project set to compile for Windows
#define WIN32
#if != WIN32
	#error This library only compiles to Windows!
#endif

// Making sure It's set to x64
#include <stdint.h>

#if INTPTR_MAX == INT32_MAX
	#error This library only works In x64 Architecture! Make sure you haven't set It to x86
#endif

// ------------------------------------------------------------------------------------------------------

#include "R47_MASM64.H"

#ifdef R47_WITH_NUKLEAR
#include "NUKLEAR.H"
#endif

