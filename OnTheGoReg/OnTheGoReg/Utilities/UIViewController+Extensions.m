//
//  UIViewController+Extensions.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "UIViewController+Extensions.h"

@implementation UIViewController (Extensions)

// On action, dismisses all keyboards for the text fields
- (IBAction) dismissKeyboardAction: (id)sender
{
    // dismiss keyboard
    [self.view endEditing:YES];
}

@end
