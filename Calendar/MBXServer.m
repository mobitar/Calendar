//
//  MBXServer.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXServer.h"
#import "MBXTimeSlot.h"
#import "NSDate+Calendar.h"

@implementation MBXServer

- (NSArray *)getAvailableTimeSlotsForMonth:(NSInteger)month
{
    if(month == 9) {
        return [self septemberTimeSlots];
    } else {
        NSDate *date = [[NSDate date] dateBySettingMonth:month day:1];
        NSArray *slots = [MBXTimeSlot createArrayOfTimeSlotsForEverydayInMonthOfDate:date startingAtTime:@"8:00 am" endTime:@"5:00 pm" inTimeZone:@"America/Chicago" slotDuration:60*30];
        return slots;
    }
}

- (NSArray *)septemberTimeSlots
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"september-data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *days = result[@"result"][@"days"];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    
    NSMutableArray *timeSlots = [NSMutableArray new];
    for(NSDictionary *day in days) {
        NSArray *slots = day[@"timeslots"];
        for(NSDictionary *slotDic in slots) {
            MBXTimeSlot *slot = [MBXTimeSlot new];
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:slotDic[@"timezone"]]];
            slot.startDate = [formatter dateFromString:slotDic[@"startTime"]];
            slot.endDate = [formatter dateFromString:slotDic[@"endTime"]];
            [timeSlots addObject:slot];
        }
    }
    
    return timeSlots;
}


@end
