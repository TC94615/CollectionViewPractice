//
// Created by 李道政 on 15/4/29.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "OSClosableImageView.h"
#import "MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "UIDImen.h"

const CGFloat ButtonBackgroundCircleRadius = 15;

@interface OSClosableImageView()
@property (nonatomic, strong) UIButton *imageCloseButton;
@end

@implementation OSClosableImageView
- (instancetype) init {
    self = [super init];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor blueColor];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(VerticalPadding, HorizontalPadding, VerticalPadding, HorizontalPadding));
        }];
        self.imageView = imageView;

        UIButton *imageCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageCloseButton addTarget:self action:@selector(tapCloseButton:)
                   forControlEvents:UIControlEventTouchUpInside];
        [imageCloseButton setImage:[UIImage imageNamed:@"ic_cancel_custom_48dp.png"]
                          forState:UIControlStateNormal];
        [self addSubview:imageCloseButton];
        [imageCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView.mas_right);
            make.centerY.equalTo(imageView.mas_top);
            make.width.equalTo(@(ButtonBackgroundCircleRadius * 2));
            make.height.equalTo(@(ButtonBackgroundCircleRadius * 2));
        }];
        self.imageCloseButton = imageCloseButton;

    }
    return self;
}

- (void) setImage:(UIImage *) image {
    [self.imageView setImage:image];
}

- (void) tapCloseButton:(UIButton *) sender {
    if ([self.delegate respondsToSelector:@selector(closeImageView:)]) {
        [self.delegate closeImageView:self.imageView];
    }
//    self.imageView.image = nil;
//    self.imageCloseButton.hidden = YES;
//    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.scrollView);
//        make.top.equalTo(self.textView.mas_bottom).offset(VerticalPadding);
//        make.width.equalTo(self.view).offset(-HorizontalPadding * 2);
//        make.bottom.equalTo(self.view).offset(-VerticalPadding);
//    }];
}

- (CGFloat) estimateHeight {
    UIImage *image = self.imageView.image;
    CGFloat imageMaxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - HorizontalPadding * 2;
    if (image.size.width <= imageMaxWidth) {
        return image.size.height + VerticalPadding;
    } else {
        CGFloat scaledImageViewHeight = imageMaxWidth * image.size.height / image.size.width;
        return scaledImageViewHeight + VerticalPadding;
    }
}
@end