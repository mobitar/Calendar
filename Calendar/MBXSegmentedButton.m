//
//  MBXSegmentedButton.m
//  Calendar
//
//  Created by Mo Bitar on 9/5/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXSegmentedButton.h"
#import "MBXCalendarTheme.h"

@implementation MBXSegmentedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    self.layer.borderColor = [MBXCalendarTheme lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected
{
    if(selected) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [MBXCalendarTheme lightGrayBackgroundColor];
    }
}

@end
