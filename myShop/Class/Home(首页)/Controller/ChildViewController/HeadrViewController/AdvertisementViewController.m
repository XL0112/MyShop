//
//  AdvertisementViewController.m
//  Entertainer
//
//  Created by funeral on 15/10/6.
//  Copyright © 2015年 funeral. All rights reserved.
//

#import "AdvertisementViewController.h"
#import "AdvertisementItem.h"
#import "AdvertisementCell.h"
#import "ZJHRecommendViewController.h"
#import "ZJHNewShopsViewController.h"
#import "ZJHHotrecommendViewController.h"
#import "ZJHQuestionViewController.h"

static CGFloat const ADCellSize = 70;
static NSString *const advertisementCell_ID = @"AdvertisementCell";

@interface AdvertisementViewController ()

@end

@implementation AdvertisementViewController

#pragma mark - 视图装载
- (void)loadView {
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewSize.width, _viewSize.height)];
    tempView.backgroundColor = [UIColor whiteColor];
    self.view = tempView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置collectionView
    [self setUpCollectionView];
    
#pragma mark - 夜间模式
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 设置滚动条方向<纵向>
    layout.itemSize = CGSizeMake(SCREEN_W  / 5, ADCellSize); // 设置cell尺寸
    layout.minimumLineSpacing = SCREEN_W / 15; // 行间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CGRect collectionFrame = self.view.bounds;
    UICollectionView *tempCollectionView = [[UICollectionView alloc]initWithFrame: collectionFrame collectionViewLayout:layout];
    tempCollectionView.backgroundColor = [UIColor clearColor];
    // 数据源和代理
    tempCollectionView.delegate = self;
    tempCollectionView.dataSource = self;
    
    // 显示效果设定
    tempCollectionView.bounces = YES;
    tempCollectionView.showsVerticalScrollIndicator = NO;
    tempCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview: tempCollectionView];
    self.collectionView = tempCollectionView;
    
    // 注册CELL
    [tempCollectionView registerNib:[UINib nibWithNibName:@"AdvertisementCell" bundle:nil] forCellWithReuseIdentifier:advertisementCell_ID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.advertisementItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AdvertisementCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:advertisementCell_ID forIndexPath:indexPath];
    cell.advertisementItem = self.advertisementItems[indexPath.row];
    return cell;
}

//点击中间的collectionView,跳转指定的控制器
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZJHRecommendViewController *shopCagetory = [[ZJHRecommendViewController alloc] init];
        [self.navigationController pushViewController:shopCagetory animated:YES];
    } else if (indexPath.row == 1) {
        ZJHNewShopsViewController *NewShop = [[ZJHNewShopsViewController alloc] init];
        [self.navigationController pushViewController:NewShop animated:YES];
    }else if (indexPath.row == 2) {
        ZJHHotrecommendViewController *hotVc = [[ZJHHotrecommendViewController alloc] init];
        [self.navigationController pushViewController:hotVc animated:YES];
    }else if (indexPath.row == 3) {
        ZJHQuestionViewController *question = [[ZJHQuestionViewController alloc] init];
        question.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:question animated:YES];
    }
}

@end
