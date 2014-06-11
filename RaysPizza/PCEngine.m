//
//  PCEngine.m
//  Spritekit Raycaster
//
//  Created by pat-keynected on 11/06/2014.
//  Copyright (c) 2014 pizzacat. All rights reserved.
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
