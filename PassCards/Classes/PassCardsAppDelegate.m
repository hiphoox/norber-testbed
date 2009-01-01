//
//  PassCardsAppDelegate.m
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import "PassCardsAppDelegate.h"
#import "MenuTableViewController.h"

@implementation PassCardsAppDelegate


@synthesize window;
@synthesize menuViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  
  [window addSubview:[menuViewController view]];
  [window makeKeyAndVisible];
}

- (void)dealloc {
  [menuViewController release];
  [window release];
  
  [super dealloc];
}

@end
