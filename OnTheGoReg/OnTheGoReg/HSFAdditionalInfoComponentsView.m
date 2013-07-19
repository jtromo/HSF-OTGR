//
//  HSFAdditionalInfoComponents.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFAdditionalInfoComponentsView.h"
#import "HSFCheckBox.h"
#import "HSFNetManager.h"
#import "HSFContact.h"

@interface HSFAdditionalInfoComponentsView ()

@end

@implementation HSFAdditionalInfoComponentsView

- (void)prepareComponents
{
    _infoLabels = @[_infoLabel1, _infoLabel2, _infoLabel3, _infoLabel4, _infoLabel5, _infoLabel6, _infoLabel7, _infoLabel8, _infoLabel9, _infoLabel10, _infoLabel11];
    _checkboxes = @[_checkbox1, _checkbox2, _checkbox3, _checkbox4, _checkbox5, _checkbox6, _checkbox7, _checkbox8, _checkbox9, _checkbox10, _checkbox11];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// Vetrifies and populates using checkboxes
- (BOOL)populateWithCheckboxes
{
    BOOL isVerified = NO;
    
    [self prepareComponents];
    
    HSFContact *currentContact = [[HSFNetManager sharedInstance] currentContact];
    NSMutableDictionary *additionalInfo = [[NSMutableDictionary alloc] init];
    [additionalInfo setDictionary:currentContact.additionalInfo];
    
    NSInteger index = 0;
    for (HSFCheckBox *checkbox in _checkboxes) {
        UILabel * label = [_infoLabels objectAtIndex:index];
        // Cooresponding key for checkbox
        NSString *key = label.text;
        
        BOOL isChecked = checkbox.isChecked;
        
        // Set value for key
        [additionalInfo setObject:[NSNumber numberWithBool:isChecked] forKey:key];
        
        if (isChecked) {
            isVerified = YES;
        }
        index++;
    }
    // Set to the modified dictionary
    [currentContact setAdditionalInfo:additionalInfo];
    
    if (isVerified) {
        [_errorLbl setHidden:YES];
    } else {
        [_errorLbl setHidden:NO];
    }
    return isVerified;
}

- (void)populateLabels
{
    // Do any additional setup after loading the view.
    [_infoLabel1 setText:kLabel1];
    [_infoLabel2 setText:kLabel2];
    [_infoLabel3 setText:kLabel3];
    [_infoLabel4 setText:kLabel4];
    [_infoLabel5 setText:kLabel5];
    [_infoLabel6 setText:kLabel6];
    [_infoLabel7 setText:kLabel7];
    [_infoLabel8 setText:kLabel8];
    [_infoLabel9 setText:kLabel9];
    [_infoLabel10 setText:kLabel10];
    [_infoLabel11 setText:kLabel11];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
