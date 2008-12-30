//
//  PassCardsAppDelegate.m
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import "PassCardsAppDelegate.h"
//#import "RootViewController.h"
#import "MenuTableViewController.h"

@implementation PassCardsAppDelegate


@synthesize window;
//@synthesize rootViewController;
@synthesize menuViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  
  //[window addSubview:[rootViewController view]];
  [window addSubview:[menuViewController view]];
  [window makeKeyAndVisible];
}

- (void)dealloc {
  //[rootViewController release];
  [menuViewController release];
  [window release];
  
  [super dealloc];
}

@end
