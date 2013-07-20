//
//  HSFContact.h
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;

@interface HSFContact : NSObject

- (id) initWithFMResultSet: (FMResultSet *)myResultSet;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *contactType;
@property (nonatomic, strong) NSString *phoneNumber;

// Dictionary with NSNumber bool for preferences
@property (nonatomic, strong) NSDictionary *additionalInfo;

@end
