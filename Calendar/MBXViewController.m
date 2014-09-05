//
//  MBXViewController.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXViewController.h"
#import "MBXReservationView.h"
#import "MBXServer.h"

@interface MBXViewController () <MBXReservationViewDataSource>
@property (nonatomic) NSArray *availableTimeSlots;
@property (nonatomic) MBXServer *server;
@end

@implementation MBXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.server = [MBXServer new];
    
    MBXReservationView *res = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MBXReservationView class]) owner:nil options:nil][0];
    res.dataSource = self;
    [self.view addSubview:res];
}

#pragma mark - Reservation Delegate

- (NSArray *)reservationViewAvailableTimeSlotsForMonth:(NSInteger)month
{
    return [self.server getAvailableTimeSlotsForMonth:month];
}

@end
