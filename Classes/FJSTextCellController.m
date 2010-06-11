//
//  FJSTextCellController.m
//  FJSCode
//
//  Created by Corey Floyd on 10/29/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

#import "FJSTextCellController.h"
#import	"IFControlTableViewCell.h"

@implementation FJSTextCellController

@synthesize updateTarget, updateAction;

@synthesize keyboardType, autocapitalizationType, autocorrectionType, secureTextEntry, indentationLevel;

@synthesize returnKey;

@synthesize adjustsFontSizeToWidth;

@synthesize fontSize;

@synthesize beginEditingAction;
@synthesize beginEditingTarget;

@synthesize editField;

@synthesize cell;

@synthesize placeholderImage;
@synthesize imageKey;



@synthesize editing;


//
// dealloc
//
// Releases instance memory.
//
- (void)dealloc
{
    
    self.placeholderImage = nil;
    self.imageKey = nil;
    self.cell = nil;
	[label release];
	[placeholder release];
	[key release];
	[model release];
    self.editField = nil;
	[super dealloc];
}


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
        self.editing = NO;
        
		label = [newLabel retain];
		placeholder = [newPlaceholder retain];
		key = [newKey retain];
		model = [newModel retain];
        
		keyboardType = UIKeyboardTypeAlphabet;
        returnKey = UIReturnKeyDone;
		autocapitalizationType = UITextAutocapitalizationTypeNone;
		autocorrectionType = UITextAutocorrectionTypeNo;
		secureTextEntry = NO;
        adjustsFontSizeToWidth = NO;
		indentationLevel = 0;
        fontSize = 17.0;
	}
	return self;
}


- (id)initWithLabel:(NSString *)newLabel 
     andPlaceholder:(NSString *)newPlaceholder 
              atKey:(NSString *)newKey
   imagePlaceHolder:(UIImage  *)newImagePlaceholder
           imageKey:(NSString *)newImageKey
            inModel:(id<IFCellModel>)newModel
{
    
    
    [self initWithLabel:newLabel andPlaceholder:newPlaceholder atKey:newKey inModel:newModel];
    
    self.imageKey = newImageKey;
    self.placeholderImage = newImagePlaceholder;
    
    return self;
}



//
// tableView:cellForRowAtIndexPath:
//
// Returns the cell for a given indexPath.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"TextDataCell";
	
    IFControlTableViewCell *newCell = (IFControlTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (newCell == nil)
	{
        newCell = [[[IFControlTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];

    }
    
    self.cell = newCell;
    
	newCell.textLabel.text = label;
	newCell.selectionStyle = UITableViewCellSelectionStyleNone;
	newCell.indentationLevel = indentationLevel;
    
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
    [textField setAdjustsFontSizeToFitWidth:adjustsFontSizeToWidth];
	[textField setSecureTextEntry:secureTextEntry];
    [textField setTextAlignment:UITextAlignmentRight];
	newCell.view = textField;
    self.editField = textField;
	[textField release];
    
    UIImage* theImage = [model objectForKey:imageKey];
    
    if(theImage){
        
        newCell.imageView.image = theImage;

    }else if(self.placeholderImage){
        
        newCell.imageView.image = self.placeholderImage;

    }
    
    
    newCell.detailTextLabel.text = value;
    
    if(self.editing){
        
        textField.alpha = 1.0;
        textField.userInteractionEnabled = YES;

        
    }else {
        textField.alpha = 0.0;
        textField.userInteractionEnabled = NO;

    }

	
    return newCell;
}

- (void)setEditing:(BOOL)flag{
    
    editing = flag;
    
    if(editing){
        
        self.editField.alpha = 1.0;
        self.editField.userInteractionEnabled = YES;
        
    }else {
        
        self.editField.alpha = 0.0;
        self.editField.userInteractionEnabled = NO;
        self.cell.detailTextLabel.text = [model objectForKey:key];
    }
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

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (beginEditingTarget && [beginEditingTarget respondsToSelector:beginEditingAction])
	{
		// action is peformed after keyboard has had a chance to resign
		[beginEditingTarget performSelector:beginEditingAction withObject:textField];
	}
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// hide the keyboard
	[textField resignFirstResponder];
	
	return YES;
}


@end
