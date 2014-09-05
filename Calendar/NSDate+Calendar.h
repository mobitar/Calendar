//
//  NSDate+Calendar.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

- (NSDate *)dateBySettingYearMonthAndDayFromDate:(NSDate *)fromDate;

- (NSInteger)numberOfDaysInMonth;

- (NSDate *)dateBySettingDay:(NSInteger)day;

- (NSDate *)dateBySettingMonth:(NSInteger)month day:(NSInteger)day;

- (NSDateComponents *)dateTimeComponents;

@end
