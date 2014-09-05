//
//  MBXSlashView.m
//  Calendar
//
//  Created by Mo Bitar on 9/5/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXSlashView.h"
#import "MBXCalendarTheme.h"

@interface MBXSlashView ()

@property (nonatomic) CAShapeLayer *shapeLayer;

@end

@implementation MBXSlashView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    if(!_shapeLayer) {
        self.shapeLayer = [CAShapeLayer layer];
    }
    
    self.shapeLayer.path = [path CGPath];
    self.shapeLayer.strokeColor = [[MBXCalendarTheme lightGrayColor] CGColor];
    self.shapeLayer.lineWidth = 1.0;
    self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.layer addSublayer:self.shapeLayer];
}


@end
