//
//  NSDate+Calendar.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

- (NSDate *)dateBySettingYearMonthAndDayFromDate:(NSDate *)fromDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *fromComponents  = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:fromDate];
    NSDateComponents *toComponents  = [self dateTimeComponents];
    
    toComponents.year = fromComponents.year;
    toComponents.month = fromComponents.month;
    toComponents.day = fromComponents.day;
    
    return [calendar dateFromComponents:toComponents];
}

- (NSDateComponents *)dateTimeComponents
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components  = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    return components;
}

- (NSDate *)dateBySettingMonth:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components  = [self dateTimeComponents];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

- (NSInteger)numberOfDaysInMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}

- (NSDate *)dateBySettingDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components  = [self dateTimeComponents];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

@end
