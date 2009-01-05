#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "WalletViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface WalletsTableViewController : UITableViewController
{
	NSMutableArray *tableTitles;
	int ithTitle;
  WalletViewController *walletViewController;
}

@property (nonatomic, retain) IBOutlet WalletViewController *walletViewController;

@end
