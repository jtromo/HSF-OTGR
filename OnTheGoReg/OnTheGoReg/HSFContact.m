//
//  HSFContact.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFContact.h"
#import "FMResultSet.h"

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

- (id) initWithFMResultSet: (FMResultSet *)myResultSet
{
    if (!(self = [super init])) {
        return nil;
    }
    
    // Gather info from database result
    NSString * firstName = [myResultSet stringForColumn:kCacheColumn_firstName];
    _firstName = firstName;
    NSString * lastName = [myResultSet stringForColumn:kCacheColumn_lastName];
    _lastName = lastName;
    NSString * emailAddress = [myResultSet stringForColumn:kCacheColumn_emailAddress];
    _email = emailAddress;
    NSString * cellPhoneNumber = [myResultSet stringForColumn:kCacheColumn_cellPhoneNumber];
    _phoneNumber = cellPhoneNumber;
    NSString * contactType = [myResultSet stringForColumn:kCacheColumn_contactType];
    _contactType = contactType;
   
    
#warning JR: stubbed on additional info
    return self;
    
}

@end
