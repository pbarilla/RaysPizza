//
//  PCPlayer.m
//  Spritekit Raycaster
//
//  Created by pat-keynected on 11/06/2014.
//  Copyright (c) 2014 pizzacat. All rights reserved.
//

#import "PCPlayer.h"

@implementation PCPlayer

-(id)init {
    self = [super init];
    if (self) {
        position = CGPointMake(5, 5);
        direction = CGPointMake(-1, 0);
        plane = CGPointMake(0, 0.66);
        moveSpeed = 0.3 * 5.0;
        rotSpeed = 0.0002 * 3.0;
        
        [self invalidateMovement];
    }
    return self;
}

-(void)invalidateMovement {
    isMovingBackward = 0;
    isMovingForward = 0;
    isTurningLeft = 0;
    isTurningRight = 0;
}

-(void)pulseMovementControls {
    [self turnLeft];
    [self turnRight];
    [self moveBackward];
    [self moveForward];
}

-(void)setMovement:(int)PlayerMovement byValidatingWithMap:(PCMap *)map{
    switch (PlayerMovement) {
        case PlayerTurnLeft: {
            isTurningLeft = 1;
            isTurningRight = 0;
            break;
        }
        case PlayerTurnRight: {
            isTurningRight = 1;
            isTurningLeft = 0;
            break;
        }
        case PlayerMoveForward: {
            if ([self checkForCollisonMoving:PlayerMoveForward withMap:map]) {
                isMovingForward = 1;
                isMovingBackward = 0;
                isTurningLeft = 0;
                isTurningRight = 0;
            } else {
                isMovingForward = 0;
                isMovingBackward = 0;
                isTurningLeft = 0;
                isTurningRight = 0;
            }
            
            break;
        }
        case PlayerMoveBackward: {
            if ([self checkForCollisonMoving:PlayerMoveBackward withMap:map]) {
                isMovingForward = 0;
                isMovingBackward = 1;
                isTurningLeft = 0;
                isTurningRight = 0;
            } else {
                isMovingForward = 0;
                isMovingBackward = 0;
                isTurningLeft = 0;
                isTurningRight = 0;
            }
            
            break;
        }
        default: {
            break;
        }
    }
}

/**
 doesnt quite work yet
 
 say the map runs like this:
 
 1 1 1 1 1
 1       1
 1       1
 1       1
 1 *     1
 
 where * is our player. If they are running along side the wall at a slight angle, then eventually they will 
 overlap the wall like so:
 
 1      1       1
 1      1       1
 1  *   1*      *
 
 When that happens, it crashes because of course it will crash. 
 so we need to check the positions north, south, east and west of the player before allowing the player to move, and
 probably check NE, SE, NW, SW also
 
 NW NO NE       to do this we should take the map, and move the player direction as follows.
 WE ** EA       ** = (5,5), NO = (5,4), NE = (6,4), EA = (6,5), SE = (6, 6), SO = (5,6), SW = (4,6), WE = (4,5), NW = (4,4)
 SW SO SE
  
**/

-(BOOL)checkForCollisonMoving:(int)PlayerMovement withMap:(PCMap *)map {
    switch (PlayerMovement) {
        case PlayerMoveForward: {
            CGPoint potentialNewPosition = CGPointMake(position.x, position.y);
            potentialNewPosition.x += direction.x * 2;
            potentialNewPosition.y += direction.y * 2;
            
            int testMap = [map valueForPoint:potentialNewPosition];
            if (testMap == 0) {
                return YES;
            } else {
                return NO;
            }
            
            break;
        }
        case PlayerMoveBackward: {
            CGPoint potentialNewPosition = CGPointMake(position.x, position.y);
            potentialNewPosition.x -= direction.x * 2;
            potentialNewPosition.y -= direction.y * 2;
            
            int testMap = [map valueForPoint:potentialNewPosition];
            if (testMap == 0) {
                return YES;
            } else {
                return NO;
            }
            break;
        }
    }
    return NO;
}

-(void)turnRight {
    if (isTurningRight == 1) {
        //both camera direction and camera plane must be rotated
        double existingDirX = direction.x;
        direction.x = direction.x * cos(rotSpeed) - direction.y * sin(rotSpeed);
        direction.y = existingDirX * sin(rotSpeed) + direction.y * cos(rotSpeed);
        double existingPlaneX = plane.x;
        plane.x = plane.x * cos(rotSpeed) - plane.y * sin(rotSpeed);
        plane.y = existingPlaneX * sin(rotSpeed) + plane.y * cos(rotSpeed);
    }
}

-(void)turnLeft {
    if (isTurningLeft == 1) {
        //both camera direction and camera plane must be rotated
        double existingDirX = direction.x;
        direction.x = direction.x * cos(-rotSpeed) - direction.y * sin(-rotSpeed);
        direction.y = existingDirX * sin(-rotSpeed) + direction.y * cos(-rotSpeed);
        double existingPlaneX = plane.x;
        plane.x = plane.x * cos(-rotSpeed) - plane.y * sin(-rotSpeed);
        plane.y = existingPlaneX * sin(-rotSpeed) + plane.y * cos(-rotSpeed);
    }
}

-(void)moveForward {
    if (isMovingForward == 1) {
        // increase the last number to increase the movement speed
        position.x += direction.x * 0.001;
        position.y += direction.y * 0.001;
    }
}

-(void)moveBackward {
    if (isMovingBackward == 1) {
        // increase the last number to increase the movement speed
        position.x -= direction.x * 0.001;
        position.y -= direction.y * 0.001;
    }
}

-(CGPoint)getPlayerPosition {
    return position;
}
-(CGPoint)getPlayerDirection {
    return direction;
}
-(CGPoint)getPlayerPlane {
    return plane;
}

-(void)setPlayerPosition:(CGPoint)point {
    
}
-(void)setPlayerDirection:(CGPoint)point {
    
}
-(void)setPlayerPlane:(CGPoint)point {
    
}


@end
