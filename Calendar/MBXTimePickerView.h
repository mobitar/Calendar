//
//  MBXTimePickerView.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBXTimePickerView, MBXTimeSlot;

@protocol MBXTimePickerDelegate <NSObject>

- (void)timePicker:(MBXTimePickerView *)timePicker didSelectTimeSlot:(MBXTimeSlot *)timeSlot;

@end

@interface MBXTimePickerView : UIView

/** i.e "8:00 am" */
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic) NSTimeInterval slotSize;
@property (nonatomic) NSTimeZone *timeZone;
@property (nonatomic) NSDate *date;

@property (nonatomic) CGFloat cellBorderSize;

@property (nonatomic) UIColor *cellBorderColor;
@property (nonatomic) UIColor *cellTextColor;
@property (nonatomic) UIColor *cellDisabledTextColor;
@property (nonatomic) UIColor *cellSelectedBackgroundColor;
@property (nonatomic) UIColor *cellPassiveBackgroundColor;
@property (nonatomic) UIColor *cellSelectedTextColor;

@property (nonatomic, readwrite) MBXTimeSlot *selectedTimeSlot;

@property (nonatomic, weak) id<MBXTimePickerDelegate> delegate;

- (void)reloadData;

- (void)reset;

/** An array of MBXTimeSlots */
@property (nonatomic) NSArray *availableTimeSlots;

@end
