//
//  PCEnemy.h
//  RaysPizza
//
//  Created by pat-keynected on 17/06/2014.
//  Copyright (c) 2014 pizzacat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCMap.h"

// Scout, Dog, and so on
typedef enum {
    EnemyClassOne,
    EnemyClassTwo,
    EnemyClassThree
}EnemyClass;

// Enemies are just state machines. Simple state machines. An enemy cant be Attacking and Retreating at the same time. Well, maybe they COULD but not here.
typedef enum {
    EnemyStatePatrol,
    EnemyStateHunt,
    EnemyStateAttack,
    EnemyStateRetreat,
    EnemyStateStationary,
    EnemyStateDead
}EnemyState;

@interface PCEnemy : NSObject {
    // An enemy has a current position and a target position at all times. Their target position may be == current position, but most times they will have an idea of where they want to go.
    CGPoint currentPosition;
    CGPoint targetPosition;
    
    // direction really only matters for the sprite direction, and sneaking up on things.
    CGPoint direction;
    
    // how quickly the enemy can move, dogs should be faster than the player, heavy should be slower
    double moveSpeed;
    
    // once health gets below 0, state changes to dead
    int health;
    
    // visual range is a cone that extends in front of the enemy.
    /**
     
     x x x x x
     0 x x x 0
     0 0 x 0 0
     0 0 E 0 0 <- where E is the enemy, and 3 is the range, x's are the visual range.
     
     if there is a wall, then the visual range is cut
     1 1 1 x x <- 1 is a wall
     0 x x x 0 <- x is visual range. it is occluded
     0 0 x 0 0
     0 0 E 0 0 <- E is the enemy
     
     **/
    
    // hearing range is a similar thing, but extends in all directions EXCEPT behind the enemy, and is a reverse cone (triangle?)
    /**
     0 0 0 0 0 0 0
     0 0 0 * 0 0 0 <- * is hearing range
     0 0 * * * 0 0
     0 * * E * * 0
     0 0 0 0 0 0 0
     0 0 0 0 0 0 0
     **/
    
    // hearing something shouldnt be the same as seeing something. an enemy still needs visual confirmation. hearing simply changes state to hunt mode
    
    int visualRange;
    int hearingRange;
    
    EnemyState currentState;
    EnemyClass currentClass;
}

-(id)initWithClass:(int)EnemyClass;

// returns amount of health left
-(int)checkHealth;
// change state to something
-(void)setState:(int)EnemyState;

-(void)setStartingLocation:(CGPoint)startingLocation;
-(void)setSpawnTimer:(float)timeToSpawn;

// if hearing of visual return something, then the state changes.
-(BOOL)checkHearing;
-(BOOL)checkVisual;

// all about tracking and tracing and blah
-(CGPoint)findTarget;



@end
