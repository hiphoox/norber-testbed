//
//  FlipsideViewController.h
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipsideViewController : UIViewController <UITextFieldDelegate> {
	UITextField *cardLabel;
}

@property (nonatomic, retain) IBOutlet UITextField *cardLabel;

@end
