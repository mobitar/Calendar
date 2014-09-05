//
//  MBXServer.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBXServer : NSObject

- (NSArray *)getAvailableTimeSlotsForMonth:(NSInteger)month;

@end
