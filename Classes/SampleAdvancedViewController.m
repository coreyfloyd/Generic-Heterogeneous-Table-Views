//
//  SampleAdvancedViewController.m
//  Thunderbird
//
//  Created by Craig Hockenberry on 1/31/09.
//  Copyright 2009 The Iconfactory. All rights reserved.
//

//#import "Configuration.h"

#import "SampleAdvancedViewController.h"

#import "IFLinkCellController.h"
#import "IFButtonCellController.h"
#import "IFSwitchCellController.h"
#import "IFTextCellController.h"
#import	"IFChoiceCellController.h"

#import "IFNamedImage.h"


@implementation SampleAdvancedViewController

/*
	The generic table view controllers can be used either in portrait of landscape orientations.
	
	Of course, you'll want to be careful to use labels and values that are sized correctly for the
	type of orientation you are using.
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)constructTableGroups
{
	IFButtonCellController *buttonCell = nil;
	IFSwitchCellController *switchCell = nil;
	IFTextCellController *textCell = nil;
	IFChoiceCellController *choiceCell = nil;

	NSMutableArray *textCells = [NSMutableArray array];

/*
	Once the text cell has been allocated, you can set various properties that configure how
	the keyboard will display and how autocorrection is done. In this example, a numeric keyboard
	is specified:
*/
	textCell = [[[IFTextCellController alloc] initWithLabel:@"Number" andPlaceholder:@"58008" atKey:@"number" inModel:model] autorelease];
	textCell.keyboardType = UIKeyboardTypeNumberPad;
	[textCells addObject:textCell];

/*
	Sometimes, it's useful to know when the text in a field has changed. You can specify a updateTarget
	and updateAction to validate input on the field. This example also shows how to configure
	the keyboard for secure text entry:
*/
	textCell = [[[IFTextCellController alloc] initWithLabel:@"Password" andPlaceholder:@"sekret" atKey:@"password" inModel:model] autorelease];
	textCell.updateTarget = self;
	textCell.updateAction = @selector(validateInput:);
	textCell.secureTextEntry = YES;
	[textCells addObject:textCell];

/*
	The labels for the text cell can be indented. This can be useful to indicate hierarchy:
*/
	textCell = [[[IFTextCellController alloc] initWithLabel:@"Indented" andPlaceholder:@"Label and Indented" atKey:@"textWithLabelIndented" inModel:model] autorelease];
	textCell.indentationLevel = 1;
	[textCells addObject:textCell];

/*
	An empty label can be used if you want to fill the entire cell row with text:
*/
	textCell = [[[IFTextCellController alloc] initWithLabel:@"" andPlaceholder:@"No Label" atKey:@"textWithNoLabel" inModel:model] autorelease];
	[textCells addObject:textCell];

/*
	And a label-less cell can also be indented:
*/
	textCell = [[[IFTextCellController alloc] initWithLabel:@"" andPlaceholder:@"No Label and Indented" atKey:@"textWithNoLabelIndented" inModel:model] autorelease];
	textCell.indentationLevel = 1;
	[textCells addObject:textCell];

/*
	See the IFTextCellController.h file to see all the properties that are supported by this cell.
*/

	NSMutableArray *switchCells = [NSMutableArray array];

/*
	If you want to know when a switch value has changed, you can attach an updateAction to an
	updateTarget in the switch cell:
*/
	switchCell = [[[IFSwitchCellController alloc] initWithLabel:@"Check Switch" atKey:@"checkSwitch" inModel:model] autorelease];
	switchCell.updateTarget = self;
	switchCell.updateAction = @selector(checkSwitch:);
	[switchCells addObject:switchCell];

/*
	Often, during the course of development, requirements for settings and forms change based on
	user feedback. The following code shows how simple it is to change a setting from a switch to a
	choice:
*/
#define USE_SWITCH_CELL 1

#if USE_SWITCH_CELL
	switchCell = [[[IFSwitchCellController alloc] initWithLabel:@"BE AWESOME" atKey:@"CHOCKLOCKENABLED" inModel:model] autorelease];
	[switchCells addObject:switchCell];
#else
	NSArray *awesomeChoices = [NSArray arrayWithObjects:@"LOSER", @"CHOCKLOCK", nil];
	choiceCell = [[[IFChoiceCellController alloc] initWithLabel:@"BE AWESOME" andChoices:awesomeChoices atKey:@"CHOCKLOCKENABLED" inModel:model] autorelease];
	choiceCell.footerNote = @"CHOOSE WISELY";
	[switchCells addObject:choiceCell];
#endif

