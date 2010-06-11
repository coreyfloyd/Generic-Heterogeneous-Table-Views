//
//  GenericTableViewsAppDelegate.h
//  GenericTableViews
//
//  Created by Craig Hockenberry on 4/28/09.
//  Copyright The Iconfactory 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenericTableViewsAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

