/*
  -----------
  | R47.HPP |
  -----------
  Include file created solely to simplify linking to R47 from a C++ project
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
// ------------------------------------------------------------------------------------------------------
// MUST READ SETTINGS NOTICE (line 40) BEFORE USAGE
// ------------------------------------------------------------------------------------------------------

// I much prefer '#pragma once' over standard header guards, works with virtually every modern compiler depsite not being standard and makes the
// file less prone to confusing the IDE when adding and modifying any defines, directives and conditonal compilation segments.
#pragma once

// ------------------------------------------------------------------------------------------------------
// Error Directives (C++ specific)
// ------------------------------------------------------------------------------------------------------
// C++ 2011 Required due to the ECS library
#define __cplusplus 201103L

#if __cplusplus < 201103L
	#error "C++11 or higher is required."
#endif

// ------------------------------------------------------------------------------------------------------
// Project Includes - altered for use specifically In C++ 
// ------------------------------------------------------------------------------------------------------
// Below the first Include you'll see multiple settings to choose from for Including the Entity 
// Component System (ECS.h, https://github.com/redxdev/ECS). I recommend using the link to see the file
// and It's settings from the the first settings section from the file (I say to use the link under the
// assumption you're reading this after starting a project with a precompiled version of R47 and/or want
// to see It's README for maximum Info). Afterwards you should adjust the code within R47_ECS_2 to
// adjust It's settings to what best suits your project.
// ------------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------
// | R47_ECS_0 - R47 without ECS.HPP Included                             |
// ------------------------------------------------------------------------
#ifdef R47_ECS_0

extern "C"
{
#include "R47.H"
}

#endif //!R47_CPP

// ------------------------------------------------------------------------
// | R47_ECS_1 - R47 my barebones ECS.HPP settings                        |
// ------------------------------------------------------------------------
#ifdef R47_ECS_1

extern "C"
{
#include "R47.H"
}

#define ECS_TICK_NO_CLEANUP
#include "ECS.HPP"

#endif //!R47_ECS_1

// ------------------------------------------------------------------------
// | R47_ECS_2 - Template for customising ECS.HPP settings for your needs |
// ------------------------------------------------------------------------
#ifdef R47_ECS_2

extern "C"
{
#include "R47.H"
}

// Define your desired settings below this comment

// But above this Include
#include "ECS.HPP"

#endif //!R47_ECS_2

// ------------------------------------------------------------------------------------------------------
