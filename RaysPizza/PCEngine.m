//
//  PCEngine.m
//  RaysPizza
//
//  Created by Pat on 11/06/2014.
//  LMAO do whatever you want. 
//

#import "PCEngine.h"

@implementation PCEngine

-(id)init {
    self = [super init];
    if (self) {
        _player = [[PCPlayer alloc]init];
    }
    return self;
}

@end
