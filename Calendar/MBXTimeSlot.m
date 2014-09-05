//
//  MBXTimeSlot.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXTimeSlot.h"
#import "NSDate+Calendar.h"

@implementation MBXTimeSlot

- (NSString *)description
{
    return [NSString stringWithFormat:@"startDate:%@ endDate:%@", self.startDate, self.endDate];
}

- (BOOL)isEqual:(id)object
{
    if([object isKindOfClass:[self class]] == NO) {
        return NO;
    }
    
    MBXTimeSlot *otherSlot = object;
    return [otherSlot.startDate compare:self.startDate] == NSOrderedSame && [otherSlot.endDate compare:self.endDate] == NSOrderedSame;
}

- (NSUInteger)hash
{
    return @([self.startDate timeIntervalSinceNow] + [self.endDate timeIntervalSinceNow]).hash;
}

static NSString *const MBXTimeFormat = @"h:mm a";

- (NSString *)startTime
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:MBXTimeFormat];
    [formatter setTimeZone:self.timeZone];
    return [formatter stringFromDate:self.startDate];
}

+ (NSArray *)createArrayOfTimeSlotsStartingAtTime:(NSString *)startTime
                                          endTime:(NSString *)endTime
                                      inTimezone:(NSTimeZone *)timeZone
                                     slotDuration:(NSTimeInterval)duration
                                      inDayOfDate:(NSDate *)date
{
    NSMutableArray *slots = [NSMutableArray new];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:MBXTimeFormat];
    [formatter setTimeZone:timeZone];
    
    NSDate *startDate = [[formatter dateFromString:startTime] dateBySettingYearMonthAndDayFromDate:date];
    NSDate *endDate = [[formatter dateFromString:endTime] dateBySettingYearMonthAndDayFromDate:date];
   
    NSDate *currentDate = startDate;
    BOOL shouldContinue = YES;
    while(shouldContinue) {
        NSDate *nextDate = [currentDate dateByAddingTimeInterval:duration];
        if([nextDate compare:endDate] != NSOrderedDescending) {
            MBXTimeSlot *slot = [MBXTimeSlot new];
            slot.startDate = [currentDate dateBySettingYearMonthAndDayFromDate:date];
            slot.endDate = [nextDate dateBySettingYearMonthAndDayFromDate:date];
            slot.timeZone = timeZone;
            [slots addObject:slot];
            currentDate = nextDate;
        } else {
            shouldContinue = NO;
        }
    }
    
    return slots;
}

+ (NSArray *)createArrayOfTimeSlotsForEverydayInMonthOfDate:(NSDate *)date
                                             startingAtTime:(NSString *)startTime
                                                    endTime:(NSString *)endTime
                                                 inTimeZone:(NSTimeZone *)timeZone
                                               slotDuration:(NSTimeInterval)duration
{
    NSMutableArray *slots = [NSMutableArray new];
    NSInteger numDays = [date numberOfDaysInMonth];
    for(int day = 1;day<numDays + 1;day++) {
        NSDate *currentDate = [date dateBySettingDay:day];
        NSArray *dayslots = [self createArrayOfTimeSlotsStartingAtTime:startTime endTime:endTime
                                                            inTimezone:timeZone slotDuration:duration inDayOfDate:currentDate];
        [slots addObjectsFromArray:dayslots];
    }
    
    return slots;
}

+ (NSArray *)timeSlotsByFilteringSlots:(NSArray *)slots toMonth:(NSInteger)month day:(NSInteger)day
{
    NSMutableArray *filteredSlots = [NSMutableArray new];
    
    for(MBXTimeSlot *slot in slots) {
        NSDateComponents *comps = [slot.startDate dateTimeComponents];
        if(comps.month == month && comps.day == day) {
            [filteredSlots addObject:slot];
        }
    }
    
    return filteredSlots;
}

@end
