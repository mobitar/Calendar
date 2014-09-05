//
//  MBXReservationView.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBXCalendar.h"
#import "MBXTimePickerView.h"
#import "MBXTimeSlot.h"

typedef NS_ENUM(NSInteger, MBXReservationType)
{
    MBXReservationTypeDate,
    MBXReservationTypeTime
};

@protocol MBXReservationViewDataSource <NSObject>

- (NSArray *)reservationViewAvailableTimeSlotsForMonth:(NSInteger)month;

@end

@protocol MBXReservationDelegate <NSObject>

- (void)reservationViewDidSelectDay:(MBXDay *)day andTime:(MBXTimeSlot *)timeSlot;

@end

@interface MBXReservationView : UIView

@property (nonatomic) MBXCalendar *calendar;
@property (nonatomic) MBXTimePickerView *timePicker;

@property (nonatomic, weak) id<MBXReservationViewDataSource> dataSource;
@property (nonatomic, weak) id<MBXReservationDelegate> delegate;

@end
