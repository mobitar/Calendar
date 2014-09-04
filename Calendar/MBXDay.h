//
//  MBXDay.h
//  Calendar
//
//  Created by Mo Bitar on 9/4/14.
//  Copyright (c) 2014 Mo Bitar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBXDay : NSObject

@property (nonatomic) NSInteger day;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSDate *date;
@property (nonatomic, getter = isDummyObject) BOOL dummyObject;
@property (nonatomic, getter = isSelected) BOOL selected;

- (NSDateComponents *)components;

@end
