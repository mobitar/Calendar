//
//  MBXCalendar.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXCalendar.h"
#import "MBXCalendarCell.h"
#import "MBXCalendarTheme.h"
#import "MBXStrictFlowLayout.h"
#import "MBXCalendarHeaderCell.h"

@interface MBXCalendar () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

typedef NS_ENUM(NSInteger, MBXCalendarSection)
{
    MBXCalendarSectionHeader,
    MBXCalendarSectionDays,
    MBXCalendarSectionCount
};

static NSUInteger const MBXNumberOfMonthsInYear = 12;
static NSUInteger const MBXNumberOfDaysInWeek = 7;

@implementation MBXCalendar
{
    NSCalendar *_calendar;
    NSDateFormatter *_dateFormatter;
    
    NSDate *_currentDate;
    
    NSInteger _currentYear;
    NSInteger _currentMonth;
    NSInteger _currentDay;
    
    NSString *_currentMonthName;
    
    NSInteger _numberOfDaysInCurrentMonth;
    NSArray *_weekDaySymbols;
    
    // an array of MBXDay objects
    NSArray *_days;
    
    MBXDay *_selectedDay;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void)configureDefaultTheme
{
    self.monthLabelFontColor = [UIColor colorWithRed:0.408 green:0.420 blue:0.420 alpha:1];
    
    self.cellPassiveBackgroundColor = [UIColor whiteColor];
    self.cellSelectedBackgroundColor = [UIColor colorWithRed:0.494 green:0.561 blue:0.675 alpha:1];
    self.cellDisabledBackgroundColor = [UIColor colorWithRed:0.941 green:0.933 blue:0.929 alpha:1];
    
    self.cellPassiveFontColor = [UIColor colorWithRed:0.427 green:0.435 blue:0.435 alpha:1];
    self.cellSelectedFontColor = [UIColor whiteColor];
    self.cellDisabledFontColor = [MBXCalendarTheme lightGrayColor];
    
    self.cellBorderColor = [MBXCalendarTheme lightGrayColor];
    
    self.backgroundColor = [UIColor colorWithRed:0.941 green:0.933 blue:0.929 alpha:1];
    
    self.cellBorderWidth = 0.5;
    
    CGFloat cellWidth = CGRectGetWidth(self.frame) / MBXNumberOfDaysInWeek;
    self.cellSize = CGSizeMake(cellWidth, cellWidth);
    
    self.previousButton.tintColor = [MBXCalendarTheme lightGrayColor];
    self.nextButton.tintColor = [MBXCalendarTheme lightGrayColor];
    [self.previousButton setImage:[[self.previousButton imageForState:UIControlStateNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.nextButton setImage:[[self.nextButton imageForState:UIControlStateNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)setMonthLabelFontColor:(UIColor *)monthLabelFontColor
{
    _monthLabelFontColor = monthLabelFontColor;
    
    self.monthLabel.textColor = monthLabelFontColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    self.collectionView.backgroundColor = backgroundColor;
}

- (void)initialize
{
    [self configureCollectionView];
    [self configureDefaultTheme];
    
    _dateFormatter = [NSDateFormatter new];
    _calendar = [NSCalendar currentCalendar];
    _weekDaySymbols = _dateFormatter.weekdaySymbols;
  
    [self configureCurrentDates];
}

- (MBXStrictFlowLayout *)layout
{
    return (MBXStrictFlowLayout *)self.collectionView.collectionViewLayout;
}

- (void)configureCollectionView
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MBXCalendarCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([MBXCalendarCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MBXCalendarHeaderCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([MBXCalendarHeaderCell class])];
    
    MBXStrictFlowLayout *layout = [MBXStrictFlowLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.collectionView.collectionViewLayout = layout;
}

- (void)configureCurrentDates
{
    _currentDate = [NSDate date];
    NSDateComponents *dateComponents  = [_calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:_currentDate];
    [self setMonth:[dateComponents month] year:[dateComponents year]];
}

- (NSInteger)numberOfDaysInMonthOfDate:(NSDate *)date
{
    return [_calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}

- (void)transitionToNextMonth
{
    NSInteger year = _currentYear;
    NSInteger nextMonth = _currentMonth + 1;
    if(nextMonth > MBXNumberOfMonthsInYear) {
        nextMonth = 1;
        year++;
    }
    [self setMonth:nextMonth year:year];
    
    [self.collectionView reloadData];
}

- (void)transitionToPreviousMonth
{
    NSInteger year = _currentYear;
    NSInteger previousMonth = _currentMonth - 1;
    if(previousMonth <= 0) {
        previousMonth = MBXNumberOfMonthsInYear;
        year--;
    }
    [self setMonth:previousMonth year:year];
    
    [self.collectionView reloadData];
}

- (void)setMonth:(NSInteger)month year:(NSInteger)year
{
    NSDateComponents *dateComponents  = [_calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:_currentDate];

    _currentYear = year;
    _currentMonth = month;
    
    [dateComponents setYear:_currentYear];
    [dateComponents setMonth:_currentMonth];
    [dateComponents setDay:1];
    
    _currentDate = [_calendar dateFromComponents:dateComponents];
    _currentMonthName = _dateFormatter.monthSymbols[_currentMonth - 1];
    _numberOfDaysInCurrentMonth = [self numberOfDaysInMonthOfDate:_currentDate];
    
    // populate days
    [_dateFormatter setDateFormat:@"EEEE"];
    NSString *weekdayName = [_dateFormatter stringFromDate:_currentDate];
    NSInteger distanceFromBeginningOfWeek = [_weekDaySymbols indexOfObject:weekdayName];
    if(distanceFromBeginningOfWeek == NSNotFound) {
        distanceFromBeginningOfWeek = 0;
    }
    
    NSMutableArray *days = [NSMutableArray new];
    for(int i = 1; i < _numberOfDaysInCurrentMonth + distanceFromBeginningOfWeek + 1; i++) {
        MBXDay *day = [MBXDay new];
        day.month = month;
        if(i <= distanceFromBeginningOfWeek) {
            day.dummyObject = YES;
        } else {
            day.day = i - distanceFromBeginningOfWeek;
        }
        [dateComponents setDay:day.day];
        day.date = [_calendar dateFromComponents:dateComponents];
        [days addObject:day];
    }
    _days = days;
    
    self.monthLabel.text = _currentMonthName;
    
    [self.collectionView reloadData];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    [self.delegate calender:self didTransitionToMonth:_currentMonth];
}

- (IBAction)previousPressed:(id)sender
{
    [self transitionToPreviousMonth];
}

- (IBAction)nextPressed:(id)sender
{
    [self transitionToNextMonth];
}

#pragma mark - CollectionView DataSource/Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MBXCalendarSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == MBXCalendarSectionHeader) {
        return _weekDaySymbols.count;
    } else {
        return _days.count;
    }
}

- (void)configureHeaderCell:(MBXCalendarHeaderCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [_weekDaySymbols[indexPath.row] substringToIndex:1];
    cell.textLabel.textColor = [MBXCalendarTheme lightGrayColor];
}

- (void)configureDayCell:(MBXCalendarCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    MBXDay *day = _days[indexPath.row];
    
    if(day.isDummyObject) {
        cell.dayLabel.text = nil;
    } else {
        cell.dayLabel.text = [NSString stringWithFormat:@"%i", day.day];
    }
    
    if(day.isSelected) {
        cell.backgroundColor = self.cellSelectedBackgroundColor;
        cell.dayLabel.textColor = self.cellSelectedFontColor;
    } else if(day.isDummyObject) {
        cell.backgroundColor = self.cellDisabledBackgroundColor;
        cell.dayLabel.textColor = self.cellPassiveFontColor;
    } else {
        cell.backgroundColor = self.cellPassiveBackgroundColor;
        cell.dayLabel.textColor = self.cellPassiveFontColor;
    }
    
    cell.layer.borderColor = self.cellBorderColor.CGColor;
    cell.layer.borderWidth = self.cellBorderWidth/2.0; // since cells overlap, we divide the border by 2 to acheive desired effect
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == MBXCalendarSectionHeader) {
        MBXCalendarHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MBXCalendarHeaderCell class]) forIndexPath:indexPath];
        [self configureHeaderCell:cell atIndexPath:indexPath];
        return cell;
    } else {
        MBXCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MBXCalendarCell class]) forIndexPath:indexPath];
        [self configureDayCell:cell atIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == MBXCalendarSectionHeader) {
        return;
    }
    
    MBXDay *day = _days[indexPath.row];
    if(day.isDummyObject || [day isEqual:_selectedDay]) {
        return;
    }
    
    day.selected = YES;
    
    if([self.delegate respondsToSelector:@selector(calender:didSelectDay:)]) {
        [self.delegate calender:self didSelectDay:day];
    }
    
    _selectedDay.selected = NO;
    
    NSIndexPath *currentSelectedIndexPath = [NSIndexPath indexPathForRow:[_days indexOfObject:_selectedDay] inSection:MBXCalendarSectionDays];
    _selectedDay = day;
    
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath, currentSelectedIndexPath]];
    }];
}

#pragma mark - Layout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == MBXCalendarSectionHeader) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame)/MBXNumberOfDaysInWeek, 35);
    } else {
        return self.cellSize;
    }
}

@end
