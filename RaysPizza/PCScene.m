//
//  PCScene.m
//  RaysPizza
//
//  Created by Pat on 11/06/2014.
//  LMAO do whatever you want. 
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
