RaysPizza
=========

A (very basic) raycasting engine for iOS. RAYcasting. RaysPizza. Pizza cat. Get it? (At least I thought it was clever)
It uses SpriteKit to draw line segments. For not, at least. 

###working
- Loading maps from files
- Untextured rendering of maps
- Turns iPhone into a hand warmer when in use ;-)
- Movement

##todo
- Use a better way of drawing
- Textures
- Collision Detection
- Sprites (pickups, enemies)
- Network stuff
- Map Editor

##making maps
Maps are simply line seperated arrays. To make a map of a small room, make a pcmap file like:
``` c
1,1,1,1,1
1,0,0,0,1
1,0,0,0,1
1,0,0,0,1
1,1,1,1,1

```
Then load it with:
```objc
PCMap *map = [[PCMap alloc]init];
[map loadMap:@"mapname"]; // make sure the file has the extension .pcmap
```
##Movement
Right now its just tapping the edges of the display to move around.

##Thanks
The giants upon whose shoulders I have stood:
* http://lodev.org/cgtutor/
* http://www.permadi.com/tutorial/raycast/
* http://www.fabiensanglard.net/wolf3d/index.php
* https://github.com/id-Software/wolf3d


##License

The MIT License (MIT)

Copyright (c) 2014 Pasquale Barilla

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
