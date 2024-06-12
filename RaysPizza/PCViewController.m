//
//  PCViewController.m
//  RaysPizza
//
//  Created by Pat on 11/06/2014.
//  LMAO do whatever you want. 
//

#import "PCViewController.h"

@interface PCViewController()

@property CGRect screenDimensions;

@end

@implementation PCViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _screenDimensions = [UIScreen mainScreen].bounds;
    
    // SpriteKit
    SKView *spriteView = (SKView *)self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsFPS = YES;
    spriteView.showsNodeCount = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.03
                                     target:self
                                   selector:@selector(renderLoop)
                                   userInfo:nil repeats:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if (touchLocation.x > 450) {
        // turn left
        [self.player setMovement:PlayerTurnLeft];
    } else if (touchLocation.x < 100) {
        // turn right
        [self.player setMovement:PlayerTurnRight];
    }
    
    if (touchLocation.y < 100) {
        // move forward
        [self.player setMovement:PlayerMoveForward];
    } else if (touchLocation.y > 200) {
        // move backwards
        [self.player setMovement:PlayerMoveBackward];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    // movement needs to be a bit...finer later on. for now, releasing any touch stops all movement.
    // not perfect, but works for now
    
    if (touchLocation.x > 450) {
        [self stopAllMovement];
        
    } else if (touchLocation.x < 100) {
        [self stopAllMovement];
    }
    
    if (touchLocation.y < 100) {
        [self stopAllMovement];
        
    } else if (touchLocation.y > 200) {
        [self stopAllMovement];
    }
}

-(void)stopAllMovement {
    [self.player invalidateMovement];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PCMap sharedInstance] loadMap:@"TestMap"];
    _player = [[PCPlayer alloc]init];
}

-(void)startEngine:(PCScene *)scene {
    
    int w = 142;
    int h = 320;
    
    // add the sky
    SKSpriteNode *skybox = [[SKSpriteNode alloc]initWithColor:[SKColor grayColor] size:CGSizeMake(320, 120)];
    skybox.position = CGPointMake(160, 180);
    [scene addChild:skybox];
    
    
    // assuming w here is actually mapWidth, would make sense
    for (int x = 0; x < w; x++) {
        // calculate ray position and direction
        double cameraX = 2 * x / (double)w-1; // x coordinate in camera space
        CGPoint posPoint = [self.player getPlayerPosition];
        CGPoint dirPoint = [self.player getPlayerDirection];
        CGPoint planePoint = [self.player getPlayerPlane];
        
        double rayPosX = posPoint.x;
        double rayPosY = posPoint.y;
        
        double rayDirX = dirPoint.x + planePoint.x * cameraX;
        double rayDirY = dirPoint.y + planePoint.y * cameraX;
        
        // which box of the map are we in
        int mapX = (int)rayPosX;
        int mapY = (int)rayPosY;
        
        // length of the ray from the current position to next x or y sde
        double sideDistX;
        double sideDistY;
        
        // length of ray from one x or y side to next x or y side
        double deltaDistX = sqrt(1 + (rayDirY * rayDirY) / (rayDirX * rayDirX));
        double deltaDistY = sqrt(1 + (rayDirX * rayDirX) / (rayDirY * rayDirY));
        double perpWallDist;
        
        // what direction to step in x or y direction (either +1 or -1);
        int stepX;
        int stepY;
        
        int hit = 0; // was a wall hit?
        int side = 0; // was a northsouth or an eastwest wall hit?
        
        if (rayDirX < 0) {
            stepX = -1;
            sideDistX = (rayPosX - mapX) * deltaDistX;
        } else {
            stepX = 1;
            sideDistX = (mapX + 1.0 - rayPosX) * deltaDistX;
        }
        
        if (rayDirY < 0) {
            stepY = -1;
            sideDistY = (rayPosY - mapY) * deltaDistY;
        } else {
            stepY = 1;
            sideDistY = (mapY + 1.0 - rayPosY) * deltaDistY;
        }
        
        //perform DDA
        while (hit == 0) {
            // jump to next map square OR in x=direction, OR in y-direction
            if (sideDistX < sideDistY) {
                sideDistX += deltaDistX;
                mapX += stepX;
                side = 0;
            } else {
                sideDistY += deltaDistY;
                mapY += stepY;
                side = 1;
            }
            // check if ray has hit wall
            if ([[PCMap sharedInstance] valueForPoint:CGPointMake(mapX, mapY)] > 0) hit = 1;
        }
        
        // calculate distance projected on camera direction (oblique distance will give fisheye effect
        if (side == 0) {
            perpWallDist = fabs((mapX - rayPosX + (1 - stepX) / 2) / rayDirX);
        } else {
            perpWallDist = fabs((mapY - rayPosY + (1 - stepY) / 2) / rayDirY);
        }
        
        // calculate height of line to draw on screen
        int lineHeight = fabs((int)h / perpWallDist);
        // calculate lowest and heighest pixel to fill in current strupe
        int drawStart = -lineHeight / 2 + h / 2;
        if (drawStart < 0) {
            drawStart = 0;
        }
        int drawEnd = lineHeight / 2 + h / 2;
        if (drawEnd >= h) {
            drawEnd = h - 1;
        }
        
        // get wall color
        UIColor *wallColor = [self getColorForWall:[[PCMap sharedInstance] valueForPoint:CGPointMake(mapX, mapY)]];
        
        // give x and y sides different brightness
        if (side == 1) {
            wallColor = [self lightenWallColor:wallColor];
        }
        
        // draw the sprite
        [scene addChild:[self drawLine:x withDrawStart:drawStart andDrawEnd:drawEnd andColor:wallColor]];
        
        // check movement, if needed
        [self.player pulseMovementControls];
    }
}

-(UIColor *)getColorForWall:(int)wall {
    UIColor *wallColor;
    switch(wall) {
        case 1: {
            wallColor = [UIColor greenColor];
            break;
        }
        case 2: {
            wallColor = [UIColor blueColor];
            break;
        }
        case 3: {
            wallColor = [UIColor redColor];
            break;
        }
        case 4: {
            wallColor = [UIColor orangeColor];
            break;
        }
        case 5: {
            wallColor = [UIColor brownColor];
            break;
        }
        case 6: {
            wallColor = [UIColor cyanColor];
            break;
        }
        case 7: {
            wallColor = [UIColor magentaColor];
            break;
        }
        case 8: {
            wallColor = [UIColor lightGrayColor];
            break;
        }
        case 9: {
            wallColor = [UIColor darkGrayColor];
            break;
        }
        default :{
            wallColor = [UIColor yellowColor];
            break;
        }
    }
    return wallColor;
}

-(UIColor *)lightenWallColor:(UIColor *)wallColor {
    double red;
    double green;
    double blue;
    double alpha;
    [wallColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    red = red / 2;
    green = green / 2;
    blue = blue / 2;
    
    UIColor *lighterColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return lighterColor;
}

-(void)renderLoop{
    PCScene *scene = [[PCScene alloc]initWithSize:CGSizeMake(320, 240)];
    SKView *spriteView = (SKView *)self.view;
    [self startEngine:scene];
    [spriteView presentScene:scene];
}

-(SKSpriteNode *)drawLine:(int)x withDrawStart:(int)drawStart andDrawEnd:(int)drawEnd andColor:(UIColor *)color {
    float length = drawEnd - drawStart;
    if (length < 0) {
        length = 0;
    }
    SKSpriteNode *sprite = [[SKSpriteNode alloc]initWithColor:color size:CGSizeMake(3, length)];
    sprite.position = CGPointMake(x*3, 120);
    return sprite;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

