//
//  PCScene.m
//  RaysPizza
//
//  Created by pat on 11/06/2014.
//  Copyright (c) 2014 pizzacat. All rights reserved.
//

#import "PCScene.h"

@implementation PCScene

-(void)didMoveToView:(SKView *)view {
    if (self.contentCreated == NO) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

-(void)createSceneContents {
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
}

@end
