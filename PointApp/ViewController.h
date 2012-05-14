//
//  ViewController.h
//  PointApp
//
//  Created by Faiz Abbasi on 4/3/12.
//  Copyright (c) 2012 Menlo School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"

@interface ViewController : UIViewController
{
    UIImageView *drawImage;
	int mouseMoved;
	BOOL mouseSwiped;
	CGPoint lastPoint;
    CGFloat firstX;
	CGFloat firstY;	

}

@property (strong, nonatomic) NSMutableArray* nodeList;
@property (strong, nonatomic) Node *node;
@property (weak, nonatomic) IBOutlet UIButton *deleteNode;
- (IBAction)deleteThisNode:(id)sender;
- (void) selectedWith:(Node *)tempNode;
- (void) drawWith:(Node *)tempNode;


@end
