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

- (UILabel *) addLabelWithText: (NSString *) text  {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 40.0f)];
  label.font = [UIFont fontWithName:@"Verdana-Bold" size:12.0f];
  label.backgroundColor = [UIColor clearColor];
  label.textAlignment = UITextAlignmentCenter;
  label.text = text;
  label.textColor = [UIColor blueColor];
  [backgroundView addSubview:label];
  [label autorelease];

  return label;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
	
  currentWallet = [[Wallet walletFromName:@"www.cocoaheads.com"] retain];
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
  
  const int y_offset = 75.0f;
  const int x_offset = 90.0f;
  const int y_inc = 20.0f;
  const int x_inc = 50.0f;
  int currentRow = 0;
  int currentColumn = 0;

  NSArray *columHeaders = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G", nil];
  //Setting Column Headers
  for (currentColumn = 0; currentColumn < [newCard columns]; ++currentColumn)
  {
    UILabel *label = [self addLabelWithText:[columHeaders objectAtIndex: currentColumn]];
    label.center = CGPointMake(x_offset + (x_inc * currentColumn), y_offset - 20);
  }

  //Setting Row Headers
  for (currentRow = 0; currentRow < [newCard rows]; ++currentRow)
  {
    UILabel *label = [self addLabelWithText:[NSString stringWithFormat:@"%i", currentRow + 1]];
    label.center = CGPointMake(x_offset - 40, y_offset + (y_inc * currentRow));
  }
  
	// Add the passcode labels
  for (currentRow = 0; currentRow < [newCard rows]; ++currentRow)
  {
    for (currentColumn = 0; currentColumn < [newCard columns]; ++currentColumn)
    {
      UILabel *label = [self addLabelWithText:[newCard passCodeAtRow: currentRow atColumn: currentColumn]];
      label.center = CGPointMake(x_offset + (x_inc * currentColumn), y_offset + (y_inc * currentRow));
      label.textColor = [UIColor whiteColor];
      label.tag = LABEL_TEXT;
    }  
  }
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
