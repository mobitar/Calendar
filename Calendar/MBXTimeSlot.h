//
//  MBXTimeSlot.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBXTimeSlot : NSObject

@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) NSTimeZone *timeZone;

- (NSString *)startTime;

/**
 i.e
 startTime: "8:00 am"
 endTime: "10:00 pm"
 timezone: "America/Chicago"
 */
+ (NSArray *)createArrayOfTimeSlotsStartingAtTime:(NSString *)startTime
                                          endTime:(NSString *)endTime
                                       inTimezone:(NSTimeZone *)timeZone
                                     slotDuration:(NSTimeInterval)duration
                                      inDayOfDate:(NSDate *)date;

+ (NSArray *)createArrayOfTimeSlotsForEverydayInMonthOfDate:(NSDate *)date
                                             startingAtTime:(NSString *)startTime
                                                    endTime:(NSString *)endTime
                                                 inTimeZone:(NSTimeZone *)timeZone
                                               slotDuration:(NSTimeInterval)duration;

+ (NSArray *)timeSlotsByFilteringSlots:(NSArray *)slots toMonth:(NSInteger)month day:(NSInteger)day;

@end
