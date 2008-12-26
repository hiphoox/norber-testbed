//
//  MainViewController.m
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

#define LABEL_TEXT		993

@implementation MainViewController

@synthesize cardLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)setCardLabelText: (NSString *)newCardLabel
{
  [cardLabel setText:newCardLabel];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	char* params[] = {"ppp","5f4b9a6c04b8e3af74eba349bea5655b0977a96037eea8a55b3347d3900043d1","0","5"};
	char* passcodes = PassCodes(4, params);
	
	
	NSString *codes = [NSString stringWithCString: passcodes];
	free(passcodes);
	
	// Create landscape image orientation
	CGRect apprect;
	apprect.origin = CGPointMake(0.0f, 0.0f);
	apprect.size = CGSizeMake(480.0f, 300.0f);
	CGRect frame = CGRectInset(apprect, 0, 0);
	
	UIImageView *backView = [[FlipView alloc] initWithFrame:self.view.bounds];
	[backView setImage:[UIImage imageNamed:@"frontside.png"]];
	[backView setUserInteractionEnabled:YES];
	[backView setFrame:frame]; // Change image orientation
	[self.view addSubview:backView];
	[backView release];	

  // Add the password label
	cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 445.0f, 80.0f)];
	cardLabel.center = CGPointMake(460.0f / 2.0f, 80.0f);
	cardLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:28.0f];
	cardLabel.backgroundColor = [UIColor clearColor];
	cardLabel.textColor = [UIColor whiteColor];
	cardLabel.textAlignment = UITextAlignmentCenter;
	cardLabel.tag = LABEL_TEXT;
	[cardLabel setText:@"ETIQUETA"];
	[self.view addSubview:cardLabel];
	[cardLabel release];
  
	// Add the password label
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 445.0f, 80.0f)];
	label.center = CGPointMake(460.0f / 2.0f, 160.0f);
	label.font = [UIFont fontWithName:@"Verdana-Bold" size:28.0f];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = UITextAlignmentCenter;
	label.tag = LABEL_TEXT;
	[label setText:codes];
	[self.view addSubview:label];
	[label release];
	
	NSLog(codes);
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
    [super dealloc];
}


@end
