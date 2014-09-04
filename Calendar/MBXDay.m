//
//  MBXDay.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXDay.h"

@implementation MBXDay

- (BOOL)isEqual:(id)object
{
    if([object isKindOfClass:[self class]] == NO) {
        return NO;
    }
    
    MBXDay *otherDay = object;
    return self.day == otherDay.day && self.month == otherDay.month && self.year == otherDay.year;
}

- (NSUInteger)hash
{
    return [[NSString stringWithFormat:@"%i%i%i", self.day, self.month, self.year] hash];
}

@end
