//
//  IFTextCellController.m
//  Thunderbird
//
//	Created by Craig Hockenberry on 1/29/09.
//	Copyright 2009 The Iconfactory. All rights reserved.
//

#import "IFTextCellController.h"

#import	"IFControlTableViewCell.h"

@implementation IFTextCellController

@synthesize updateTarget, updateAction;

@synthesize keyboardType, autocapitalizationType, autocorrectionType, secureTextEntry, indentationLevel;

@synthesize returnKey;


//
// init
//
// Init method for the object.
//
- (id)initWithLabel:(NSString *)newLabel andPlaceholder:(NSString *)newPlaceholder atKey:(NSString *)newKey inModel:(id<IFCellModel>)newModel
{
	self = [super init];
	if (self != nil)
	{
		label = [newLabel retain];
		placeholder = [newPlaceholder retain];
		key = [newKey retain];
		model = [newModel retain];

		keyboardType = UIKeyboardTypeAlphabet;
        returnKey = UIReturnKeyDone;
		autocapitalizationType = UITextAutocapitalizationTypeNone;
		autocorrectionType = UITextAutocorrectionTypeNo;
		secureTextEntry = NO;
		indentationLevel = 0;
	}
	return self;
}

//
// dealloc
//
// Releases instance memory.
//
- (void)dealloc
{
	[label release];
	[placeholder release];
	[key release];
	[model release];
	
	[super dealloc];
}

//
// tableView:cellForRowAtIndexPath:
//
// Returns the cell for a given indexPath.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"TextDataCell";
	
    IFControlTableViewCell *cell = (IFControlTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil)
	{
		cell = [[[IFControlTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
	
	cell.font = [UIFont boldSystemFontOfSize:17.0f];
	cell.text = label;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.indentationLevel = indentationLevel;

	// NOTE: The documentation states that the indentation width is 10 "points". It's more like 20
	// pixels and changing the property has no effect on the indentation. We'll use 20.0f here
	// and cross our fingers that this doesn't screw things up in the future.
	
	CGFloat viewWidth;
	if (! label || [label length] == 0)
	{
		// there is no label, so use the entire width of the cell
		
		viewWidth = 280.0f - (20.0f * indentationLevel);
	}
	else
	{
		// use about half of the cell (this matches the metrics in the Settings app)

		viewWidth = 150.0f;
	}
		
	// add a text field to the cell
	CGRect frame = CGRectMake(0.0f, 0.0f, viewWidth, 21.0f);
	UITextField *textField = [[UITextField alloc] initWithFrame:frame];
	[textField addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventEditingChanged];
	[textField setDelegate:self];
	NSString *value = [model objectForKey:key];
	[textField setText:value];
	[textField setFont:[UIFont systemFontOfSize:17.0f]];
	[textField setBorderStyle:UITextBorderStyleNone];
	[textField setPlaceholder:placeholder];
	[textField setReturnKeyType:returnKey];
	[textField setKeyboardType:keyboardType];
	[textField setAutocapitalizationType:autocapitalizationType];
	[textField setAutocorrectionType:autocorrectionType];
	[textField setBackgroundColor:[UIColor whiteColor]];
	[textField setTextColor:[UIColor colorWithRed:0.20f green:0.31f blue:0.52f alpha:1.0f]];
	[textField setSecureTextEntry:secureTextEntry];
	cell.view = textField;
	[textField release];
	
    return cell;
}

- (void)updateValue:(id)sender
{
	// update the model with the text change
	[model setObject:[sender text] forKey:key];
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{	
	if (updateTarget && [updateTarget respondsToSelector:updateAction])
	{
		// action is peformed after keyboard has had a chance to resign
		[updateTarget performSelector:updateAction withObject:textField];
	}

	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// hide the keyboard
	[textField resignFirstResponder];
	
	return YES;
}

@end
