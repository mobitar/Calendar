//
//  MBXReservationView.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXReservationView.h"

@interface MBXReservationView () <MBXCalendarDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic) NSArray *availableTimeSlotsForCurrentMonth;

@end

@implementation MBXReservationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self initialize];
}

- (void)initialize
{
    self.calendar = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MBXCalendar class]) owner:nil options:nil][0];
    self.calendar.delegate = self;
    
    self.timePicker = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MBXTimePickerView class]) owner:nil options:nil][0];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.calendar.frame = self.contentView.bounds;
    [self.contentView addSubview:self.calendar];
}

- (void)switchToMode:(MBXReservationType)type
{
    if(type == MBXReservationTypeDate) {
        [self.contentView addSubview:self.calendar];
        [self.timePicker removeFromSuperview];
    } else {
        [self.contentView addSubview:self.timePicker];
        [self.calendar removeFromSuperview];
    }
}

- (IBAction)selectDatePressed:(id)sender
{
    [self switchToMode:MBXReservationTypeDate];
}

- (IBAction)selectTimePressed:(id)sender
{
    [self switchToMode:MBXReservationTypeTime];
}

#pragma mark - Calendar Delegate

- (void)calender:(MBXCalendar *)calendar didTransitionToMonth:(NSInteger)month
{
    NSAssert(self.dataSource, nil);
    self.availableTimeSlotsForCurrentMonth = [self.dataSource reservationViewAvailableTimeSlotsForMonth:month];
}

- (void)calender:(MBXCalendar *)calendar didSelectDay:(MBXDay *)day
{
    self.timePicker.date = day.date;
    self.timePicker.availableTimeSlots = [MBXTimeSlot timeSlotsByFilteringSlots:self.availableTimeSlotsForCurrentMonth toMonth:day.month day:day.day];
    [self.timePicker reloadData];
    
    [self switchToMode:MBXReservationTypeTime];
}

@end
