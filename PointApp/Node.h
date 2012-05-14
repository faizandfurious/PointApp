//
//  Node.h
//  PointApp
//
//  Created by Faiz Abbasi on 4/3/12.
//  Copyright (c) 2012 Menlo School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject{
    UIImageView *nodeImage;
}

@property float xcoord;
@property float ycoord;
@property (nonatomic, retain) UIImage* originalImage;
@property (nonatomic, retain) UIImage* selectedImage;


- (id) initWithCGPoint:(CGPoint)Point;

@end
