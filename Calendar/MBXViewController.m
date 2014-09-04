//
//  MBXViewController.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXViewController.h"
#import "MBXReservationView.h"

@interface MBXViewController ()

@end

@implementation MBXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MBXReservationView *res = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MBXReservationView class]) owner:nil options:nil][0];
    [self.view addSubview:res];
}

@end
