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

@interface MBXTimePickerView () <UICollectionViewDataSource, UICollectionViewDelegate>

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

- (void)calculateAllTimeSlots
{
    self.allTimeSlots = [MBXTimeSlot createArrayOfTimeSlotsStartingAtTime:self.startTime endTime:self.endTime
                                                               inTimezone:self.timeZone slotDuration:self.slotSize inDayOfDate:self.date];
    for(MBXTimeSlot *slot in self.allTimeSlots) {
        NSLog(@"allTimeSlot:%@", slot);
    }
}

- (void)reloadData
{
    [self calculateAllTimeSlots];
    
    [self.collectionView reloadData];
}

- (void)initialize
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MBXTimeCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([MBXTimeCell class])];
    
    self.startTime = @"8:00 am";
    self.endTime = @"5:30 pm";
    self.timeZone = [NSTimeZone timeZoneWithName:@"America/Chicago"];
    self.slotSize = 60*30;
    self.date = [NSDate date];
    [self reloadData];
}

- (void)setAvailableTimeSlots:(NSArray *)availableTimeSlots
{
    _availableTimeSlots = availableTimeSlots;
    
    for(MBXTimeSlot *slot in availableTimeSlots) {
        NSLog(@"availableSlot:%@", slot);
    }
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
        cell.timeLabel.textColor = [UIColor greenColor];
    } else {
        cell.timeLabel.textColor = [UIColor redColor];
    }
    cell.timeLabel.text = slot.startTime;
    return cell;
}

@end
