RaysPizza
=========

A (very basic) raycasting engine for iOS
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