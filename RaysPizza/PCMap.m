//
//  PCMap.m
//  LetsTryThisAgain
//
//  Created by pat on 9/06/2014.
//  Copyright (c) 2014 pizzacat. All rights reserved.
//

#import "PCMap.h"

@implementation PCMap

-(id)init {
    self = [super init];
    if (self) {
        _worldMap = [[NSMutableArray alloc]init];
        _enemyMap = [[NSMutableArray alloc]init];
        _itemMap = [[NSMutableArray alloc]init];
        [self prepareMapArray];
    }
    return self;
}

-(BOOL)setEnemyLocation:(CGPoint)enemyLocation forEnemy:(int)enemy {
    int pointX = enemyLocation.x;
    int pointY = enemyLocation.y;
    NSMutableArray *xRow = [self.enemyMap objectAtIndex:pointY];
    [xRow replaceObjectAtIndex:pointX withObject:[NSNumber numberWithInt:enemy]];
    
    // eventually this can return NO if the placement is in error. 
    return YES;
}


+ (id)sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(void)prepareMapArray {
    int maxArrayY = mapHeight;
    for (int i = 0; i <= maxArrayY; i++) {
        // fill the world map with zeroes.
        NSMutableArray *xRow = [NSMutableArray arrayWithArray:@[@0]];
        [self.worldMap addObject:xRow];
    }
}

-(int)valueForPoint:(CGPoint)point {
    int pointX = point.x;
    int pointY = point.y;
    NSMutableArray *xRow = [self.worldMap objectAtIndex:pointY];
    NSNumber *value = [xRow objectAtIndex:pointX];
    return [value intValue];
}

-(void)setMapDataAtPoint:(CGPoint)point withInformation:(NSNumber *)information {
    int pointX = point.x;
    int pointY = point.y;
    NSMutableArray *xRow = [self.worldMap objectAtIndex:pointY];
    [xRow replaceObjectAtIndex:pointX withObject:information];
}

-(void)loadMap:(NSString *)mapName {
    // load map with name, append "pcmap" to the end.
    // eg, if its "Map1" then it becomes "Map1.pcmap"
    NSString *filePath = [[NSBundle mainBundle] pathForResource:mapName ofType:@"pcmap"];
    NSString *mapFile = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    // Lets get an array of each line
    NSArray *array = [mapFile componentsSeparatedByString:@"\n"];
    int counter = 0;
    // and now lets break each line up into an array
    for (NSString *string in array) {
        NSArray *newArray = [string componentsSeparatedByString:@","];
        NSMutableArray *mutNewArray = [NSMutableArray arrayWithArray:newArray];
        // and finally, lets replace each line of the world map with this array, badda bing, badda boom.
        [self.worldMap replaceObjectAtIndex:counter withObject:mutNewArray];
        counter++;
    }
    
}

@end
