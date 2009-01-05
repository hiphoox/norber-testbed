//
//  RootViewController.m
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import "WalletViewController.h"
#import "CardViewController.h"
#import "FlipsideViewController.h"


@implementation WalletViewController

@synthesize infoButton;
@synthesize flipsideNavigationBar;
@synthesize cardViewController;
@synthesize flipsideViewController;


- (void)viewDidLoad {
  
  [super viewDidLoad];
  CardViewController *viewController = [[CardViewController alloc] initWithNibName:@"CardView" bundle:nil];
  self.cardViewController = viewController;
  [viewController release];
  
  [self.view insertSubview:cardViewController.view belowSubview:infoButton];
  [flipsideNavigationBar removeFromSuperview];

}


- (void)loadFlipsideViewController {
  
  FlipsideViewController *viewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
  self.flipsideViewController = viewController;
  [viewController release];  
}


- (IBAction)toggleView {    
  /*
   This method is called when the info or Done button is pressed.
   It flips the displayed view from the main view to the flipside view and vice-versa.
   */
  if (flipsideViewController == nil) {
    [self loadFlipsideViewController];
  }
  
  UIView *mainView = cardViewController.view;
  UIView *flipsideView = flipsideViewController.view;
  
  NSString *newWalletName = [[flipsideViewController cardLabel] text];
  [cardViewController setWalletName: newWalletName];
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:1];
  [UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
  
  if ([mainView superview] != nil) {
    [flipsideViewController viewWillAppear:YES];
    [cardViewController viewWillDisappear:YES];
    [mainView removeFromSuperview];
    [infoButton removeFromSuperview];
    [self.view addSubview:flipsideView];
    [self.view insertSubview:flipsideNavigationBar aboveSubview:flipsideView];
    //FIX: We need to set the frame sizes because otherwise the navigation bar appears incomplete.
    //Norberto Ortigoza. 28/Dic/2008
    [flipsideNavigationBar setFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)]; 
    [cardViewController viewDidDisappear:YES];
    [flipsideViewController viewDidAppear:YES];
    
  } else {
    [cardViewController viewWillAppear:YES];
    [flipsideViewController viewWillDisappear:YES];
    [flipsideView removeFromSuperview];
    [flipsideNavigationBar removeFromSuperview];
    [self.view addSubview:mainView];
    [self.view insertSubview:infoButton aboveSubview:cardViewController.view];
    [flipsideViewController viewDidDisappear:YES];
    [cardViewController viewDidAppear:YES];
  }
  [UIView commitAnimations];
}


// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//  // Return YES for supported orientations
//  return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration  {
//  
//	CGRect apprect;
//	apprect.origin = CGPointMake(0.0f, 0.0f);
//	
//	if ((orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight))
//		apprect.size = CGSizeMake(480.0f, 300.0f);
//	else
//		apprect.size = CGSizeMake(320.0f, 460.0f);
//  
//	// Iterate through the subviews and inset each item
//	float offset = 0.0f;//32.0f;
//	for (UIView *subview in [self.view subviews])	
//	{
//		CGRect frame = CGRectInset(apprect, offset, offset);
//		[subview setFrame:frame];
//		offset += 32.0f;
//	}
//}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
  // Release anything that's not essential, such as cached data
}


- (void)dealloc {
  [infoButton release];
  [flipsideNavigationBar release];
  [cardViewController release];
  [flipsideViewController release];
  
  [super dealloc];
}


@end
