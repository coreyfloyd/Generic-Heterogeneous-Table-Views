//
//  GenericTableViewsAppDelegate.m
//  GenericTableViews
//
//  Created by Craig Hockenberry on 4/28/09.
//  Copyright The Iconfactory 2009. All rights reserved.
//

#import "GenericTableViewsAppDelegate.h"
#import "RootViewController.h"


@implementation GenericTableViewsAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {

/*
	If this were a real UI, it would be annoying as hell. We're just proving that the values
	changed by SampleViewController when using the IFPreferencesModel are persisted and available
	to the app.
*/
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	NSString *message = [NSString stringWithFormat:@"Choice = %@\nText = %@\nSwitch = %@",
			[userDefaults objectForKey:@"sampleChoice"],
			[userDefaults objectForKey:@"sampleText"],
			[userDefaults objectForKey:@"sampleSwitch"]];
			
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Settings Values" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alertView show];

	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
