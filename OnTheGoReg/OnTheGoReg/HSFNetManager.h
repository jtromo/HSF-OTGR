//
//  HSFNetManager.h
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSFContact;

@interface HSFNetManager : NSObject

+ (HSFNetManager *) sharedInstance;
- (void)syncWithViewController: (UIViewController *)vc;
@property (nonatomic, strong) HSFContact *currentContact;

@end
