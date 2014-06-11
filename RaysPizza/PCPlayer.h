//
//  PCPlayer.h
//  Spritekit Raycaster
//
//  Created by pat-keynected on 11/06/2014.
//  Copyright (c) 2014 pizzacat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PlayerTurnLeft,
    PlayerTurnRight,
    PlayerMoveForward,
    PlayerMoveBackward
} PlayerMovement;

@interface PCPlayer : NSObject {
    // Player Movement
    BOOL isMovingForward;
    BOOL isMovingBackward;
    BOOL isTurningLeft;
    BOOL isTurningRight;
    
    // Player/Camera Position and Direction
    CGPoint position;
    CGPoint direction;
    CGPoint plane;
    
    // Player movement, rotation speed
    double moveSpeed;
    double rotSpeed;
}

// Vector getters
-(CGPoint)getPlayerPosition;
-(CGPoint)getPlayerDirection;
-(CGPoint)getPlayerPlane;

// Vector setters
-(void)setPlayerPosition:(CGPoint)point;
-(void)setPlayerDirection:(CGPoint)point;
-(void)setPlayerPlane:(CGPoint)point;

// Movement
//-(void)turnRight;
//-(void)turnLeft;
//-(void)moveForward;
//-(void)moveBackward;

-(void)setMovement:(int)PlayerMovement;
-(void)invalidateMovement;
-(void)pulseMovementControls;

@end
