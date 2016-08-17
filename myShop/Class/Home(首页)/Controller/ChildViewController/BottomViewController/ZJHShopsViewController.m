//
//  ZJHShopsViewController.m
//  myShop
//
//  Created by zjh on 16/6/16.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHShopsViewController.h"
#import "shopCell.h"
#import <AFNetworking/AFNetworking.h>
#import "ShopsItem.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "ZJHShopVM.h"
#import "ZJHShopsTitleCell.h"
#import "ZJHBuyShopViewController.h"

#define shopHeight 200
// 图片轮播高度
static CGFloat const carouselViewHeight = 165;
// 小广告页高度
static CGFloat const advertisementViewHeight = 90;
static NSString *const shopCell_ID = @"shop";
static NSString *const shopsTitieCell = @"titlecell";

static CGFloat const margin = 1;
static NSInteger const cols = 2;
@interface ZJHShopsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *shopCollectionView;
//需要展示的商品模型
@property(nonatomic,strong) NSMutableArray * shopsItemVM;

@property (assign, nonatomic) BOOL isFirst;
@end

@implementation ZJHShopsViewController
-(NSMutableArray *)shopsItemVM{
        if (_shopsItemVM == nil) {
    
            _shopsItemVM = [NSMutableArray array];
        }
        return _shopsItemVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    注册TitleCell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZJHShopsTitleCell" bundle:nil] forCellReuseIdentifier:shopsTitieCell];
    // 设置底部的商品界面
    [self setUpCollectionView];
    
//    请求数据
    [self loadSouce];
    
    //    添加上拉刷新
    [self setMiddleRefresh];
    _isFirst = NO;
//    内部不能滚动
    self.tableView.scrollEnabled = NO;
//    向下多一个140的内边距主要是为了能看到刷新样式
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 140, 0);
}
#pragma mark - 请求数据


-(void)setMiddleRefresh
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSource)];
    
    footer.automaticallyHidden = YES;
    
    self.tableView.mj_footer = footer;
}

#pragma mark - 加载数据
-(void)loadSouce{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.封装参数
    //    http://test.qb1y.com/?c=api_goods&a=getAllGoodsList&callType=JSON
    NSDictionary *parameters = @{
                                 @"c":@"api_goods",
                                 @"a":@"getAllGoodsList",
                                 @"callType":@"JSON"
                                 };
    
    [manager GET:@"http://test.qb1y.com" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        DLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/zjh/Desktop/shop.plist" atomically:YES];
        
        NSArray *arrList = responseObject[@"list"];
        
      NSArray *shops = [ShopsItem mj_objectArrayWithKeyValuesArray:arrList];
        
        for (ShopsItem *item in shops) {
            ZJHShopVM *shopsVM = [[ZJHShopVM alloc] init];
            shopsVM.item = item;
            
            [self.shopsItemVM addObject:shopsVM];
        }
        // 设置collectionView高度
        // 总行数：(总数 - 1) / 总列数 + 1  8
        NSInteger rows = (self.shopsItemVM.count - 1) / cols + 1;
        CGFloat h = rows * shopHeight + rows * margin;
        self.shopCollectionView.zjh_height = h;
        
         [self.shopCollectionView reloadData];
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DLog(@"%@",error);
    }];
}

-(void)loadMoreSource{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.封装参数
    //    http://test.qb1y.com/?c=api_goods&a=getAllGoodsList&callType=JSON
    NSDictionary *parameters = @{
                                 @"c":@"api_goods",
                                 @"a":@"getAllGoodsList",
                                 @"callType":@"JSON"
                                 };
    
    [manager GET:@"http://test.qb1y.com" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        结束刷新
        [self.tableView.mj_footer endRefreshing];
        //        DLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/zjh/Desktop/shop.plist" atomically:YES];
        
        NSArray *arrList = responseObject[@"list"];
        
        NSArray *shops = [ShopsItem mj_objectArrayWithKeyValuesArray:arrList];
        
        for (ShopsItem *item in shops) {
            ZJHShopVM *shopsVM = [[ZJHShopVM alloc] init];
            shopsVM.item = item;
            
            [self.shopsItemVM addObject:shopsVM];
        }
        // 设置collectionView高度
        // 总行数：(总数 - 1) / 总列数 + 1  8
        NSInteger rows = (self.shopsItemVM.count - 1) / cols + 1;
        CGFloat h = rows * shopHeight + rows * margin;
        self.shopCollectionView.zjh_height = h;
        
//        刷新列表
        [self.shopCollectionView reloadData];
        [self.tableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DLog(@"%@",error);
    }];
}
- (void)setUpCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动条方向<纵向>
    layout.itemSize = CGSizeMake((SCREEN_W - 1) * 0.5, shopHeight); // 设置cell尺寸
    layout.minimumLineSpacing = 1; // 行间距
    layout.minimumInteritemSpacing = 1; //列间距
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    CGRect collectionFrame = CGRectMake(0, 0, SCREEN_W, 1005);
    UICollectionView *shopCollectionView = [[UICollectionView alloc]initWithFrame: collectionFrame collectionViewLayout:layout];
    shopCollectionView.backgroundColor = [UIColor clearColor];
    // 数据源和代理
    shopCollectionView.delegate = self;
    shopCollectionView.dataSource = self;
    shopCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 显示效果设定
//    shopCollectionView.bounces = YES;
    shopCollectionView.showsVerticalScrollIndicator = NO;
    shopCollectionView.showsHorizontalScrollIndicator = NO;
    shopCollectionView.scrollEnabled = NO;
    
    self.shopCollectionView = shopCollectionView;
    
    // 注册CELL
//    [shopCollectionView registerClass:[shopCell class] forCellWithReuseIdentifier:shopCell_ID];
    [shopCollectionView registerNib:[UINib nibWithNibName:@"shopCell" bundle:nil] forCellWithReuseIdentifier:shopCell_ID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shopsItemVM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    shopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopCell_ID forIndexPath:indexPath];
    ZJHShopVM *ShopItemVM = self.shopsItemVM[indexPath.row];
    cell.shopItem = ShopItemVM.item;
    
    return cell;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
        ZJHShopsTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:shopsTitieCell forIndexPath:indexPath];
        cell.selected = NO;
        cell.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:self.shopCollectionView];
        return cell;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return self.shopCollectionView.zjh_height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_isFirst == NO) {
        _isFirst = YES;
        return;
    }
    if (scrollView.contentOffset.y < -(64)) {
        scrollView.scrollEnabled = NO;
        // _isFirst = NO;
        
        CGPoint tempPoint = scrollView.contentOffset;
        tempPoint.y = 0;
        scrollView.contentOffset = tempPoint;
    }
//    NSLog(@"---+++%lf",scrollView.contentOffset.y);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//   购物
    ZJHBuyShopViewController *buyShopVc = [[ZJHBuyShopViewController alloc] init];
    buyShopVc.view.backgroundColor = [UIColor whiteColor];
    ZJHShopVM *shopVm = self.shopsItemVM[indexPath.row];
    buyShopVc.item = shopVm.item;
    [self.navigationController pushViewController:buyShopVc animated:YES];
    
}

@end
