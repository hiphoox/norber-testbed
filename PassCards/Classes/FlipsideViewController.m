//
//  FlipsideViewController.m
//  PassCards
//
//  Created by Norberto Ortigoza on 25/12/08.
//  Copyright StoneFree Software 2008. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize cardLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	
	// A text entry field
	[cardLabel setBorderStyle:UITextBorderStyleRoundedRect];
	cardLabel.placeholder = @"name";
	cardLabel.autocorrectionType = UITextAutocorrectionTypeNo;
	cardLabel.autocapitalizationType = UITextAutocapitalizationTypeNone;
	cardLabel.returnKeyType = UIReturnKeyDone;
	cardLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
	cardLabel.delegate = self;
	
}

// This method catches the return action
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
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
