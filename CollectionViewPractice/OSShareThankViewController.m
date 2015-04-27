//
// Created by 李道政 on 15/4/26.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "OSShareThankViewController.h"
#import "View+MASAdditions.h"
#import "UIColor+Constant.h"
#import "SZTextView.h"

static const CGFloat buttonSide = 30;
static const CGFloat AvatarSide = 40;
static const CGFloat SeparatorLineHeight = 1;
static const CGFloat HorizontalPadding = 10;
static const CGFloat VerticalPadding = 10;
static const CGFloat ButtonBackgroundCircleRadius = 15;
static const CGFloat LoadPhotoButtonSide = 20;

@interface OSShareThankViewController()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *toSomeoneYouThanksView;
@property (nonatomic, strong) UIImageView *selectedImageView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIView *loadPhotoButtonBackgroundView;
@property (nonatomic, strong) UIButton *imageCloseButton;
@property (nonatomic, strong) SZTextView *textView;
@end

@implementation OSShareThankViewController
- (void) loadView {
    [super loadView];

}

- (void) viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self configureNavigationController];
    [self configureToSomeoneYouThanksView];
    [self configureMainView];

    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerController = imagePickerController;
}

- (void) viewWillDisappear:(BOOL) animated {
    [super viewWillDisappear:animated];

    [self.textView endEditing:YES];
}

#pragma mark layout

- (void) configureMainView {

    UIImageView *avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_person_black_48dp.png"]];
    avatarImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(HorizontalPadding);
        make.top.equalTo(self.toSomeoneYouThanksView.mas_bottom).offset(VerticalPadding);
        make.width.equalTo(@(AvatarSide));
        make.height.equalTo(@(AvatarSide));
    }];

    UITapGestureRecognizer *loadPhotoButtonBackgroundTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(tapLoadPhotoButton:)];
    UIView *loadPhotoButtonBackgroundView = [[UIView alloc] init];
    [loadPhotoButtonBackgroundView addGestureRecognizer:loadPhotoButtonBackgroundTapGesture];
    loadPhotoButtonBackgroundView.layer.cornerRadius = ButtonBackgroundCircleRadius;
    loadPhotoButtonBackgroundView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:loadPhotoButtonBackgroundView];
    [loadPhotoButtonBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(HorizontalPadding);
        make.top.equalTo(avatarImageView.mas_bottom).offset(VerticalPadding);
        make.width.equalTo(@(ButtonBackgroundCircleRadius * 2));
        make.height.equalTo(@(ButtonBackgroundCircleRadius * 2));
    }];
    self.loadPhotoButtonBackgroundView = loadPhotoButtonBackgroundView;

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
        make.width.equalTo(@(LoadPhotoButtonSide));
        make.height.equalTo(@(LoadPhotoButtonSide));
    }];

    UIImageView *selectedImageView = [[UIImageView alloc] init];
    selectedImageView.clipsToBounds = YES;
    selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:selectedImageView];
    [selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(loadPhotoButtonBackgroundView.mas_bottom).offset(VerticalPadding);
        make.width.equalTo(self.view).offset(-HorizontalPadding * 2);
        make.bottom.equalTo(self.view).offset(-VerticalPadding);
    }];
    self.selectedImageView = selectedImageView;

    SZTextView *textView = [[SZTextView alloc] init];
    textView.placeholder = @"分享您的心得";
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarImageView.mas_right).offset(HorizontalPadding);
        make.top.equalTo(self.toSomeoneYouThanksView.mas_bottom);
        make.right.equalTo(self.view).offset(-HorizontalPadding);
        make.bottom.equalTo(selectedImageView.mas_top).offset(-VerticalPadding);
    }];
    self.textView = textView;

    UIButton *imageCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageCloseButton addTarget:self action:@selector(tapCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [imageCloseButton setImage:[UIImage imageNamed:@"ic_cancel_custom_48dp.png"]
                      forState:UIControlStateNormal];
    [self.view addSubview:imageCloseButton];
    [imageCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(selectedImageView.mas_right);
        make.centerY.equalTo(selectedImageView.mas_top);
        make.width.equalTo(@(ButtonBackgroundCircleRadius * 2));
        make.height.equalTo(@(ButtonBackgroundCircleRadius * 2));
    }];
    imageCloseButton.hidden = YES;
    self.imageCloseButton = imageCloseButton;
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
    sendThanksLabel.text = @"致： ";
    sendThanksLabel.textColor = [UIColor lightGrayColor];
    [toSomeoneYouThanksView addSubview:sendThanksLabel];
    [sendThanksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toSomeoneYouThanksView).offset(HorizontalPadding);
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
        make.right.equalTo(toSomeoneYouThanksView).offset(-HorizontalPadding);
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

- (void) configureNavigationController {
    CGFloat buttonFontSize = 11;
    self.navigationItem.title = @"分享感謝文";
    [self.navigationController.navigationBar setTitleTextAttributes:
                                               @{NSFontAttributeName :
                                                 [UIFont systemFontOfSize:15]}];

    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 17)];
    leftButtonView.backgroundColor = [UIColor pageBackgroundColor];
    leftButtonView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    leftButtonView.layer.borderWidth = 1;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton addTarget:self action:@selector(tapCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTintColor:[UIColor pageBackgroundColor]];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:buttonFontSize];
    [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [leftButtonView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(leftButtonView);
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];

    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 17)];
    rightButtonView.backgroundColor = [UIColor redColor];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(tapPublicButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"發布" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:buttonFontSize];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightButtonView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightButtonView);
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
}

#pragma mark button actions

- (void) tapCloseButton:(UIButton *) sender {
    self.selectedImageView.image = nil;
    self.imageCloseButton.hidden = YES;
    [self.selectedImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.loadPhotoButtonBackgroundView.mas_bottom).offset(VerticalPadding);
        make.width.equalTo(self.view).offset(-HorizontalPadding * 2);
        make.bottom.equalTo(self.view).offset(-VerticalPadding);
    }];
}

- (void) tapLoadPhotoButton:(UIButton *) sender {
    [self presentViewController:self.imagePickerController animated:YES
                     completion:nil];
}

- (void) tapAddThanksListButton:(UIButton *) sender {

}

- (void) tapCancelButton:(UIButton *) sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) tapPublicButton:(UIButton *) sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *) picker didFinishPickingImage:(UIImage *) image editingInfo:(NSDictionary *) editingInfo {
    if (image.size.width <= CGRectGetWidth(self.selectedImageView.frame) && image.size.height <= CGRectGetHeight(self.selectedImageView.frame)) {
        self.selectedImageView.contentMode = UIViewContentModeTopLeft;
        [self.selectedImageView setImage:image];
    } else {
        self.selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat scaledImageViewHeight = CGRectGetWidth(self.selectedImageView.frame) * image.size.height / image.size.width;
        [self.selectedImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.loadPhotoButtonBackgroundView.mas_bottom).offset(VerticalPadding);
            make.width.equalTo(self.view).offset(-HorizontalPadding * 2);
            make.height.equalTo(@(scaledImageViewHeight));
        }];
        [self.selectedImageView setImage:image];
    }
    self.imageCloseButton.hidden = NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end