//
//  HSFContact.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFContact.h"

@implementation HSFContact

- (void)commonInit
{
    // Start with all nos
    _additionalInfo = kAddtionalInfoDict;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

@end
