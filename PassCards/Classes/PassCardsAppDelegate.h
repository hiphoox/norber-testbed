//
//  PassCardsAppDelegate.h
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WalletViewController;
@class OptionsViewController;
@class WalletsNavigationController;

@interface PassCardsAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  WalletViewController *walletViewController;
  WalletsNavigationController *optionsViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WalletViewController *walletViewController;
@property (nonatomic, retain) IBOutlet WalletsNavigationController *optionsViewController;

@end

