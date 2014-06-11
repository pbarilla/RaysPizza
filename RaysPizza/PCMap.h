//
//  PCMap.h
//  LetsTryThisAgain
//
//  Created by pat on 9/06/2014.
//  Copyright (c) 2014 pizzacat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCMap : NSObject

@property (strong, nonatomic) NSMutableArray *worldMap;

-(void)prepareMapArray;
-(void)setMapDataAtPoint:(CGPoint)point withInformation:(NSNumber *)information;
-(void)loadMap:(NSString *)mapName;
-(int)valueForPoint:(CGPoint)point;


@end
