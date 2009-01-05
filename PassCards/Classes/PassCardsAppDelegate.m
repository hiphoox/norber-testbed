//
//  PassCardsAppDelegate.m
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import "PassCardsAppDelegate.h"
#import "WalletViewController.h"

@implementation PassCardsAppDelegate


@synthesize window;
@synthesize walletViewController;
@synthesize optionsViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
  
  [window addSubview:[optionsViewController view]];
//  [window addSubview:[walletViewController view]];
  [window makeKeyAndVisible];
}


- (void)dealloc {
  [optionsViewController release];
  [walletViewController release];
  [window release];
  
  [super dealloc];
}

@end
