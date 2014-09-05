//
//  MBXTimePickerView.m
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import "MBXTimePickerView.h"
#import "MBXTimeCell.h"
#import "MBXTimeSlot.h"
#import "MBXCalendarTheme.h"
#import "MBXStrictFlowLayout.h"

@interface MBXTimePickerView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *allTimeSlots;

@end

@implementation MBXTimePickerView

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
    [self configureDefaultTheme];
    [self configureCollectionView];
    
    self.startTime = @"8:00 am";
    self.endTime = @"3:30 pm";
    self.timeZone = [NSTimeZone timeZoneWithName:@"America/Chicago"];
    self.slotSize = 60*30;
    self.date = [NSDate date];
    [self reloadData];
}

- (void)setSelectedTimeSlot:(MBXTimeSlot *)selectedTimeSlot
{
    _selectedTimeSlot = selectedTimeSlot;
    
    [self.collectionView reloadData];
}

static NSInteger const MBXNumberOfItemsPerRow = 3;
static CGFloat const MBXItemSpacing = 3;

- (void)configureCollectionView
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MBXTimeCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([MBXTimeCell class])];
    
    MBXStrictFlowLayout *layout = [MBXStrictFlowLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = MBXItemSpacing;
    layout.actualItemSpacing = MBXItemSpacing;
    layout.sectionInset = UIEdgeInsetsMake(8, 0, 0, 0);
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.backgroundColor = self.backgroundColor;
}

- (void)configureDefaultTheme
{
    self.cellBorderColor = [MBXCalendarTheme lightGrayColor];
    self.cellTextColor = [MBXCalendarTheme darkGrayColor];
    self.cellSelectedTextColor = [UIColor whiteColor];
    self.cellSelectedBackgroundColor = [MBXCalendarTheme blueColor];
    self.cellDisabledTextColor = [MBXCalendarTheme lightGrayColor];
    self.cellPassiveBackgroundColor = [UIColor whiteColor];
    self.cellBorderSize = 2.0;
    self.cellBorderColor = [MBXCalendarTheme lightGrayColor];
    self.backgroundColor = [MBXCalendarTheme lightGrayBackgroundColor];
}

- (void)calculateAllTimeSlots
{
    self.allTimeSlots = [MBXTimeSlot createArrayOfTimeSlotsStartingAtTime:self.startTime endTime:self.endTime
                                                               inTimezone:self.timeZone slotDuration:self.slotSize inDayOfDate:self.date];
}

- (void)reloadData
{
    [self calculateAllTimeSlots];
    
    [self.collectionView reloadData];
}

- (void)reset
{
    _selectedTimeSlot = nil;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Datasource / Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allTimeSlots.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MBXTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MBXTimeCell class]) forIndexPath:indexPath];
    MBXTimeSlot *slot = self.allTimeSlots[indexPath.row];
    if([self.availableTimeSlots containsObject:slot]) {
        cell.timeLabel.textColor = self.cellTextColor;
        cell.crossedOut = NO;
    } else {
        cell.timeLabel.textColor = self.cellDisabledTextColor;
        cell.crossedOut = YES;
    }
    
    cell.backgroundColor = self.cellPassiveBackgroundColor;
    
    if(slot == _selectedTimeSlot) {
        cell.backgroundColor = self.cellSelectedBackgroundColor;
        cell.timeLabel.textColor = self.cellSelectedTextColor;
    }
    
    cell.timeLabel.text = slot.startTime;
    
    cell.layer.borderColor = self.cellBorderColor.CGColor;
    cell.layer.borderWidth = self.cellBorderSize/2.0;
    
    return cell;
}

- (BOOL)isTimeSlotAvailable:(MBXTimeSlot *)slot
{
    return [self.availableTimeSlots containsObject:slot];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MBXTimeSlot *slot = self.allTimeSlots[indexPath.row];
    if(![self isTimeSlotAvailable:slot]) {
        return;
    }
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:[self.allTimeSlots indexOfObject:_selectedTimeSlot] inSection:0];
    
    _selectedTimeSlot = slot;
    
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadItemsAtIndexPaths:@[selectedIndexPath, indexPath]];
    }];
    
    [self.delegate timePicker:self didSelectTimeSlot:slot];
}

#pragma mark - Layout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = CGRectGetWidth(self.collectionView.frame)/MBXNumberOfItemsPerRow;
    return CGSizeMake(width - (MBXItemSpacing), 45);
}

@end
