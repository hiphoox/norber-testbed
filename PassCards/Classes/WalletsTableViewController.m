
#import "WalletsTableViewController.h"

#define NCELLS 4
#define SMALLRECT CGRectMake(0.0f, 60.0f, 60.0f, 60.0f) 

@implementation WalletsTableViewController

@synthesize walletViewController;

- (WalletsTableViewController *) init
{
	if (self = [super init]) self.title = @"Table Edits";
	return self;
}

#pragma mark Data Source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [tableTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"any-cell"] autorelease];
  
	cell.text = [tableTitles objectAtIndex:[indexPath row]];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	cell.hidesAccessoryWhenEditing = YES;
  
	return cell;
}

#pragma mark Delegate Methods

// Add a new item
- (void) add
{
	[tableTitles addObject:[NSString stringWithFormat:@"Table Cell #%d", ++ithTitle]];	
	[self.tableView reloadData];
}

/*
 * Accessory Button Handler: This simply opens an image controller with the Hello World image.
 */

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
  //[[[walletViewController cardViewController] backgroundView] setFrame:CGRectMake(50.0, 200.0, 50.0, 50.0)];
	[[self navigationController] pushViewController: walletViewController  animated:YES];

  CGContextRef context = UIGraphicsGetCurrentContext();
  [UIView beginAnimations:nil context:context];
   
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  [UIView setAnimationDuration:1.0];
  
  [[[walletViewController cardViewController] view] layer].position = CGPointMake(160.0f,180.0f);
  [[[[walletViewController cardViewController] view] layer] setValue:[NSNumber numberWithFloat:0.65f] forKeyPath:@"transform.scale"];

	[UIView commitAnimations];  
}

- (void) deselect
{	
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

// Respond to a user tap
- (void)tableView:(UITableView *)tableView selectionDidChangeToIndexPath:(NSIndexPath *)newIndexPath fromIndexPath:(NSIndexPath *)oldIndexPath 
{
	printf("User selected row %d\n", [newIndexPath row] + 1);
	[self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}

// Respond to deletion
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	printf("About to delete item %d\n", [indexPath row]);
	[tableTitles removeObjectAtIndex:[indexPath row]];
	[self.tableView reloadData];
}	 

#pragma mark View Methods

- (void)loadView
{
	[super loadView];
  
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
                                            initWithTitle:@"Add" 
                                            style:UIBarButtonItemStylePlain 
                                            target:self 
                                            action:@selector(add)] autorelease];
	
	// Initialize the titles
	tableTitles = [[NSMutableArray alloc] init];
	ithTitle = NCELLS;
	for (int i = 1; i <= NCELLS; i++) 
		[tableTitles addObject:[[NSString stringWithFormat:@"Wallet #%d", i] retain]];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return YES; //(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void) dealloc
{
	[tableTitles release];
	[super dealloc];
}

@end
