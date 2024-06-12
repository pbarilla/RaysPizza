//
//  PCPlayer.h
//  RaysPizza
//
//  Created by Pat on 11/06/2014.
//  LMAO do whatever you want.
//

#import <Foundation/Foundation.h>
#import "PCMap.h"

typedef enum {
    PlayerTurnLeft,
    PlayerTurnRight,
    PlayerMoveForward,
    PlayerMoveBackward
} PlayerMovement;

// Player config 1 and 2 (and whatever) allows you to "choose a player" which has different
// heights, movement speed, etc
// (think ROTT, etc)
typedef enum {
    PlayerConfigurationOne,
    PlayerConfigurationTwo
} PlayerConfig;

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

-(id)initAsPlayer:(int)playerConfiguration;

// Vector getters
-(CGPoint)getPlayerPosition;
-(CGPoint)getPlayerDirection;
-(CGPoint)getPlayerPlane;

// Vector setters
-(void)setPlayerPosition:(CGPoint)point;
-(void)setPlayerDirection:(CGPoint)point;
-(void)setPlayerPlane:(CGPoint)point;
-(void)setMovement:(int)PlayerMovement;
-(void)invalidateMovement;
-(void)pulseMovementControls;

@end
