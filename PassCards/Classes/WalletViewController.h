//
//  RootViewController.h
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardViewController;
@class FlipsideViewController;

@interface WalletViewController : UIViewController {
  
  UIButton *infoButton;
  CardViewController *cardViewController;
  FlipsideViewController *flipsideViewController;
  UINavigationBar *flipsideNavigationBar;
}

@property (nonatomic, retain) IBOutlet UIButton *infoButton;
@property (nonatomic, retain) CardViewController *cardViewController;
@property (nonatomic, retain) IBOutlet UINavigationBar *flipsideNavigationBar;
@property (nonatomic, retain) FlipsideViewController *flipsideViewController;

- (IBAction)toggleView;

@end
