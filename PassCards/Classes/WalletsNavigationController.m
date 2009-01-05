#import "WalletsNavigationController.h"

@implementation WalletsNavigationController


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return YES; //(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration  {
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  [UIView beginAnimations:nil context:context];
  
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  [UIView setAnimationDuration:1.0];
  
  //[[[walletViewController cardViewController] view] layer].position = CGPointMake(0.0f,0.0f);
  //1[[[[walletViewController cardViewController] view] layer] setValue:[NSNumber numberWithFloat:1.35f] forKeyPath:@"transform.scale"];
  
	[UIView commitAnimations];  
}

@end
