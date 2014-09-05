//
//  MBXTimePickerView.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBXTimePickerView : UIView

/** i.e "8:00 am" */
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic) NSTimeInterval slotSize;
@property (nonatomic) NSTimeZone *timeZone;
@property (nonatomic) NSDate *date;

- (void)reloadData;


/** An array of MBXTimeSlots */
@property (nonatomic) NSArray *availableTimeSlots;

@end
