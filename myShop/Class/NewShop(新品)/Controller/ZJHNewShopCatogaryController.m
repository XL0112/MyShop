//
//  ZJHNewShopCatogaryController.m
//  myShop
//
//  Created by zjh on 16/7/10.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHNewShopCatogaryController.h"
#import "ZJHNewShopViewController.h"
#import "ZJHWaiSheViewController.h"
#import "ZJHComputerViewController.h"
#import "ZJHNewClothesViewController.h"
#import "ZJHPhoneViewController.h"

/*
 设置标题问题
 1.按钮显示不出来 -》automaticallyAdjustsScrollViewInsets
 2.按钮标题颜色
 3.titleView不能滚动
 */

/*
 颜色：由3个颜色通道组成
 R:红色 G:绿色 B:蓝色
 黑色 0      0     0
 红色 1      0    0
 
 */




@interface ZJHNewShopCatogaryController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *titleView;
@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@end

@implementation ZJHNewShopCatogaryController


- (NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1.添加顶部标题View(UIScrollView)
    [self setupTitleView];
    
    // 2.添加底部内容View(UIScrollView)
    [self setupContentView];
    
    // 3.设置所有子控制器
    [self setupAllChildViewController];
    
    // 4.设置标题 由多少个子控制器决定
    [self setupAllTitle];
    
    // 导航控制器下，scrollView顶部会自动添加额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /*
     1.标题缩放 效果
     2.什么时候缩放 =》 1.选中标题 2.滚动内容view也需要进行标题缩放
     */
    
}
/*
 1.只要以后写然后效果
 2.分析什么时候需要这个效果，就知道在哪地方写代码
 3.分析怎么去实现这个效果
 */
// 选中标题按钮
- (void)selButton:(UIButton *)button
{
    [_selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedButton.transform = CGAffineTransformIdentity;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //  让标题居中
    [self setupTitleCenter:button];
    
    // 让标题缩放 scale
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    
    _selectedButton = button;
}
// 让标题居中
- (void)setupTitleCenter:(UIButton *)button
{
    // 让标题居中 -> 修改标题view的偏移量 -> 改多少
    CGFloat offsetX = button.center.x - SCREEN_W * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大偏移量
    CGFloat maxOffsetX = _titleView.contentSize.width - SCREEN_W;
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [_titleView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

// 点击标题的时候就会调用
- (void)btnClick:(UIButton *)button
{
    NSInteger i = button.tag;
    // 1.标题颜色变成红色
    [self selButton:button];
    
    // 2.把对应的子控制器的view添加上去
    [self setupChildControllerView:i];
    
    // 3.滚动到对应的位置
    CGFloat x = i * SCREEN_W;
    _contentView.contentOffset = CGPointMake(x, 0);
}

// 添加子控制器的view
- (void)setupChildControllerView:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    
    if (vc.view.superview) return;
    
    CGFloat x = i * SCREEN_W;
    vc.view.frame = CGRectMake(x, 0, _contentView.bounds.size.width, _contentView.bounds.size.height);
    [_contentView addSubview:vc.view];
}

#pragma mark -UIScrollViewDelegate
// 监听scrollView滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger leftI = scrollView.contentOffset.x / SCREEN_W;
    NSInteger rightI = leftI + 1;
    
    // 获取左边按钮
    UIButton *leftButton = self.titleButtons[leftI];
    UIButton *rightButton;
    
    if (rightI < self.titleButtons.count) {
        rightButton = self.titleButtons[rightI];
    }
    
    // 标题缩放 1.哪两个按钮需要缩放
    // 如何缩放 0 ~ 1
    CGFloat scaleR = scrollView.contentOffset.x / SCREEN_W - leftI;
    CGFloat scaleL = 1 - scaleR;
    
    // 左边 1 ~ 1.3
    leftButton.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1);
    
    // 右边
    rightButton.transform = CGAffineTransformMakeScale(scaleR * 0.3 + 1, scaleR * 0.3 + 1);
    
    // 颜色渐变
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    
}
// 滚动完成的时候就会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x / SCREEN_W;
    // scrollView默认有两个UIImageView子控件
    // 获取选中标题按钮
    UIButton *selButton = self.titleButtons[page];
    
    // 1.选中标题
    [self selButton:selButton];
    
    // 2.把对应子控制器的view添加上去
    [self setupChildControllerView:page];
    
}

// 设置标题
- (void)setupAllTitle
{
    
    // 遍历子控制
    NSInteger count = self.childViewControllers.count;
    CGFloat x = 0;
    CGFloat btnW = 100;
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        x = i * btnW;
        btn.frame = CGRectMake(x, 0, btnW, 35);
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [_titleView addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleButtons addObject:btn];
        
        if (i == 0) { // 默认选中第0个按钮
            [self btnClick:btn];
        }
    }
    
    // 设置scrollView滚动范围
    _titleView.contentSize = CGSizeMake(count * btnW, 0);
    _titleView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容滚动范围
    _contentView.contentSize = CGSizeMake(count * SCREEN_W, 0);
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.pagingEnabled = YES;
    
}

// 设置所有的子控制器
- (void)setupAllChildViewController
{
    // 新品
    ZJHNewShopViewController *topLine = [[ZJHNewShopViewController alloc] init];
    topLine.title = @"新品";
    topLine.name = @"xinpin";
    [self addChildViewController:topLine];
    
    // 手机
    ZJHNewShopViewController *hot = [[ZJHNewShopViewController alloc] init];
    hot.title = @"手机";
    hot.name = @"Snip20160616_1";
    [self addChildViewController:hot];
    
    // 电脑
    ZJHNewShopViewController *video = [[ZJHNewShopViewController alloc] init];
    video.title = @"电脑";
    video.name =  @"diannao";
    [self addChildViewController:video];
    
    // 外设
    ZJHNewShopViewController *scoiety = [[ZJHNewShopViewController alloc] init];
    scoiety.title = @"外设";
    scoiety.name = @"waishe";
    [self addChildViewController:scoiety];
    
    // 潮流服装
    ZJHNewShopViewController *reader = [[ZJHNewShopViewController alloc] init];
    reader.title = @"潮流服装";
    reader.name = @"chaoliuwaiyi";
    [self addChildViewController:reader];

    
}

// 添加顶部标题View
- (void)setupTitleView
{
    UIScrollView *titleView = [[UIScrollView alloc] init];
    CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
//    _titleView.backgroundColor = [UIColor whiteColor];
    titleView.frame = CGRectMake(0, y, SCREEN_W, 35);
    [self.view addSubview:titleView];
    _titleView = titleView;
    
}

// 添加底部内容View
- (void)setupContentView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    CGFloat y = CGRectGetMaxY(_titleView.frame);
    contentView.frame = CGRectMake(0, y, SCREEN_W, SCREEN_H - y);
    [self.view addSubview:contentView];
    contentView.delegate = self;
    _contentView = contentView;
}



@end
