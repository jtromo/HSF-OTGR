//
//  HSFDatabasController.h
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSFContact;

@interface HSFDatabasController : NSObject

+ (HSFDatabasController *) sharedController;
- (BOOL) insertContact: (HSFContact *)myContact;
- (NSArray *) pendingUploads;
- (NSString *) pendingUploadsToCSV;
- (BOOL) deleteAllContacts;

@end
