//
//  MBXCalendar.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBXDay.h"

@class MBXCalendar;

@protocol MBXCalendarDelegate <NSObject>

@optional

- (void)calender:(MBXCalendar *)calendar didSelectDay:(MBXDay *)day;

@end

@interface MBXCalendar : UIView

@property (nonatomic, weak) id<MBXCalendarDelegate> delegate;

@property (nonatomic) UIColor *monthLabelFontColor;

@property (nonatomic) UIColor *cellSelectedBackgroundColor;
@property (nonatomic) UIColor *cellPassiveBackgroundColor;
@property (nonatomic) UIColor *cellDisabledBackgroundColor;

@property (nonatomic) UIColor *cellSelectedFontColor;
@property (nonatomic) UIColor *cellPassiveFontColor;
@property (nonatomic) UIColor *cellDisabledFontColor;

@property (nonatomic) UIColor *cellBorderColor;

@property (nonatomic) CGFloat cellBorderWidth;

@property (nonatomic) CGSize cellSize;

@end
