//
// Created by 李道政 on 15/4/26.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "OSPresentNavigationController.h"
#import "UIColor+Constant.h"

@implementation OSPresentNavigationController
- (void) loadView {
    [super loadView];

    self.navigationBar.barTintColor = [UIColor pageBackgroundColor];
    self.navigationBar.translucent = NO;
}

@end