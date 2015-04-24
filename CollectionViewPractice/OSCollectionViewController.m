//
// Created by 李道政 on 15/4/22.
// Copyright (c) 2015 oSolve. All rights reserved.
//

#import "OSCollectionViewController.h"
#import "View+MASAdditions.h"
#import "UIColor+Constant.h"
#import "OSCollectionViewCell.h"

static NSString *const CollectionViewCellReuseIdentifier = @"CollectionViewCellReuseIdentifier";
static CGFloat const TitleLabelHeight = 40.0f;
static CGFloat const explanationViewHeight = 80.0f;
static CGFloat const StartButtonHeight = 30.0f;
static CGFloat const StartButtonVerticalPadding = 10.0f;
static CGFloat const BottomViewHeight = StartButtonHeight + 2 * StartButtonVerticalPadding;

@interface OSCollectionViewController()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic) NSUInteger contentCount;
@end

@implementation OSCollectionViewController
- (void) loadView {
    [super loadView];

}

//- (BOOL) prefersStatusBarHidden {
//    return YES;
//}

- (void) viewDidLoad {
    [super viewDidLoad];

    UIColor *pageBackgroundColor = [UIColor pageBackgroundColor];

    self.view.backgroundColor = [UIColor redColor];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"Wish8";
    titleLabel.font = [UIFont boldSystemFontOfSize:21];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.width.equalTo(self.view);
        make.height.equalTo(@(TitleLabelHeight));
    }];

    UIView *explanationView = [[UIView alloc] init];
    explanationView.backgroundColor = pageBackgroundColor;
    [self.view addSubview:explanationView];
    [explanationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(titleLabel.mas_bottom);
        make.width.equalTo(self.view);
        make.height.equalTo(@(explanationViewHeight));
    }];

    UILabel *explanationLineOneLabel = [[UILabel alloc] init];
    explanationLineOneLabel.backgroundColor = pageBackgroundColor;
    explanationLineOneLabel.text = @"What's your wish?";
    explanationLineOneLabel.font = [UIFont systemFontOfSize:15];
    explanationLineOneLabel.textColor = [UIColor blackColor];
    [explanationView addSubview:explanationLineOneLabel];
    [explanationLineOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(explanationView);
        make.top.equalTo(explanationView);
    }];

    UILabel *explanationLineTwoLabel = [[UILabel alloc] init];
    explanationLineTwoLabel.backgroundColor = pageBackgroundColor;
    explanationLineTwoLabel.text = @"Choose the class you like.";
    explanationLineTwoLabel.font = [UIFont systemFontOfSize:12];
    explanationLineTwoLabel.textColor = [UIColor blackColor];
    [explanationView addSubview:explanationLineTwoLabel];
    [explanationLineTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(explanationView);
        make.top.equalTo(explanationLineOneLabel.mas_bottom);
    }];

    UILabel *explanationLineThreeLabel = [[UILabel alloc] init];
    explanationLineThreeLabel.backgroundColor = pageBackgroundColor;
    explanationLineThreeLabel.text = @"Please be patient.";
    explanationLineThreeLabel.font = [UIFont systemFontOfSize:10];
    explanationLineThreeLabel.textColor = [UIColor darkGrayColor];
    [explanationView addSubview:explanationLineThreeLabel];
    [explanationLineThreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(explanationView);
        make.top.equalTo(explanationLineTwoLabel.mas_bottom);
    }];


    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    int contentSide = 70;
    int gapBetweenContents = 7;
    collectionViewFlowLayout.itemSize = CGSizeMake(contentSide, contentSide);
    collectionViewFlowLayout.minimumLineSpacing = gapBetweenContents;
    collectionViewFlowLayout.minimumInteritemSpacing = gapBetweenContents;
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, gapBetweenContents, 0, gapBetweenContents);

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:collectionViewFlowLayout];
    collectionView.backgroundColor = pageBackgroundColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(explanationView.mas_bottom);
        make.right.equalTo(self.view);
    }];
    self.collectionView = collectionView;

    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = pageBackgroundColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@(BottomViewHeight));
    }];

    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.backgroundColor = [UIColor redColor];
    [startButton setTitle:@"Start Wish8!" forState:UIControlStateNormal];
    startButton.tintColor = [UIColor whiteColor];
    [startButton addTarget:self action:@selector(tapStartButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:startButton];
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.centerY.equalTo(bottomView);
        make.width.equalTo(bottomView).multipliedBy(0.5);
        make.height.equalTo(@(StartButtonHeight));
    }];

    [collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_top);
    }];

    [collectionView registerClass:[OSCollectionViewCell class]
       forCellWithReuseIdentifier:CollectionViewCellReuseIdentifier];

    self.contentCount = 40;

    self.selectedArray = [@[] mutableCopy];
}

- (void) tapStartButton:(UIButton *) tapStartButton {

}

- (NSInteger) collectionView:(UICollectionView *) collectionView numberOfItemsInSection:(NSInteger) section {
    return self.contentCount;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *) indexPath {
    OSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellReuseIdentifier
                                                                           forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor grayColor];
    [cell updateCellWithSelect:[self.selectedArray containsObject:@(indexPath.row)]];
    return cell;
}

- (void) collectionView:(UICollectionView *) collectionView didSelectItemAtIndexPath:(NSIndexPath *) indexPath {
    OSCollectionViewCell *cell = (OSCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    if ([self.selectedArray containsObject:@(indexPath.row)]) {
        [cell setSelected:NO];
        [self.selectedArray removeObject:@(indexPath.row)];
    } else {
        [cell setSelected:YES];
        [self.selectedArray addObject:@(indexPath.row)];
    }
    [collectionView reloadData];
}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = (scrollView.bounds.size.height < scrollView.contentSize.height) ? offset.y + bounds.size.height - inset.bottom : offset.y + size.height - inset.bottom;
    float h = size.height;
    float reload_distance = 0;
    if (y > h + reload_distance) {
        self.contentCount += 20;
        [self.collectionView reloadData];
    };
}

@end