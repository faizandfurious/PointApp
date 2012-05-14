//
//  ViewController.m
//  PointApp
//
//  Created by Faiz Abbasi on 4/3/12.
//  Copyright (c) 2012 Menlo School. All rights reserved.
//

#import "ViewController.h"
#import "Node.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize nodeList;
@synthesize node;
@synthesize deleteNode;


- (void)viewDidLoad {
    [super viewDidLoad];
	drawImage = [[UIImageView alloc] initWithImage:nil];
	drawImage.frame = self.view.frame;
	[self.view addSubview:drawImage];
	mouseMoved = 0;
    nodeList = [[NSMutableArray alloc] initWithObjects:nil]; 
    
    UITapGestureRecognizer *twoFingersOneTap = 
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingersOneTap)];
    [twoFingersOneTap setNumberOfTapsRequired:1];
    [twoFingersOneTap setNumberOfTouchesRequired:2];
    [[self view] addGestureRecognizer:twoFingersOneTap];
}

/*--------------------------------------------------------------
 * Two fingers, two taps
 *-------------------------------------------------------------*/
- (void)twoFingersOneTap {
        NSLog(@"Action: Two fingers, one tap");
} 

- (void)drawLineWithPoints:(CGPoint) pt1 
                  andPoint:(CGPoint) pt2{
    
//    float x1 = pt1.x;
//    float y1 = pt1.y;
//    float x2 = pt2.x;
//    float y2 = pt2.y;
//   
    NSLog(@"Clicking on (%f, %f), and (%f, %f).", pt1.x, pt1.y, pt2.x, pt2.y);
    //NSLog(@"The second point where I am clicking is (%f", pt2.x, @", %f", pt2.y, @").");
    if(nodeList.count > 1)
    {
        NSLog(@"I am clicking it.");
        for(int i = 0; i < nodeList.count - 1; i++)
        {
            Node* currNodei = [nodeList objectAtIndex:i];
            NSLog(@"(%f, %f)", currNodei.xcoord, currNodei.ycoord);
            if(pt1.x > currNodei.xcoord - 30 && pt1.x < currNodei.xcoord + 30 && pt1.y > currNodei.ycoord - 30 && pt1.y < currNodei.ycoord + 30)
            {
                NSLog(@"First Level Achieved");
                
                for(int j = 1; j < nodeList.count - 1; j++)
                {
                    Node* currNodej = [nodeList objectAtIndex:j];
                    if(pt2.x > currNodej.xcoord - 30 && pt2.x < currNodej.xcoord + 30 && pt2.y > currNodej.ycoord - 30 && pt2.y < currNodej.ycoord + 30)
                    {
                        NSLog(@"Second Level Achieved");
                    }
                }

            }
        }
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	mouseSwiped = NO;
    NSSet *allTouches = [event allTouches];
    if(allTouches.count == 2)
    {
        UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
        
        CGPoint pt1 = [touch1 locationInView: touch1.view];
        
        UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
        
        CGPoint pt2 = [touch2 locationInView: touch2.view];
        
        [self drawLineWithPoints:pt1 andPoint:pt2];
    }
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) {
		drawImage.image = nil;
		return;
	}
	
	lastPoint = [touch locationInView:self.view];

	
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    NSUInteger numTaps = [touch tapCount];
    NSLog(@"Number of taps: %d", numTaps);
    Node* newNode = [[Node alloc] initWithCGPoint:lastPoint];
    NSLog(@"%f" @"%f", lastPoint.x, lastPoint.y);
	[nodeList addObject:newNode]; 
    NSSet *allTouches = [event allTouches];
//    if(allTouches.count == 2)
//    {
//        UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
//        
//        CGPoint pt1 = [touch1 locationInView: touch1.view];
//        
//        UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
//        
//        CGPoint pt2 = [touch2 locationInView: touch2.view];
//        
//        [self drawLineWithPoints:pt1 andPoint:pt2];
//    }
    
    if(nodeList.count > 0 && allTouches.count == 1)
    {
        BOOL newArea = true;
        for(int i = 0; i < nodeList.count - 1; i++)
        {
            Node* currNode = [nodeList objectAtIndex:i];
            if(lastPoint.x > currNode.xcoord - 25 && lastPoint.x < currNode.xcoord + 25 && lastPoint.y > currNode.ycoord - 25 && lastPoint.y < currNode.ycoord + 25)
                {
                    NSLog(@"I clicked it.");
                    [self selectedWith:currNode];
                    newArea = false;
                    break;
                }
        }
        if(newArea){
            [self drawWith:newNode];
            
        }
        else {
            [self drawWith:newNode];
        }
    }
}

- (void) selectedWith:(Node *)tempNode{
    
}

- (void) drawWith:(Node *)tempNode {

	if(!mouseSwiped) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[tempNode originalImage]];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(lastPoint.x, lastPoint.y, 60, 60);
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        //[panRecognizer setDelegate:self];
        [imageView addGestureRecognizer:panRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [tapRecognizer setNumberOfTapsRequired:1];
        //[tapRecognizer setDelegate:self];
        [imageView addGestureRecognizer:tapRecognizer];
        
        [self.view addSubview:imageView];
	}
}

-(void)tapped:(id)sender {
    NSLog(@"Got Tapped");
    [self.view bringSubviewToFront:[(UIRotationGestureRecognizer*)sender view]];
    [[sender view] removeFromSuperview];
    CGPoint center = [[sender view] center];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedNode.png"]];
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake(center.x - 30, center.y - 30, 60, 60);
    [self.view addSubview:imageView];
    
}

-(void)move:(id)sender {
//    NSLog(@"Is moving");
	
	[self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
		
		firstX = [[sender view] center].x;
		firstY = [[sender view] center].y;
	}
	
	translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
	
	[[sender view] setCenter:translatedPoint];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.35];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[[sender view] setCenter:translatedPoint];
		[UIView commitAnimations];
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setDeleteNode:nil];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (IBAction)deleteThisNode:(id)sender {
}
@end