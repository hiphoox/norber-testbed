//
//  FlipView.m
//  PerfectPasswords
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright 2008 StoneFree Software. All rights reserved.
//

#import "FlipView.h"


@implementation FlipView
- (FlipView *) init
{
	self = [super init];
	[self setMultipleTouchEnabled:YES];
	return self;
}

- (CATransition *) getAnimation:(NSString *) direction
{
	CATransition *animation = [CATransition animation];
	[animation setDelegate:self];
	// [animation setType:@"oglFlip"]; 
	[animation setType:kCATransitionPush];
	[animation setSubtype:direction];
	[animation setDuration:1.0f];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	return animation;
}

#define HORIZ_SWIPE_DRAG_MIN 12 
#define VERT_SWIPE_DRAG_MAX 4 

// The following swipe code derives from Apple Sample Code
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{ 
	UITouch *touch = [touches anyObject]; 
	startTouchPosition = [touch locationInView:self]; 
	dirString = NULL;
} 

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{ 
	UITouch *touch = touches.anyObject; 
	CGPoint currentTouchPosition = [touch locationInView:self]; 
	
	if (fabsf(startTouchPosition.x - currentTouchPosition.x) >= 
			HORIZ_SWIPE_DRAG_MIN && 
			fabsf(startTouchPosition.y - currentTouchPosition.y) <= 
			VERT_SWIPE_DRAG_MAX) 
	{ 
		// Horizontal Swipe
		if (startTouchPosition.x < currentTouchPosition.x) {
			dirString = kCATransitionFromLeft;
		}
		else 
			dirString = kCATransitionFromRight;
	} 
} 

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if (dirString) 
	{
		CATransition *animation = [self getAnimation:dirString];
		[[[self superview] layer] addAnimation:animation forKey:kAnimationKey];
		
	}
}
@end
