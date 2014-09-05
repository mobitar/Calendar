//
//  MBXHUDView.h
//  Calendar
//
//  Created by Mo Bitar on 7/9/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBXHUDView : UIView

+ (instancetype)HUDAddedToView:(UIView *)view;
+ (instancetype)HUDAddedToView:(UIView *)view withText:(NSString *)text;

- (void)dismiss;
- (void)dismissAfter:(NSTimeInterval)duration;

@end
