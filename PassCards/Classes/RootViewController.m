//
//  RootViewController.m
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "FlipsideViewController.h"


@implementation RootViewController

@synthesize infoButton;
@synthesize flipsideNavigationBar;
@synthesize mainViewController;
@synthesize flipsideViewController;


- (void)viewDidLoad {
  
  [super viewDidLoad];
  MainViewController *viewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
  self.mainViewController = viewController;
  [viewController release];
  
  [self.view insertSubview:mainViewController.view belowSubview:infoButton];
  [flipsideNavigationBar removeFromSuperview]; //At the beginning hide Navigation bar
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
  
  UIView *mainView = mainViewController.view;
  UIView *flipsideView = flipsideViewController.view;
  
  NSString *newWalletName = [[flipsideViewController cardLabel] text];
  [mainViewController setWalletName: newWalletName];
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:1];
  [UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
  
  if ([mainView superview] != nil) {
    [flipsideViewController viewWillAppear:YES];
    [mainViewController viewWillDisappear:YES];
    [mainView removeFromSuperview];
    [infoButton removeFromSuperview];
    [self.view addSubview:flipsideView];
    [self.view insertSubview:flipsideNavigationBar aboveSubview:flipsideView];
    //FIX: We need to set the frame sizes because otherwise the navigation bar appears incomplete.
    //Norberto Ortigoza. 28/Dic/2008
    [flipsideNavigationBar setFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)]; 
    [mainViewController viewDidDisappear:YES];
    [flipsideViewController viewDidAppear:YES];
    
  } else {
    [mainViewController viewWillAppear:YES];
    [flipsideViewController viewWillDisappear:YES];
    [flipsideView removeFromSuperview];
    [flipsideNavigationBar removeFromSuperview];
    [self.view addSubview:mainView];
    [self.view insertSubview:infoButton aboveSubview:mainViewController.view];
    [flipsideViewController viewDidDisappear:YES];
    [mainViewController viewDidAppear:YES];
  }
  [UIView commitAnimations];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
  // Release anything that's not essential, such as cached data
}


- (void)dealloc {
  [infoButton release];
  [flipsideNavigationBar release];
  [mainViewController release];
  [flipsideViewController release];
  
  [super dealloc];
}


@end
