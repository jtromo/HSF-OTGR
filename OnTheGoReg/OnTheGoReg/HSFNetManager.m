//
//  HSFNetManager.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFNetManager.h"
#import "HSFContact.h"

static HSFNetManager * _sharedInstance;

@implementation HSFNetManager

+ (HSFNetManager *) sharedInstance
{
    @synchronized(self) {
        if (!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
        }
        
        return _sharedInstance;
    }
}

- (id) init
{
    if (!(self = [super init])) {
        return nil;
    }
    
    return self;
}


@end
