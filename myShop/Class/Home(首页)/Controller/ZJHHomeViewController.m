//
//  ZJHHomeViewController.m
//  myShop
//
//  Created by zjh on 16/6/16.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHHomeViewController.h"
#import "CarouselViewController.h"
#import "AdvertisementViewController.h"
#import "AdvertisementItem.h"
#import <Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "ZJHShopsViewController.h"
#import <MJRefresh/MJRefresh.h>
//流水布局显示商品需要导入的类
#import "shopCell.h"
#import <AFNetworking/AFNetworking.h>
#import "ShopsItem.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>

#define shopHeight 200
static NSString *const shopCell_ID = @"shop";
// 图片轮播高度
static CGFloat const carouselViewHeight = 165;
// 小广告页高度
static CGFloat const advertisementViewHeight = 90;




@interface ZJHHomeViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;

/**< 需要展示的图片数组 */
@property (strong, nonatomic) NSArray *images;
/**< 需要展示的广告模型 */
@property (strong, nonatomic) NSArray *advertisementItems;

////流水布局显示商品需要的商品属性
//@property(nonatomic,strong) UICollectionView *shopCollectionView;

//需要展示的商品模型
@property(nonatomic,strong) NSMutableArray * shops;

@property(nonatomic,weak) ZJHShopsViewController *shopViewController;
@end

@implementation ZJHHomeViewController


#pragma mark - 数据加载
-(NSMutableArray *)shops{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}


- (NSArray *)advertisementItems {
    if (_advertisementItems == nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tempAd.plist" ofType:nil];
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *tempMutableArray = [NSMutableArray array];
        for (NSDictionary *tempDict in tempArray) {
            AdvertisementItem *tempItem = [AdvertisementItem advertisementItemWithDict:tempDict];
            [tempMutableArray addObject:tempItem];
        }
        _advertisementItems = [tempMutableArray copy];
    }
    return _advertisementItems;
}

- (NSArray *)images {
    if (_images == nil) {
        _images = [NSArray arrayWithObjects:@"image1",@"image2",@"image3",@"image4", nil];
    }
    return _images;
}

#pragma mark - 初始化自身属性

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSelf];
    }
    return self;
}

- (void)setupSelf {
    // 关闭scrollView的自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 装填子视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
//    设置顶部的广告推荐页面
    [self setupScrollView];

//    夜间模式
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    

}




- (void)setupScrollView {
    // 头部控件的大小
#pragma warning 这里需要再调整
    CGFloat headerViewHeight = carouselViewHeight + advertisementViewHeight  + YRCommonLargeMargin;
    // ---------------------------  创建ScrollView  --------------------------- //
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = CommonBackgroundColor;
    scrollView.contentSize = CGSizeMake(self.view.zjh_width, headerViewHeight + SCREEN_H + 200);
    scrollView.contentInset = UIEdgeInsetsMake(YRNavigationBarMaxY, 0, 0, 0);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentOffset = CGPointMake(0, -YRNavigationBarMaxY);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // ---------------------------  滚动图片  --------------------------- //
    CarouselViewController *carouselViewController = [[CarouselViewController alloc]init];
    carouselViewController.images = self.images;
    carouselViewController.viewSize = CGSizeMake(SCREEN_W, carouselViewHeight);
    carouselViewController.view.zjh_x = 0;
    carouselViewController.view.zjh_y = 0;
    [scrollView addSubview:carouselViewController.view];
    [self addChildViewController:carouselViewController];
    
     // ---------------------------  分类特色商品  --------------------------- //
    AdvertisementViewController *advertisementViewController = [[AdvertisementViewController alloc]init];
    advertisementViewController.viewSize = CGSizeMake(SCREEN_W, advertisementViewHeight);
    advertisementViewController.advertisementItems = self.advertisementItems;
    advertisementViewController.view.zjh_x = 0;
    advertisementViewController.view.zjh_y = carouselViewHeight;
    [scrollView addSubview:advertisementViewController.view];
    [self addChildViewController:advertisementViewController];
    
    
    
     // ---------------------------  流水布局显示商品  --------------------------- //
    
    ZJHShopsViewController *shopViewController = [[ZJHShopsViewController alloc] init];
//    shopViewController.viewSize = CGSizeMake(SCREEN_W, SCREEN_H - advertisementViewHeight - carouselViewHeight);
    shopViewController.view.zjh_x = 0;
    shopViewController.view.zjh_y = carouselViewHeight + advertisementViewHeight;
    [scrollView addSubview:shopViewController.view];
    [self addChildViewController:shopViewController];
    self.shopViewController = shopViewController;
    
}



// 滚动结束的时候调用(通过代码)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    固定高度
    CGFloat scrollViewH = advertisementViewHeight + carouselViewHeight - 64;
    if (scrollView.contentOffset.y >= scrollViewH ) {
//        self.shopViewController.CGPoint = scrollView.contentOffset;
        scrollView.contentOffset = CGPointMake(0, scrollViewH);
        self.shopViewController.tableView.scrollEnabled = YES;
    } else {
        self.shopViewController.tableView.scrollEnabled = NO;
    }

}
// 停止减速的时候调用(手动拖动)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


@end