/*
	This is an example of how the current environment can be used to enable or disable cells within
	the view. In this case, we're detecting the current device and if it's an iPhone, another switch
	cell is added to the group.
	
	This technique can be used for other cell types or even an entire cell group:
*/
	BOOL canVibrate = [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"];
	if (canVibrate)
	{
		switchCell = [[[IFSwitchCellController alloc] initWithLabel:@"Vibrate" atKey:@"vibrate" inModel:model] autorelease];
		[switchCells addObject:switchCell];
	}
	

	NSMutableArray *buttonCells = [NSMutableArray array];

/*
	By default a button with centered text is displayed:
	
	NOTE: The button is displayed incorrectly in the 2.2 firmware. This problem was fixed in 2.2.1.
*/
	buttonCell = [[[IFButtonCellController alloc] initWithLabel:@"Regular Button" withAction:@selector(pressButton:) onTarget:self] autorelease];
	[buttonCells addObject:buttonCell];

/*
	Other accessory types can be used for the cell row. The disclosure button is the most appropriate:
*/
	buttonCell = [[[IFButtonCellController alloc] initWithLabel:@"Disclosure Button" withAction:@selector(pressButton:) onTarget:self] autorelease];
	buttonCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	[buttonCells addObject:buttonCell];


	NSMutableArray *choiceCells = [NSMutableArray array];

/*
	Choices are not limited to just strings. In this example, we're using UIImages.
	
	We've also defined an updateTarget and updateAction so we know when the choice has changed. This
	can be used to give the user feedback (such as previewing a notification sound setting.)
*/
	NSArray *imageChoices = [NSArray arrayWithObjects:
			[UIImage imageNamed:@"red.png"],
			[UIImage imageNamed:@"green.png"],
			[UIImage imageNamed:@"blue.png"],
			nil];
	choiceCell = [[[IFChoiceCellController alloc] initWithLabel:@"Color" andChoices:imageChoices atKey:@"imageWithLabel" inModel:model] autorelease];
	choiceCell.updateTarget = self;
	choiceCell.updateAction = @selector(showChoice:);
	[choiceCells addObject:choiceCell];

/*
	Named images are much more user friendly. The image is displayed in the cell along with a name.
	
	This example also shows how a footerNote can be added to the choice. These notes can be used to
	guide the user in their choice:
*/
	NSArray *namedImageChoices = [NSArray arrayWithObjects:
			[IFNamedImage image:[UIImage imageNamed:@"red.png"] withName:@"Red"],
			[IFNamedImage image:[UIImage imageNamed:@"green.png"] withName:@"Green"],
			[IFNamedImage image:[UIImage imageNamed:@"blue.png"] withName:@"Blue"],
			nil];
	choiceCell = [[[IFChoiceCellController alloc] initWithLabel:@"Color" andChoices:namedImageChoices atKey:@"namedImageWithLabel" inModel:model] autorelease];
	choiceCell.footerNote = @"THIS IS THE MATRIX CHOOSE YOUR PILL";
	[choiceCells addObject:choiceCell];

/*
	If the label is empty, the choice will be displayed in the label position:
*/
	choiceCell = [[[IFChoiceCellController alloc] initWithLabel:@"" andChoices:namedImageChoices atKey:@"namedImageWithoutLabel" inModel:model] autorelease];
	choiceCell.footerNote = @"HAHAHA THERES NO CYAN MAGENTA YELLOW AND BLACK SPELLED WITH A K";
	[choiceCells addObject:choiceCell];

	
	tableGroups = [[NSArray arrayWithObjects:textCells, switchCells, buttonCells, choiceCells, nil] retain];
	tableHeaders = [[NSArray arrayWithObjects:@"Text Cells", @"Switch Cells", @"Button Cells", @"Choice Cells", @"", nil] retain];	
	tableFooters = [[NSArray arrayWithObjects:@"", @"", @"", @"", @"", nil] retain];	
}

#pragma mark Actions

- (void)validateInput:(id)sender
{
/*
	Check the value in the model and update it as necessary:
*/
	NSString *passwordValue = [model objectForKey:@"password"];
	if (! [passwordValue isEqualToString:@"CHOCKLOCK"])
	{
		UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Validation Failed" message:@"YOU FAIL BECAUSE YOU DONT TRUST THE CHOCKLOCK" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alertView show];
		
		[model setObject:@"LOSER" forKey:@"password"];
	}

/*
	NOTE: Validating input is not for the faint of heart. The problem is that validation may need
	to occur as the view is being popped off the stack: this happens if the cursor is in the field
	being validated and the user taps the back button (to return to the previous view controller.)
	
	You can see this effect in the validation above: the alert view is presented in the parent view
	controller, not in the view controller where the error occured.
	
	This method will be called just as the text view is being removed from the superview. If the
	validation is an asynchronous process, you need to preventing this from happening. How to do this
	is beyond the scope of this example: the only hint I'll give is [self retain].
	
	A better approach would be to use a Save/Cancel interface and do all your validation at
	the time the user taps Save.
*/
}

- (void)checkSwitch:(id)sender
{
	BOOL checkSwitchValue = [[model objectForKey:@"checkSwitch"] boolValue];
	
	NSString *message = [NSString stringWithFormat:@"YOU JUST KEEP GETTING MORE AWESOME YOU TURNED THE SWITCH %@", (checkSwitchValue ? @"ON" : @"OFF")];
	
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Switch Changed" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alertView show];
}

- (void)showChoice:(id)sender
{
	NSInteger imageWithLabelValue = [[model objectForKey:@"imageWithLabel"] intValue];
	
	NSString *message = [NSString stringWithFormat:@"%d WAS AN AWESOME CHOICE BY YOU BECAUSE YOUR AWESOME", imageWithLabelValue];
	
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Choice Changed" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alertView show];
}

- (void)pressButton:(id)sender
{
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Button Pressed" message:@"YOU LIKE PRESSING BUTTONS YOU SHOULD TRY THE CHOCKLOCK YOUD LIKE IT" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alertView show];
}


@end

