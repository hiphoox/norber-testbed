//
//  FlipView.h
//  PerfectPasswords
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright 2008 StoneFree Software. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"

#define kAnimationKey @"transitionViewAnimation"


@interface FlipView : UIImageView
{
	CGPoint startTouchPosition;
	NSString *dirString;
  MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end
