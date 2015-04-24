//
// Created by 李道政 on 15/4/23.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <sys/select.h>
#import "OSCollectionViewCell.h"

static CGFloat const IconSide = 20.0f;

@implementation OSCollectionViewCell
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:nil
                                                   highlightedImage:[UIImage imageNamed:@"ic_favorite_black_48dp.png"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@(IconSide));
            make.height.equalTo(@(IconSide));
        }];
        self.imageView = imageView;
    }
    return self;
}

- (void) updateCellWithSelect:(BOOL) select {
    [self.imageView setHighlighted:select];
}
@end