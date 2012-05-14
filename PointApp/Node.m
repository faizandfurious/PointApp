//
//  Node.m
//  PointApp
//
//  Created by Faiz Abbasi on 4/3/12.
//  Copyright (c) 2012 Menlo School. All rights reserved.
//

#import "Node.h"

@implementation Node

@synthesize xcoord;
@synthesize ycoord;
@synthesize originalImage;
@synthesize selectedImage;

- (id) initWithCGPoint:(CGPoint)Point{
    
    xcoord = Point.x;
    ycoord = Point.y;
    
    originalImage = [UIImage imageNamed:@"originalNode.png"];
    selectedImage = [UIImage imageNamed:@"selectedNode.png"];

    return self;
}
@end
