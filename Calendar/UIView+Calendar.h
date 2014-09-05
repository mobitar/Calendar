//
//  UIView+Calendar.h
//  Calendar
//
//  Created by Mo Bitar on 9/5/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Calendar)

- (void)centerVerticallyInSuperview;
- (void)trailVerticallyTo:(UIView *)view withOffset:(CGFloat)offset;
- (void)centerHorizontallyInSuperview;
- (void)centerHorizontallyInView:(UIView *)view;
- (void)centerSubviewsVertically:(NSArray *)subviews offsetPerView:(NSArray *)spacing;
- (void)setXOrigin:(CGFloat)x;
- (void)setYOrigin:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)removeFromSuperviewWithFadeAnimation;

@end
