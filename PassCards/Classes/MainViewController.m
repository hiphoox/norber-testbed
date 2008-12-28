//
//  MainViewController.m
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

#define LABEL_TEXT		990
#define LABEL_CARD_NUMBER		991

@implementation MainViewController

@synthesize cardNameLabel;
@synthesize cardNumberLabel;
@synthesize backgroundView;
@synthesize currentWallet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    // Custom initialization
  }
  return self;
}

- (void)setWalletName: (NSString *)newWalletName
{
  [currentWallet setName:newWalletName];
  [cardNameLabel setText:newWalletName];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
	
  currentWallet = [[Wallet walletFromName:@"Prueba"] retain];
  Card *newCard = [currentWallet getNextValidCard];
  NSLog(@"Card: %@", newCard);
  
  // Configure wallet label
	cardNameLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:18.0f];
	cardNameLabel.tag = LABEL_TEXT;
	[cardNameLabel setText:[currentWallet name]];
  
  // Configure card number
	cardNumberLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:18.0f];
	cardNumberLabel.tag = LABEL_CARD_NUMBER;
	[cardNumberLabel setText: [NSString stringWithFormat:@"# %d", [currentWallet nextValidCard]]];
  
	// Add the passcodes label
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 445.0f, 80.0f)];
	label.center = CGPointMake(460.0f / 2.0f, 160.0f);
	label.font = [UIFont fontWithName:@"Verdana-Bold" size:28.0f];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = UITextAlignmentCenter;
	label.tag = LABEL_TEXT;
	[label setText:[[newCard passCodes] componentsJoinedByString:@" "]];
	[backgroundView addSubview:label];
	[label release];
  
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
  // Release anything that's not essential, such as cached data
}


- (void)dealloc {
  [currentWallet release];
  [cardNumberLabel release];
  [cardNameLabel release];
  [backgroundView release];
  
  [super dealloc];
}


@end
