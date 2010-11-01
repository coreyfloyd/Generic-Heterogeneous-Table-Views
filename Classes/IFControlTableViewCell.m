//
//  IFControlTableViewCell.m
//  Thunderbird
//
//  Created by Craig Hockenberry on 4/12/08.
//  Copyright 2008 The Iconfactory. All rights reserved.
//

#import "IFControlTableViewCell.h"


#define kCellHorizontalOffset 8.0f

@implementation IFControlTableViewCell

@synthesize view;

- (id)initWithFrame:(CGRect)aRect reuseIdentifier:(NSString *)identifier
{
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier])
	{
		//self.hidesAccessoryWhenEditing = NO;
	}
	return self;
}

- (void)setView:(UIView *)newView
{
	[view removeFromSuperview];

	view = [newView retain];
	[self.contentView addSubview:view];
	
	[self layoutSubviews];
}

- (void)layoutSubviews
{	
	[super layoutSubviews];
    CGRect contentRect = [self.contentView bounds];
	CGRect viewRect = [view bounds];

	CGRect viewFrame = CGRectMake(contentRect.size.width - viewRect.size.width - kCellHorizontalOffset,
			floorf((contentRect.size.height - viewRect.size.height) / 2.0f),
			viewRect.size.width,
			viewRect.size.height);
	view.frame = viewFrame;
}

- (void)dealloc
{
	[view release];
	
    [super dealloc];
}

@end
