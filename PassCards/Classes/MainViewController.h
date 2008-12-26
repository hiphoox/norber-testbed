//
//  MainViewController.h
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipView.h"
#import "ppp.h"

@interface MainViewController : UIViewController {
  UILabel *cardLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *cardLabel;

- (void)setCardLabelText: (NSString *)newCardLabel;

@end
