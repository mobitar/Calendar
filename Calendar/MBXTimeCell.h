//
//  MBXTimeCell.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBXTimeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic) BOOL crossedOut;
@end
