//
//  PCEnemy.m
//  RaysPizza
//
//  Created by pat-keynected on 17/06/2014.
//  Copyright (c) 2014 pizzacat. All rights reserved.
//

#import "PCEnemy.h"

@implementation PCEnemy

-(id)initWithClass:(int)EnemyClass {
    self = [super init];
    if (self) {
        currentClass = EnemyClass;
    }
    return self;
}

-(void)setState:(int)EnemyState {
    currentState = EnemyState;
}

-(int)checkHealth {
    return health;
}

-(void)setStartingLocation:(CGPoint)startingLocation {
    currentPosition = startingLocation;
}

-(BOOL)checkHearing {
    // algorithm to check hearing
    return NO;
}

-(BOOL)checkVisual {
    // algorithm to check visual
    return NO;
}

-(CGPoint)findTarget {
    // check visual contact and return position
    CGPoint target = CGPointMake(0,0);
    return target;
}

-(void)setSpawnTimer:(float)timeToSpawn {
    
}


@end
