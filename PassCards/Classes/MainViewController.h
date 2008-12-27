//
//  MainViewController.h
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipView.h"
#import "Wallet.h"

@interface MainViewController : UIViewController {
  UILabel *cardNameLabel;
  UILabel *cardNumberLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *cardNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *cardNumberLabel;

- (void)setCardLabelText: (NSString *)newCardLabel;

@end
