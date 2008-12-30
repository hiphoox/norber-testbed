//
//  MainViewController.h
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wallet.h"

@interface CardViewController : UIViewController {
  UILabel *cardNameLabel;
  UILabel *cardNumberLabel;
  UIImageView *backgroundView;
  Wallet *currentWallet;
}

@property (nonatomic, retain) IBOutlet UILabel *cardNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *cardNumberLabel;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundView;
@property (nonatomic, retain) Wallet *currentWallet;

- (void)setWalletName: (NSString *)newCardLabel;

@end
