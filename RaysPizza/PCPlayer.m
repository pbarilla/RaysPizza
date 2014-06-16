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
        moveSpeed = 0.001;
        rotSpeed = 0.0002 * 3.0;
        
        [self invalidateMovement];
    }
    return self;
}

// impliment this correctly herp derp
-(id)initAsPlayer:(int)playerConfiguration {
    self = [super init];
    if (self) {
        // set unique configurations for player based on configuration
        switch (playerConfiguration) {
            case PlayerConfigurationOne: {
                // do something
                break;
            }
            case PlayerConfigurationTwo: {
                // do something
                break;
            }
            default: {
                break;
            }
        }
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
    // the problem here is the map must be immutable, aka cannot change.
    if (!_currentMap) {
        _currentMap = map;
    }
    
    switch (PlayerMovement) {
            
        case PlayerTurnLeft: {
            [self makePlayerTurnLeft];
            break;
        }
            
        case PlayerTurnRight: {
            [self makePlayerTurnRight];
            break;
        }
            
        case PlayerMoveForward: {
            [self makePlayerMoveForward];
            break;
        }
            
        case PlayerMoveBackward: {
            [self makePlayerMoveBackward];
            break;
        }
            
        default: {
            break;
        }
            
    }
}

-(void)makePlayerTurnLeft {
    isTurningLeft = 1;
    isTurningRight = 0;
}

-(void)makePlayerTurnRight {
    isTurningRight = 1;
    isTurningLeft = 0;
}

-(void)makePlayerMoveForward {
    isMovingForward = 1;
    isMovingBackward = 0;
    isTurningLeft = 0;
    isTurningRight = 0;
}

-(void)makePlayerMoveBackward {
    isMovingForward = 0;
    isMovingBackward = 1;
    isTurningLeft = 0;
    isTurningRight = 0;
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
        
        if ([self willNotCollideGoingForwardXCoord]) {
            position.x += direction.x * moveSpeed;
        }
        if ([self willNotCollideGoingForwardYCoord]) {
            position.y += direction.y * moveSpeed;
        }
    }
}

-(void)moveBackward {
    if (isMovingBackward == 1) {
        // increase the last number to increase the movement speed
        if ([self willNotCollideGoingBackwardXCoord]) {
            position.x -= direction.x * moveSpeed;
        }
        if ([self willNotCollideGoingBackwardYCoord]) {
            position.y -= direction.y * moveSpeed;
        }
    }
}

-(BOOL)willNotCollideGoingForwardXCoord {
    // NO = will collide
    // YES = will not collide (aka OKAY to move)
    CGPoint testForwardX = CGPointMake(position.x + direction.x * moveSpeed, position.y);
    int potentialPosition = [self.currentMap valueForPoint:testForwardX];
    if (potentialPosition == 0) {
        return YES;
    }
    return NO;
}

-(BOOL)willNotCollideGoingForwardYCoord {
    // NO = will collide
    // YES = will not collide (aka OKAY to move)
    CGPoint testForwardY = CGPointMake(position.x, position.y + direction.y * moveSpeed);
    int potentialPosition = [self.currentMap valueForPoint:testForwardY];
    if (potentialPosition == 0) {
        return YES;
    }
    return NO;
}

-(BOOL)willNotCollideGoingBackwardXCoord {
    // NO = will collide
    // YES = will not collide (aka OKAY to move)
    CGPoint testBackwardX = CGPointMake(position.x - direction.x * moveSpeed, position.y);
    int potentialPosition = [self.currentMap valueForPoint:testBackwardX];
    if (potentialPosition == 0) {
        return YES;
    }
    return NO;
}

-(BOOL)willNotCollideGoingBackwardYCoord {
    // NO = will collide
    // YES = will not collide (aka OKAY to move)
    CGPoint testBackwardY = CGPointMake(position.x, position.y - direction.y * moveSpeed);
    int potentialPosition = [self.currentMap valueForPoint:testBackwardY];
    if (potentialPosition == 0) {
        return YES;
    }
    return NO;
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
    position = point;
}
-(void)setPlayerDirection:(CGPoint)point {
    direction = point;
}
-(void)setPlayerPlane:(CGPoint)point {
    plane = point;
}


@end
