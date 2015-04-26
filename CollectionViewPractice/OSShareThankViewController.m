//
// Created by 李道政 on 15/4/26.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "OSShareThankViewController.h"
#import "View+MASAdditions.h"
#import "UIColor+Constant.h"

static const CGFloat buttonSide = 30;
static const CGFloat SeparatorLineHeight = 1;

@interface OSShareThankViewController()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *toSomeoneYouThanksView;
@property (nonatomic, strong) UIImageView *selectedImageView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end

@implementation OSShareThankViewController
- (void) loadView {
    [super loadView];

}

- (void) imagePickerController:(UIImagePickerController *) picker didFinishPickingImage:(UIImage *) image editingInfo:(NSDictionary *) editingInfo {
    [self.selectedImageView setImage:image];
    [self.selectedImageView intrinsicContentSize];
    NSLog(@">>>>>>>>>>>> NSStringFromCGRect(self.selectedImageView) = %@", NSStringFromCGRect(self.selectedImageView.frame));
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureNavigationController];
    [self configureToSomeoneYouThanksView];


    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerController = imagePickerController;

    UIImageView *avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_person_black_48dp.png"]];
    avatarImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(5);
        make.top.equalTo(self.toSomeoneYouThanksView.mas_bottom).offset(10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];

    CGFloat circleRadius = 15;
    UITapGestureRecognizer *loadPhotoButtonBackgroundTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(tapLoadPhotoButton:)];
    UIView *loadPhotoButtonBackgroundView = [[UIView alloc] init];
    [loadPhotoButtonBackgroundView addGestureRecognizer:loadPhotoButtonBackgroundTapGesture];
    loadPhotoButtonBackgroundView.layer.cornerRadius = circleRadius;
    loadPhotoButtonBackgroundView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:loadPhotoButtonBackgroundView];
    [loadPhotoButtonBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(5);
        make.top.equalTo(avatarImageView.mas_bottom).offset(10);
        make.width.equalTo(@(circleRadius * 2));
        make.height.equalTo(@(circleRadius * 2));
    }];

    UIButton *loadPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loadPhotoButton addTarget:self action:@selector(tapLoadPhotoButton:)
              forControlEvents:UIControlEventTouchUpInside];
    [loadPhotoButton setImage:[[UIImage imageNamed:@"ic_photo_camera_black_48dp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                     forState:UIControlStateNormal];
    loadPhotoButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:loadPhotoButton];
    [loadPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(loadPhotoButtonBackgroundView);
        make.centerY.equalTo(loadPhotoButtonBackgroundView);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];

    UIImageView *selectedImageView = [[UIImageView alloc] init];
    selectedImageView.clipsToBounds = YES;
    selectedImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:selectedImageView];
    [selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(loadPhotoButton.mas_bottom);
        make.width.equalTo(self.view).offset(-10);
    }];
    self.selectedImageView = selectedImageView;

    UIImageView *closeImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ic_cancel_black_48dp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    closeImageView.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:closeImageView];
    [closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-5);
        make.top.equalTo(self.toSomeoneYouThanksView.mas_bottom);
        make.width.equalTo(@(circleRadius * 2));
        make.height.equalTo(@(circleRadius * 2));
    }];
}

- (void) tapLoadPhotoButton:(UIButton *) sender {
    [self presentViewController:self.imagePickerController animated:YES
                     completion:nil];
}

- (void) configureToSomeoneYouThanksView {
    UIView *toSomeoneYouThanksView = [[UIView alloc] init];
    toSomeoneYouThanksView.backgroundColor = [UIColor pageBackgroundColor];
    [self.view addSubview:toSomeoneYouThanksView];
    [toSomeoneYouThanksView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@(buttonSide));
    }];
    self.toSomeoneYouThanksView = toSomeoneYouThanksView;
    UILabel *sendThanksLabel = [[UILabel alloc] init];
    sendThanksLabel.text = @"To: ";
    sendThanksLabel.textColor = [UIColor lightGrayColor];
    [toSomeoneYouThanksView addSubview:sendThanksLabel];
    [sendThanksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toSomeoneYouThanksView).offset(5);
        make.top.equalTo(toSomeoneYouThanksView);
        make.bottom.equalTo(toSomeoneYouThanksView);
    }];
    UILabel *thanksListLabel = [[UILabel alloc] init];
    [toSomeoneYouThanksView addSubview:thanksListLabel];
    [thanksListLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sendThanksLabel.mas_right);
        make.top.equalTo(toSomeoneYouThanksView);
        make.bottom.equalTo(toSomeoneYouThanksView);
    }];
    UIButton *addThanksListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addThanksListButton addTarget:self action:@selector(tapAddThanksListButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    [addThanksListButton setImage:[[UIImage imageNamed:@"ic_chevron_right_black_48dp.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                         forState:UIControlStateNormal];
    addThanksListButton.tintColor = [UIColor lightGrayColor];
    [toSomeoneYouThanksView addSubview:addThanksListButton];
    [addThanksListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toSomeoneYouThanksView);
        make.right.equalTo(toSomeoneYouThanksView);
        make.width.equalTo(@(buttonSide));
        make.height.equalTo(@(buttonSide));
    }];
    UIImageView *separatorLine = [[UIImageView alloc] init];
    separatorLine.backgroundColor = [UIColor separatorGray];
    [toSomeoneYouThanksView addSubview:separatorLine];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toSomeoneYouThanksView);
        make.bottom.equalTo(toSomeoneYouThanksView);
        make.width.equalTo(toSomeoneYouThanksView);
        make.height.equalTo(@(SeparatorLineHeight));
    }];
}

- (void) tapAddThanksListButton:(UIButton *) sender {

}

- (void) configureNavigationController {
    self.navigationItem.title = @"Share Your Thanks";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(tapCancelButton:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Public"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(tapPublicButton:)];
}

- (void) tapCancelButton:(UIBarButtonItem *) sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) tapPublicButton:(UIBarButtonItem *) sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end