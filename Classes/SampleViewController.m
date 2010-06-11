//
//  SampleViewController.m
//  Thunderbird
//
//  Created by Craig Hockenberry on 1/31/09.
//  Copyright 2009 The Iconfactory. All rights reserved.
//

#import "SampleViewController.h"

#import "SampleAdvancedViewController.h"

#import "IFLinkCellController.h"
#import "IFButtonCellController.h"
#import "IFSwitchCellController.h"
#import "IFTextCellController.h"
#import	"IFChoiceCellController.h"
#import	"IFValueCellController.h"


@implementation SampleViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)constructTableGroups
{
/*
	This is the heart of the view controller. If you're familiar with domain specific languages (such
	as those used in Ruby), I've tried to do something similar with Objective-C and Cocoa.
	
	Every generic table view controller has three UI components:
	
	1. The groups (each of which is defined by a collection of cells)
	2. The headers (one for each group)
	3. The footers (one for each group)
	
	This view controller also includes a model which is provided to each cell (so view changes can
	update the model.)
*/

/*
	These are the types of cells that are supported by the view controller. Each will be demonstrated
	below. More complex uses of each type is shown in SampleAdvancedViewController.
*/
	IFLinkCellController *linkCell = nil;
	IFButtonCellController *buttonCell = nil;
	IFSwitchCellController *switchCell = nil;
	IFTextCellController *textCell = nil;
	IFChoiceCellController *choiceCell = nil;
	IFValueCellController *valueCell = nil;

/*
	Start by defining a collection where each cell in the group will be stored:
*/
	NSMutableArray *sampleCells = [NSMutableArray array];

/*
	A choice cell lets the user pick from a collection of objects. These object can be NSStrings,
	UIImages or IFNamedImages. In this example, we're using a simple array of strings:
*/
	NSArray *choices = [NSArray arrayWithObjects:
			@"CHOCK", @"Large", @"Medium", @"Small", nil];
/*
	Create an instance of the choice cell controller by giving the cell a label, the list of choices,
	a key, and a model. Any changes to the choice by the user will cause the object identified by the
	key to be updated in the model.
	
	If the user chooses "Medium" in the UI, an NSNumber with a value of 2 (representing the third
	choice) will be placed in the model using the key "sampleChoice".
*/
	choiceCell = [[[IFChoiceCellController alloc] initWithLabel:@"Choice" andChoices:choices atKey:@"sampleChoice" inModel:model] autorelease];
/*
	Add the choice to the cells for this group:
*/
	[sampleCells addObject:choiceCell];

/*
	Similarly, a cell can be created for text data. In this case, we'll be storing NSStrings in
	the model with the key "sampleText":
*/
	textCell = [[[IFTextCellController alloc] initWithLabel:@"Text" andPlaceholder:@"Placeholder" atKey:@"sampleText" inModel:model] autorelease];
	[sampleCells addObject:textCell];

/*
	Boolean values can be represented as switches. An NSNumber is stored in the model with the key
	named "sampleSwitch":
*/
	switchCell = [[[IFSwitchCellController alloc] initWithLabel:@"Switch" atKey:@"sampleSwitch" inModel:model] autorelease];
	[sampleCells addObject:switchCell];

/*
	Value cells can be used to as an informational display. The values can't be changed: they use the
	key (in this example, "value") to get the value from the model. Value cells can display an NSString
	or an NSNumber.
*/
	valueCell = [[[IFValueCellController alloc] initWithLabel:@"Value" atKey:@"sampleValue" inModel:model] autorelease];
	[sampleCells addObject:valueCell];


/*
	Link cells are used to load another view controller. In this example, it's used to load an
	"Advanced" view with additional groups and cells.
	
	When the new view controller is pushed onto the navigation stack, it's also provided with the
	model of the current view controller:
*/
	NSMutableArray *linkCells = [NSMutableArray array];
	
	linkCell = [[[IFLinkCellController alloc] initWithLabel:@"Advanced" usingControllerClass:[SampleAdvancedViewController class] inModel:model] autorelease];
	[linkCells addObject:linkCell];

/*
	It's sometimes convenient to put a simple button in your settings or forms. The button cell
	can be used for this purpose. In this example, clicking the button will call the buttonAction:
	method below:
*/
	NSMutableArray *buttonCells = [NSMutableArray array];

	buttonCell = [[[IFButtonCellController alloc] initWithLabel:@"Button Cell" withAction:@selector(buttonAction:) onTarget:self] autorelease];
	[buttonCells addObject:buttonCell];

/*
	Once all the groups have been defined, a collection is created that allows the generic table view
	controller to construct the views, manage user input, and update the model(s):
*/
	tableGroups = [[NSArray arrayWithObjects:sampleCells, linkCells, buttonCells, nil] retain];
/*
	In this example, the first group of cells gets a header ("Sample Cells") while the last two do not
	because an empty string is defined in the collection.
*/
	tableHeaders = [[NSArray arrayWithObjects:@"Sample Cells", @"", @"", nil] retain];	
/*
	Similarly, the first and second groups get a footer with additional information for the user. The
	last group does not: this time because a NSNull value is used:
*/
	tableFooters = [[NSArray arrayWithObjects:@"Samples of the supported table cells types\nare shown above. Use the Advanced view\nto explore each type in more detail.", @"A link cell lets you load another view\ncontroller using the same model as the\ncurrent view controller.", [NSNull null], nil] retain];	
/*
	RANT: I'm getting really sick and tired of putting newlines in table footers so that the margins
	look nice. If anyone at Apple is reading this, please fix rdar://problem/5863115 Thank you!
*/
}

#pragma mark Actions

- (void)buttonAction:(id)sender
{
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Button Pressed" message:@"YOU PRESSED A BUTTON SO YOUR AWESOME NOW" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alertView show];
}

@end

