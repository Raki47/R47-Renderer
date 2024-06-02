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

/*
This Isn't crucial for the renderer to work, I added It because I need C++11 minimum for a future
project of mine. On the odd chance It Interferes with your project you can remove or change It but,
It would be unlikely to see.
*/
#define __cplusplus 201103L

#if __cplusplus < 201103L
	#error "C++11 or higher is required."
#endif

// ------------------------------------------------------------------------------------------------------

#define WIN32
#ifdef WIN32
#ifndef WIN32

#include "R47_MASM64.H"

#endif //!WIN32
