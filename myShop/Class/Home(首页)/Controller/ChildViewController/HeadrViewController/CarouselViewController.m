//
//  CarouselViewController.m
//  Entertainer
//
//  Created by funeral on 15/10/6.
//  Copyright © 2015年 funeral. All rights reserved.
//

#import "CarouselViewController.h"
#import "CarouselCell.h"

static NSString *const carouselCellIdentifier = @"CarouselCell";
static NSInteger const MAXCarousel = 10000;

@interface CarouselViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CarouselViewController

- (void)loadView {
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewSize.width, _viewSize.height)];
    tempView.backgroundColor = [UIColor clearColor];
    self.view = tempView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollectionView];
    [self setUpPageControll];
    [self beginTimer];
}

- (void)setUpCollectionView{
    // 创建一个流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 设置滚动条方向<纵向>
    layout.itemSize = CGSizeMake(self.view.zjh_width, self.view.zjh_height); // 设置cell尺寸
    layout.minimumLineSpacing = 0; // 行间距
    layout.minimumInteritemSpacing = 0; // 列间距
    
    UICollectionView *tempCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    // 数据源和代理
    tempCollectionView.delegate = self;
    tempCollectionView.dataSource = self;
    
    // 显示效果设定
    tempCollectionView.pagingEnabled = YES;
    tempCollectionView.bounces = NO;
    tempCollectionView.showsVerticalScrollIndicator = NO;
    tempCollectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置数据源代理
    [tempCollectionView registerClass:[CarouselCell class] forCellWithReuseIdentifier:carouselCellIdentifier];
    
    [self.view addSubview:tempCollectionView];
    self.collectionView = tempCollectionView;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.images.count*MAXCarousel/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)setUpPageControll {
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    CGFloat pageControlX = 80;
    CGFloat pageControlY = self.view.zjh_height - 20;
    pageControl.frame = CGRectMake(pageControlX, pageControlY, 0, 0);
    
    [pageControl setValue:[UIImage imageNamed:@"pageControl_icon"] forKeyPath:@"_pageImage"];
    [pageControl setValue:[UIImage imageNamed:@"pageControl_icon_selected"] forKeyPath:@"_currentPageImage"];
    pageControl.backgroundColor = RandomColor;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    pageControl.numberOfPages = self.images.count;
    pageControl.currentPage = 1;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count * MAXCarousel;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:carouselCellIdentifier forIndexPath:indexPath];
    cell.imageName = self.images[indexPath.row % self.images.count];
    self.pageControl.currentPage = indexPath.row % self.images.count;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self beginTimer];
}

- (void)nextPage {
    NSIndexPath *currentIndexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    NSInteger nextItem = currentIndexPath.item+1;
    NSInteger nextSection = currentIndexPath.section;
    NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    if (nextItem == MAXCarousel * self.images.count) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.images.count*MAXCarousel/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        return;
    }
    if (nextItem == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.images.count*MAXCarousel/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        return;
    }
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - 定时器相关
- (void)beginTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    //添加到runloop中
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer=timer;
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

@end
