//
//  FJSTextCellController.h
//  FJSCode
//
//  Created by Corey Floyd on 10/29/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IFCellController.h"
#import "IFCellModel.h"

@interface FJSTextCellController : NSObject <IFCellController, UITextFieldDelegate> 
{
    UITableViewCell *cell;
    
	NSString *label;
	NSString *placeholder;
	id<IFCellModel> model;
	NSString *key;
    
    UIImage *placeholderImage;
    NSString *imageKey;
	
    UITextField* editField;
    
	SEL updateAction;
	id updateTarget;
    
    SEL beginEditingAction;
	id beginEditingTarget;
    
	UIKeyboardType keyboardType;
    UIReturnKeyType returnKey;
	UITextAutocapitalizationType autocapitalizationType;
	UITextAutocorrectionType autocorrectionType;
    BOOL adjustsFontSizeToWidth;
	BOOL secureTextEntry;
	NSInteger indentationLevel;
    float fontSize;
    
    BOOL editing;
    
}
@property(nonatomic,retain)UITableViewCell *cell;
@property (nonatomic, assign) SEL updateAction;
@property (nonatomic, assign) id updateTarget;
@property(nonatomic,assign)SEL beginEditingAction;
@property(nonatomic,assign)id beginEditingTarget;

@property(nonatomic,retain)UITextField *editField;
@property(nonatomic,retain)UIImage *placeholderImage;
@property(nonatomic,retain)NSString *imageKey;


@property (nonatomic, assign) UIKeyboardType keyboardType;
@property(nonatomic,assign)UIReturnKeyType returnKey;
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
@property(nonatomic,assign)BOOL adjustsFontSizeToWidth;
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) NSInteger indentationLevel;
@property(nonatomic,assign)float fontSize;

@property(nonatomic, getter=isEditing) BOOL editing;

- (id)initWithLabel:(NSString *)newLabel andPlaceholder:(NSString *)newPlaceholder atKey:(NSString *)newKey inModel:(id<IFCellModel>)newModel;
- (id)initWithLabel:(NSString *)newLabel 
     andPlaceholder:(NSString *)newPlaceholder 
              atKey:(NSString *)newKey
   imagePlaceHolder:(UIImage  *)image
           imageKey:(NSString *)imageKey
            inModel:(id<IFCellModel>)newModel;


@end
