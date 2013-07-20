//
//  NSDate+Extensions.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

#define SECONDS_PER_DAY 86400
#define JULIAN_DAY_OF_ZERO_UNIX_TIME 2440587.5

- (NSTimeInterval) julianDay
{
    NSTimeInterval julianDate = ([self timeIntervalSince1970]/SECONDS_PER_DAY) + JULIAN_DAY_OF_ZERO_UNIX_TIME;
    return julianDate;
}

@end
