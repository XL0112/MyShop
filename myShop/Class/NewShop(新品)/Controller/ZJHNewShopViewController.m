//
//  ZJHNewShopViewController.m
//  myShop
//
//  Created by zjh on 16/6/15.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHNewShopViewController.h"
#import "WaterFlowLayout.h"
#import "FlowLayoutShopCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "ShopsItem.h"
#import <MJExtension/MJExtension.h>
#import "ZJHShopVM.h"
#import "shopCell.h"
#import "ZJHBuyShopViewController.h"

static NSString * const ID = @"cell";
@interface ZJHNewShopViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray * shopsItemVM;
@end

@implementation ZJHNewShopViewController
-(NSMutableArray *)shopsItemVM{
    if (_shopsItemVM == nil) {
        
        _shopsItemVM = [NSMutableArray array];
    }
    return _shopsItemVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    设置标题
    self.navigationItem.title = @"新品";
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);

//    添加流水布局
    [self addCollectionView];
    
//    添加数据
    [self loadSouce];
    
//    添加底部刷新
    [self setMiddleRefresh];
}
#pragma mark - 请求数据


-(void)setMiddleRefresh
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSource)];
    
    footer.automaticallyHidden = YES;
    
    self.collectionView.mj_footer = footer;
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
         //        刷新列表
        [self.collectionView reloadData];
        
        
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
        [self.collectionView.mj_footer endRefreshing];
        //        DLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/zjh/Desktop/shop.plist" atomically:YES];
        
        NSArray *arrList = responseObject[@"list"];
        
        NSArray *shops = [ShopsItem mj_objectArrayWithKeyValuesArray:arrList];
        
        for (ShopsItem *item in shops) {
            ZJHShopVM *shopsVM = [[ZJHShopVM alloc] init];
            shopsVM.item = item;
            
            [self.shopsItemVM addObject:shopsVM];
        }
        //        刷新列表
        [self.collectionView reloadData];

        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DLog(@"%@",error);
    }];
}


- (void)addCollectionView
{
    
    // 创建流水布局
    WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
//    显示底部刷新位置
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 130, 0);
    [collectionView registerNib:[UINib nibWithNibName:@"shopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    collectionView.showsHorizontalScrollIndicator = NO;
    
}




#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shopsItemVM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    shopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    ZJHShopVM *shopVM = self.shopsItemVM[indexPath.row];
    cell.shopItem = shopVM.item;
//    cell.imageV.image = [UIImage imageNamed:_name];
    return cell;
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
