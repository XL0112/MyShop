//
//  ZJHRecommendViewController.m
//  baisibudejie
//
//  Created by zjh on 16/5/16.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHRecommendViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "ZJHCategoryItem.h"
#import "ZJHCategoryCell.h"
#import "ZJHSubTagCell.h"
#import "ZJHSubUserItem.h"
#import <MJRefresh/MJRefresh.h>
#import "ZJHBaiduMapViewController.h"
#import "ZJHBuyShopViewController.h"
#import "ShopsItem.h"

static NSString *const ID = @"cell";
@interface ZJHRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property(nonatomic,strong) AFHTTPSessionManager * manager;


@property(nonatomic,strong) ZJHCategoryItem * seletCategoryItem;
//保存分类的数组
@property(nonatomic,strong) NSArray * categorys;
@end

@implementation ZJHRecommendViewController
-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
//    设置标题
    self.title = @"推荐关注";
//    去掉所有的自动的64间距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    去除底部的图片
    self.leftTableView.tableFooterView = [[UIView alloc] init];
    
    //    夜间模式
    self.leftTableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.leftTableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
    self.rightTableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.rightTableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
    
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);

    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 40, 0);
    
//注册cell
//    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [self.leftTableView registerNib:[UINib nibWithNibName:@"ZJHCategoryCell" bundle:nil] forCellReuseIdentifier:ID];
    
//    右边的cell
//    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [self.rightTableView registerNib:[UINib nibWithNibName:@"ZJHSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
//    加载左边分类的数据
    [self reloadCategoryLeftDataSource];
//    添加上拉刷新
    [self topRefresh];
//    添加下拉刷新
    [self bottomRefresh];
    
//    刚创建好就刷新一次
    [self.rightTableView.mj_header beginRefreshing];
}
#pragma mark - 上下拉刷新
-(void)topRefresh
{
 
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreUseDataSource)];
    header.automaticallyChangeAlpha = YES;
    self.rightTableView.mj_header = header;
}
-(void)bottomRefresh{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadNewUseDataSource)];
    footer.automaticallyHidden = YES;
    self.rightTableView.mj_footer = footer;
}
#pragma mark -加载左边分类的数据
-(void)reloadCategoryLeftDataSource
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [self.manager GET:ZJHBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        成功加载数据后隐藏
        [self.rightTableView.mj_footer endRefreshing];
//        转成plist文件
//        [responseObject writeToFile:@"/Users/zjh/Desktop/category.plist" atomically:YES];
//        字典转模型
        NSArray *dictArr = responseObject[@"list"];
        self.categorys = [ZJHCategoryItem mj_objectArrayWithKeyValuesArray:dictArr];
        
//        刷新列表
        [self.leftTableView reloadData];
//        默认点击第一个
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.leftTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.leftTableView didSelectRowAtIndexPath:indexPath];
//        默认点击到第一个数据
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 加载头边用户推荐的数据
-(void)reloadNewUseDataSource{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = self.seletCategoryItem.ID;
    [self.manager GET:ZJHBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [responseObject writeToFile:@"/Users/zjh/Desktop/user.plist" atomically:YES];
        NSArray *dictArr = responseObject[@"list"];
        self.seletCategoryItem.next_page = responseObject[@"next_page"];
        self.seletCategoryItem.total_page = responseObject[@"total_page"];
        
        self.seletCategoryItem.users = [ZJHSubUserItem mj_objectArrayWithKeyValuesArray:dictArr];
        [self.rightTableView reloadData];
        
//        当上啦刷新后的页数,等于或者大于总页数的时候就隐藏底部刷新栏
        self.rightTableView.mj_footer.hidden = self.seletCategoryItem.next_page >= self.seletCategoryItem.total_page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)reloadMoreUseDataSource{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = self.seletCategoryItem.ID;
    parameters[@"page"] = self.seletCategoryItem.next_page;
    [self.manager GET:ZJHBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        下拉刷新后,自动隐藏
        [self.rightTableView.mj_header endRefreshing];
        //        [responseObject writeToFile:@"/Users/zjh/Desktop/user.plist" atomically:YES];
        NSArray *dictArr = responseObject[@"list"];
        self.seletCategoryItem.next_page = responseObject[@"next_page"];
        self.seletCategoryItem.total_page = responseObject[@"total_page"];
        
        [self.seletCategoryItem.users addObjectsFromArray:[ZJHSubUserItem mj_objectArrayWithKeyValuesArray:dictArr]];
        [self.rightTableView reloadData];
        
        self.rightTableView.mj_header.hidden = self.seletCategoryItem.next_page <= 0 ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - leftTableView设置数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        
        return self.categorys.count - 2;
    }
    return self.seletCategoryItem.users.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.leftTableView) {
        
        ZJHCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.item = self.categorys[indexPath.row];
        switch (indexPath.row) {
            case 0:
              cell.nameLB.text = @"全部商品";
                break;
            case 1:
                cell.nameLB.text = @"手机平板";
                break;
            case 2:
                cell.nameLB.text = @"电脑办公";
                break;
            case 3:
                cell.nameLB.text = @"数码影音";
                break;
            case 4:
                cell.nameLB.text = @"女性时尚";
                break;
            case 5:
                cell.nameLB.text = @"潮流新品";
                break;
            case 6:
                cell.nameLB.text = @"美食天地";
                break;
                
            default:
                break;
        }
        cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        cell.imageView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        cell.dk_backgroundColorPicker = DKColorPickerWithKey(bg);
       
        return cell;
    }
    ZJHSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selected = NO;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = cell.frame;
    [btn setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:btn];
    [btn addTarget:self action:@selector(BuyShop:) forControlEvents:UIControlEventTouchUpInside];
    cell.userItem = self.seletCategoryItem.users[indexPath.row];
    cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    cell.imageView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(bg);
    return cell;
}
//跳转界面
-(void)BuyShop:(UITableViewCell *)cell
{
    //   购物
    ZJHBuyShopViewController *buyShopVc = [[ZJHBuyShopViewController alloc] init];
    buyShopVc.view.backgroundColor = [UIColor whiteColor];
    ShopsItem *item = [[ShopsItem alloc] init];
    item.g_name = @"苹果手机 Apple iPhone SE 64g";
    item.g_price = @"4720";
//    ZJHShopVM *shopVm = self.shopsItemVM[indexPath.row];
    buyShopVc.item = item;
    [self.navigationController pushViewController:buyShopVc animated:YES];
}

#pragma mark - 设置代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        if (indexPath.row <=5) {
            self.seletCategoryItem = self.categorys[indexPath.row];
            
            if (self.seletCategoryItem.users.count) {
                
                [self.rightTableView reloadData];
                
                self.rightTableView.mj_footer.hidden = self.seletCategoryItem.next_page > self.seletCategoryItem.total_page;
                
                return;
            }
            //    加载右边的用户数据
            [self reloadNewUseDataSource];
        } else {
            ZJHBaiduMapViewController *baiduMap = [[ZJHBaiduMapViewController alloc] init];
            //  设置在跳转后,把view下的导航条隐藏
            baiduMap.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:baiduMap animated:YES];
            return;
        }

    }
    
  }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        return 44;
    }
    
    return 90;
}

@end
