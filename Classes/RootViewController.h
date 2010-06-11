//
//  RootViewController.h
//  GenericTableViews
//
//  Created by Craig Hockenberry on 4/28/09.
//  Copyright The Iconfactory 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IFTemporaryModel;

@interface RootViewController : UIViewController
{
	IFTemporaryModel *formModel;
}

@property (nonatomic, retain, readonly) IFTemporaryModel *formModel;

- (IBAction)showSettings:(id)sender;
- (IBAction)showForm:(id)sender;
- (IBAction)showCredits:(id)sender;

@end
