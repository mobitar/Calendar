//
//  MBXReservationView.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXReservationView.h"
#import "MBXSegmentedButton.h"
#import "UIView+Calendar.h"
#import "MBXHUDView.h"

@interface MBXReservationView () <MBXCalendarDelegate, MBXTimePickerDelegate>
@property (nonatomic) NSArray *availableTimeSlotsForCurrentMonth;
@property (weak, nonatomic) IBOutlet MBXSegmentedButton *dateButton;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet MBXSegmentedButton *clearAllButton;
@property (weak, nonatomic) IBOutlet MBXSegmentedButton *timeButton;
@end

@implementation MBXReservationView
{
    BOOL _expanded;
}

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

    self.clearAllButton.selected = YES;
    self.clearAllButton.layer.borderWidth = 0.5;
    
    self.timePicker = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MBXTimePickerView class]) owner:nil options:nil][0];
    self.timePicker.delegate = self;
    
    [self collapse];
    
    self.clipsToBounds = YES;
}

#pragma mark - UI

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.calendar trailVerticallyTo:self.headerView withOffset:0];
    [self.timePicker trailVerticallyTo:self.headerView withOffset:0];
}

- (void)switchToMode:(MBXReservationType)type
{
    UIView *activeView = nil;
    if(type == MBXReservationTypeDate) {
        activeView = self.calendar;
        self.timePicker.hidden = YES;
    } else {
        activeView = self.timePicker;
        self.calendar.hidden = YES;
    }
    
    activeView.hidden = NO;
    [self addSubview:activeView];
    
    [self expandToView:activeView];
}

- (void)expandToView:(UIView *)view
{
    [self bringSubviewToFront:self.clearAllButton];
    CGRect frame = self.frame;
    frame.size.height = CGRectGetHeight(self.headerView.frame) + CGRectGetHeight(view.frame) + CGRectGetHeight(self.clearAllButton.frame);
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = frame;
        [self.clearAllButton trailVerticallyTo:view withOffset:0];
        
    }];
    
    _expanded = YES;
}

- (void)collapse
{
    CGRect frame = self.frame;
    frame.size.height = CGRectGetHeight(self.headerView.frame);
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = frame;
    }];
    
    _expanded = NO;
}

- (IBAction)selectDatePressed:(MBXSegmentedButton *)sender
{
    [self switchToMode:MBXReservationTypeDate];
    
    sender.selected = YES;
    self.timeButton.selected = NO;
}

- (IBAction)selectTimePressed:(MBXSegmentedButton *)sender
{
    [self switchToMode:MBXReservationTypeTime];
    
    sender.selected = YES;
    self.dateButton.selected = NO;
}

- (IBAction)clearAllPressed:(id)sender
{
    [self.calendar reset];
    [self.timePicker reset];
    [self.dateButton setTitle:NSLocalizedString(@"Select Date", nil) forState:UIControlStateNormal];
    [self.timeButton setTitle:NSLocalizedString(@"Select Time", nil) forState:UIControlStateNormal];
}

#pragma mark - Setters

- (void)setSelectedDay:(MBXDay *)selectedDay
{
    _selectedDay = selectedDay;
}

- (void)setSelectedTime:(MBXTimeSlot *)selectedTime
{
    _selectedTime = selectedTime;
}

#pragma mark - Calendar Delegate

- (void)calender:(MBXCalendar *)calendar didTransitionToMonth:(NSInteger)month
{
    NSAssert(self.dataSource, nil);
    self.availableTimeSlotsForCurrentMonth = [self.dataSource reservationViewAvailableTimeSlotsForMonth:month];
    
    MBXHUDView *hud = [MBXHUDView HUDAddedToView:self.window withText:@"Loading..."];
    [hud dismissAfter:0.4];
}

- (void)calender:(MBXCalendar *)calendar didSelectDay:(MBXDay *)day
{
    self.timePicker.date = day.date;
    self.timePicker.availableTimeSlots = [MBXTimeSlot timeSlotsByFilteringSlots:self.availableTimeSlotsForCurrentMonth toMonth:day.month day:day.day];
    [self.timePicker reloadData];
    
    [self.dateButton setTitle:day.dateString forState:UIControlStateNormal];
    
    [self collapse];
    
    _selectedDay = day;
}

- (void)calenderDidResize:(MBXCalendar *)calendar
{
    [self expandToView:calendar];
}

#pragma mark - Time Picker Delegate

- (void)timePicker:(MBXTimePickerView *)timePicker didSelectTimeSlot:(MBXTimeSlot *)timeSlot
{
    _selectedTime = timeSlot;
    [self.timeButton setTitle:timeSlot.startTime forState:UIControlStateNormal];
    [self collapse];
}

@end
