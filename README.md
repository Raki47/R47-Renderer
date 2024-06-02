# R47-Renderer
A simple renderer that I'm creating for my own game engines, It's designed differently to the R47 Renderer being used In B-League Football as I wasn't quite happy with It's development direction. I wasn't personally fond of
choosing to Incorporate GLFW Into my renderer, It consists of so many files making It hard to track what I need to add to the renderer and what GLFW already provides. That Is why I'm having another go at creating a renderer,
this time ensuring maximum modularity/customisation for myself and minimising the risk of bloat and conflicting libraries by sticking purely to writing my own code and Incorporating single header libraries.

<i>Development Notes/Plans</i>
For now In the early stages of development I am focusing on making the renderer built for top down 2D games, It will use the OpenGL API followed by adding Vulkan support to ensure It's capable of being cross-platform If
required. I will create matrix functions to allow for stuff such as seemless side scrolling, support for loading TGA, BMP and TIF files as I believe those are the best 3 for game development, It's unnecessary and general
bad practice to use file types such as PNG and JPEG for game development. The renderer will be heavily oriented towards Windows but will support macOS at one point due to B-League Football requiring It (macOS support will
most likely abandoned afterwards as It's too difficult to be worthwhile If It wasn't for being a requirement for one specific project). I consider adding Linux and Android support; Linux because Visual Studio has tools
that simplify cross-compiling for It, Android as I have already begun work on Android games that had to be stopped due to the drama with Unity, I have already created a Google Developer account so It's too late to turn
back on It.

In the later stages of developing the renderer, I would like to give It 3D capabilities to make It multipurpose rather than creating a seperate renderer for my future 3D game engines. After adding 3D functionality I could
also allow for It to use the DirectX 11 API, although I likely won't as I Imagine It would create the same Issues GLFW made for me to a more severe degree.

<i>Programming languages used, how It's compiled and why</i>
It will be compiled Into a static library just as the original R47 renderer does, I believe static libraries are the best choice for anything graphics related as It's not something that will be loaded and unloaded at
random, from the second the game launches till the second you close It (or It crashs) graphics will be used without break, making It the better of two choices. I'm still sticking to the procedural programming style as
my phylosophy Is that procedural programming makes the most sense/most Intuitive when you're working along side hardware while OOP only helps conceptualise game logic and In game entities. It Is being written In:
-C
-Assembly
C Is one of the easier to read and write programming languages while also being one of the most performance efficent and the mother of most modern programming languages (allowing for scripting languages to be imbedded
as simply as possible If ever need be). Assembly Is quite difficult to write, but given that I only use MASM64 and write It to not depend on libraries, It will not affect the level of difficulty required to compile the
project. Most of the Assembly I write will likely not have any significant performance Improvement as It will be written as readable as possible but gives uses even more modularity then you'd get with C, any user who Is
better at Assembly than me will be able to alter It, create shortcuts that create significant performance Increases at the expense of readability becoming even worse than It was. It also would add onto the currently small
amount of open source resources to help with learning Assembly language.
