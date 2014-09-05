//
//  UIView+Calendar.m
//  Calendar
//
//  Created by Mo Bitar on 9/5/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "UIView+Calendar.h"

@implementation UIView (Calendar)

- (void)centerVerticallyInView:(UIView *)view
{
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetHeight(view.frame)/2.0 - CGRectGetHeight(frame)/2.0;
    self.frame = frame;
}

- (void)centerVerticallyInSuperview
{
    NSAssert(self.superview, @"Superview cannot be nil");
    
    [self centerVerticallyInView:self.superview];
}

- (void)trailVerticallyTo:(UIView *)view withOffset:(CGFloat)offset
{
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetMaxY(view.frame) + offset;
    self.frame = frame;
}

- (void)centerHorizontallyInSuperview
{
    NSAssert(self.superview, nil);
    
    [self centerHorizontallyInView:self.superview];
}

- (void)centerHorizontallyInView:(UIView *)view
{
    CGRect frame = self.frame;
    frame.origin.x = CGRectGetWidth(view.frame)/2.0 - CGRectGetWidth(frame)/2.0;
    self.frame = frame;
}

- (void)centerSubviewsVertically:(NSArray *)subviews offsetPerView:(NSArray *)spacing
{
    if(spacing.count) {
        NSAssert(subviews.count == spacing.count, @"Subviews and spacing arrays should match in count");
    }
    
    __block CGFloat totalHeight = 0;
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        NSNumber *offset = spacing[idx];
        totalHeight += CGRectGetHeight(view.frame) + offset.floatValue;
    }];
    
    __block CGFloat currentY = CGRectGetHeight(self.frame)/2.0 - totalHeight/2.0;
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        NSNumber *offset = spacing[idx];
        [view setYOrigin:currentY + offset.floatValue];
        currentY = CGRectGetMaxY(view.frame);
    }];
}

- (void)setXOrigin:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setYOrigin:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)removeFromSuperviewWithFadeAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
