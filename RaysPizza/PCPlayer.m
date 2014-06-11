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

-(void)setMovement:(int)PlayerMovement {
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
            isMovingForward = 1;
            isMovingBackward = 0;
            isTurningLeft = 0;
            isTurningRight = 0;
            break;
        }
        case PlayerMoveBackward: {
            isMovingForward = 0;
            isMovingBackward = 1;
            isTurningLeft = 0;
            isTurningRight = 0;
            break;
        }
        default: {
            break;
        }
    }
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


@end
