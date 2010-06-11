//
//  RootViewController.m
//  GenericTableViews
//
//  Created by Craig Hockenberry on 4/28/09.
//  Copyright The Iconfactory 2009. All rights reserved.
//

#import "RootViewController.h"
#import "GenericTableViewsAppDelegate.h"

#import "IFPreferencesModel.h"
#import "IFTemporaryModel.h"

#import "SampleViewController.h"
#import "CreditsViewController.h"

@interface RootViewController ()

@property (nonatomic, readwrite, retain) IFTemporaryModel *formModel;

@end


@implementation RootViewController

@synthesize formModel;

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.title = @"Root";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	
/*
	If you're processing a form, this is a convenient place to gather the contents of the model
	and do whatever you need to in your application. Another way is to "submit" the form is by adding
	controls on the form's view controller: either a button in the navbar or a IFButtonCellController
	can be used.
*/
	if (self.formModel)
	{
		NSString *message = [NSString stringWithFormat:@"Choice = %@\nText = %@\nSwitch = %@",
				[formModel objectForKey:@"sampleChoice"],
				[formModel objectForKey:@"sampleText"],
				[formModel objectForKey:@"sampleSwitch"]];
				
		UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Form Values" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alertView show];
		
		self.formModel = nil;
	}
}

- (void)dealloc
{
	self.formModel = nil;

    [super dealloc];
}

#pragma mark Actions

/*
	There are two primary use cases for these classes:
	
	1. A "settings" style interface where you allow a user to configure their NSUserDefaults.
		
	2. A "form" style interface where you allow a user to specify parameters for some kind of
	action. A search is a good example.
	
	Both of these cases are described below:
*/

- (IBAction)showSettings:(id)sender
{
/*
	The IFPreferencesModel is a wrapper around NSUserDefaults which conforms to the IFCellModel protocol.
	This cell model protocol is used throughout the generic view controller and cells.
	
	This preferences model can be used to pre-populate the user settings. In the code below, the
	current date is being used to populate the "value" setting. SampleViewController.m shows how this
	"value" preference is displayed.
*/

	IFPreferencesModel *settingsModel = [[[IFPreferencesModel alloc] init] autorelease];
	[settingsModel setObject:[[NSDate date] description] forKey:@"sampleValue"];

/*
	Once you have a model, you assign it to the view controller. The SampleViewController is a
	subclass of IFGenericTableViewController.
	
	After the view controller is configured, it's pushed onto the navigation stack.
*/

	SampleViewController *viewController = [[SampleViewController alloc] initWithStyle:UITableViewStyleGrouped];
	viewController.model = settingsModel;
	viewController.navigationItem.title = @"Settings";
	[[self navigationController] pushViewController:viewController animated:YES];
	[viewController release];
}

- (IBAction)showForm:(id)sender
{
/*
	IFTemporaryModel is another IFCellModel implementation. It's a wrapper around a mutable dictionary
	and is used to collect temporary values (such as those used in a form.)
	
	Again, we're setting a "value" in the model (this time it's an NSNumber instead of an NSString.)
	
	The form values can be prepopulated at this point: the setting of choice to 1 is an example of this.
	The table view cells will, by default, show nil values as 0 or empty text.
*/

	self.formModel = [[[IFTemporaryModel alloc] init] autorelease];
	[self.formModel setObject:[NSNumber numberWithInt:1] forKey:@"sampleChoice"];
	[self.formModel setObject:[NSNumber numberWithLong:time(NULL)] forKey:@"sampleValue"];

/*
	The formModel instance is retained by the view controller. This is done so that it can be examined
	in the viewDidAppear: method above.
*/

/*
	Like the settings example above, the new view controller is configured and pushed onto the stack.
*/
	SampleViewController *viewController = [[SampleViewController alloc] initWithStyle:UITableViewStyleGrouped];
	viewController.model = self.formModel;
	viewController.navigationItem.title = @"Form";
	[[self navigationController] pushViewController:viewController animated:YES];
	[viewController release];
}

- (IBAction)showCredits:(id)sender
{
/*
	The license for this software requires that you credit The Iconfactory as the creator of
	this source code. This is an example of how you might do that:
*/
	CreditsViewController *viewController = [[CreditsViewController alloc] init];
	[[self navigationController] pushViewController:viewController animated:YES];
	[viewController release];
}

@end

