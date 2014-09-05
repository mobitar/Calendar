//
//  MBXHUDView.m
//  Calendar
//
//  Created by Mo Bitar on 7/9/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXHUDView.h"
#import "UIView+Calendar.h"

@interface MBXHUDView ()

@property (nonatomic) UILabel *textLabel;
@property (nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BOOL hasActivityIndicator;
@end

@implementation MBXHUDView

+ (instancetype)HUDAddedToView:(UIView *)view
{
    MBXHUDView *hud = [MBXHUDView HUD];
    [view addSubview:hud];
    [hud centerVerticallyInSuperview];
    [hud centerHorizontallyInSuperview];
    hud.textLabel.text = NSLocalizedString(@"LOADING...", nil);
    return hud;
}

+ (instancetype)HUDAddedToView:(UIView *)view withText:(NSString *)text
{
    MBXHUDView *hud = [MBXHUDView HUDAddedToView:view];
    hud.textLabel.text = text;
    return hud;
}
                       
+ (instancetype)HUD
{
    MBXHUDView *hud = [[MBXHUDView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    return hud;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8;
        self.hasActivityIndicator = YES;
    }
    return self;
}

- (UILabel *)textLabel
{
    if(!_textLabel) {
        self.textLabel = [UILabel new];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [[UILabel appearanceWhenContainedIn:[MBXHUDView class], nil] font];
        _textLabel.numberOfLines = 2;
    }
    return _textLabel;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if(!_activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicator.color = [UIColor blackColor];
        [_activityIndicator startAnimating];
    }
    return _activityIndicator;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.masksToBounds = NO;
    self.clipsToBounds = NO;
    
    [self addSubview:self.textLabel];
    [self.textLabel setWidth:self.frame.size.width - 8];
    [self.textLabel sizeToFit];
    [self.textLabel centerHorizontallyInSuperview];
    
    UIView *accessoryView = nil;
    
    if(self.hasActivityIndicator) {
        [self addSubview:self.activityIndicator];
        accessoryView = self.activityIndicator;
    }
    
    [accessoryView centerHorizontallyInSuperview];
    
    [self centerSubviewsVertically:@[accessoryView, self.textLabel] offsetPerView:@[@0,@8]];
}

- (void)dismiss
{
    [self removeFromSuperviewWithFadeAnimation];
}

- (void)dismissAfter:(NSTimeInterval)duration
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}


@end
