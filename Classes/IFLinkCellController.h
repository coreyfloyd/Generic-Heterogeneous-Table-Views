//
//  IFLinkCellController.h
//  Thunderbird
//
//	Created by Craig Hockenberry on 1/29/09.
//	Copyright 2009 The Iconfactory. All rights reserved.
//
//  Based on work created by Matt Gallagher on 27/12/08.
//  Copyright 2008 Matt Gallagher. All rights reserved.
//	For more information: http://cocoawithlove.com/2008/12/heterogeneous-cells-in.html
//

#import <UIKit/UIKit.h>

#import "IFCellController.h"
#import "IFCellModel.h"

@interface IFLinkCellController : NSObject <IFCellController>
{
	NSString *label;
	Class controllerClass;
	id<IFCellModel> model;
}

- (id)initWithLabel:(NSString *)newLabel usingControllerClass:(Class)newControllerClass inModel:(id<IFCellModel>)newModel;

@end
