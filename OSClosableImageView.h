//
// Created by 李道政 on 15/4/29.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern const CGFloat ButtonBackgroundCircleRadius;

@protocol OSClosableImageViewDelegate<NSObject>

- (void) closeImageView:(UIImageView *) imageView;
@end

@interface OSClosableImageView : UIView
@property (nonatomic, strong) id<OSClosableImageViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *imageView;

- (void) setImage:(UIImage *) image;

- (CGFloat) estimateHeight;
@end