//
//  TestLayout.m
//  WordPack
//
//  Created by Mo Bitar on 8/1/14.
//  Copyright (c) 2014 progenius inc. All rights reserved.
//

#import "MBXStrictFlowLayout.h"

#define FLOAT_EPSILON 0.0001

@implementation MBXStrictFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 1; i < [answer count]; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        CGFloat previousMaxX = CGRectGetMaxX(prevLayoutAttributes.frame);
        CGRect currentFrame = currentLayoutAttributes.frame;
        CGFloat expectedMaxX = previousMaxX + self.actualItemSpacing + currentLayoutAttributes.frame.size.width;
        CGFloat difference = self.collectionViewContentSize.width - expectedMaxX;
        if(difference > 0 || fabs(difference) <= FLOAT_EPSILON) {
            currentFrame.origin.x = previousMaxX + self.actualItemSpacing;
            currentFrame.origin.y = CGRectGetMinY(prevLayoutAttributes.frame);
        } else {
            currentFrame.origin.x = 0;
            currentFrame.origin.y = CGRectGetMaxY(prevLayoutAttributes.frame);
        }
        currentLayoutAttributes.frame = currentFrame;
    }
    return answer;
}

@end
