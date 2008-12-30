//
//  PassCardsAppDelegate.h
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class MenuTableViewController;

@interface PassCardsAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  //RootViewController *rootViewController;
  MenuTableViewController *menuViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property(nonatomic, retain) IBOutlet MenuTableViewController *menuViewController; 

@end

