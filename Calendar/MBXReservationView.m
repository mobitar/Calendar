//
//  MBXReservationView.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXReservationView.h"

@interface MBXReservationView ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

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
    [self.contentView addSubview:self.calendar];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.calendar.frame = self.contentView.bounds;
}

- (IBAction)selectDatePressed:(id)sender
{
    
}

- (IBAction)selectTimePressed:(id)sender
{
    
}

@end
