//
// Created by 李道政 on 15/4/22.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "OSCollectionViewLayout.h"


@implementation OSCollectionViewLayout

    - (CGSize) collectionViewContentSize {
    return [super collectionViewContentSize];
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect) rect {
    return [super layoutAttributesForElementsInRect:rect];
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *) indexPath {
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect) newBounds {
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}


@end