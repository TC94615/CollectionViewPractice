//
// Created by 李道政 on 15/4/23.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OSCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;

- (void) updateCellWithSelect:(BOOL) select;
@end