//
//  IFButtonCellController.m
//  Thunderbird
//
//	Created by Craig Hockenberry on 1/29/09.
//	Copyright 2009 The Iconfactory. All rights reserved.
//

#import "IFButtonCellController.h"

#import "IFControlTableViewCell.h"

@implementation IFButtonCellController

@synthesize accessoryType;

//
// init
//
// Init method for the object.
//
- (id)initWithLabel:(NSString *)newLabel withAction:(SEL)newAction onTarget:(id)newTarget;
{
	self = [super init];
	if (self != nil)
	{
		label = [newLabel retain];
		action = newAction;
		target = newTarget;
		
		accessoryType = UITableViewCellAccessoryNone;
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

	[super dealloc];
}

//
// tableView:didSelectRowAtIndexPath:
//
// Handle row selection
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (accessoryType != UITableViewCellAccessoryDetailDisclosureButton)
	{
		if (target && [target respondsToSelector:action])
		{
			[target performSelector:action withObject:self];
		}
		
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

//
// tableView:cellForRowAtIndexPath:
//
// Returns the cell for a given indexPath.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"ButtonDataCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
	
	cell.text = label;
	cell.font = [UIFont boldSystemFontOfSize:17.0f];
	cell.accessoryType = accessoryType;
	cell.target = target;
	cell.accessoryAction = action;
	if (accessoryType == UITableViewCellAccessoryDetailDisclosureButton)
	{
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textAlignment = UITextAlignmentLeft;
	}
	else
	{
		// NOTE: In the 2.2 firmware, the alignment of the text on the button is wrong. Since the problem was
		// only visual and was fixed in the 2.2.1 firmware, we're just going live with it.
		cell.textAlignment = UITextAlignmentCenter;
	}
	
    return cell;
}

@end
