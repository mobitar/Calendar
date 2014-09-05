//
//  MBXCalendarCell.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXCalendarCell.h"
#import "MBXSlashView.h"

@interface MBXCalendarCell ()
@property (nonatomic) MBXSlashView *slashView;
@end

@implementation MBXCalendarCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _slashView.frame = self.bounds;
}

- (MBXSlashView *)slashView
{
    if(!_slashView) {
        self.slashView = [[MBXSlashView alloc] initWithFrame:self.bounds];
    }
    
    return _slashView;
}

- (void)setCrossedOut:(BOOL)crossedOut
{
    _crossedOut = crossedOut;
    
    if(crossedOut) {
        [self addSubview:self.slashView];
    } else {
        [_slashView removeFromSuperview];
    }
}

@end
