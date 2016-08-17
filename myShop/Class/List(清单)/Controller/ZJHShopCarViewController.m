//
//  ZJHShopCarViewController.m
//  myShop
//
//  Created by zjh on 16/6/19.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHShopCarViewController.h"
#import "ZJHListShops.h"
#import "ZJHListShopsCell.h"
#import <MJExtension/MJExtension.h>
#import "ZJHstrikeController.h"
#import "ZJHShopsViewModel.h"
#import "ShopsItem.h"
#import "ZJHBuyAllShopList.h"

@interface ZJHShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,ZJHListShopsCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//总价格
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
//主要是记录购买了什么商品
@property(nonatomic,strong) NSMutableArray * shoppingCar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editingcontent;
//结算按钮
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@end


static NSString *const ID = @"shop";
@implementation ZJHShopCarViewController

-(NSMutableArray *)shoppingCar{
    if (_shoppingCar == nil) {
        _shoppingCar = [NSMutableArray array];
    }
    return _shoppingCar;
}

//对于再次添加数据的处理
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    ZJHBuyAllShopList *buyShopsList = [[ZJHBuyAllShopList alloc] init];
    NSMutableArray *shopM = [NSMutableArray array];
    for (ShopsItem *shopsItem in buyShopsList.shops) {
        ZJHListShops *shop = [[ZJHListShops alloc] init];
        shop.name = shopsItem.g_name;
        shop.money = shopsItem.g_price;
        shop.image = @"Snip20160616_1";
        ZJHShopsViewModel *shopsVM = [[ZJHShopsViewModel alloc] init];
        shopsVM.shops = shop;
        [shopM addObject:shopsVM];
    }
    [self.shops removeAllObjects];
    self.shops = shopM;
    [self.tableView reloadData];
}
-(NSMutableArray *)shops{
    if (_shops == nil) {
        ZJHBuyAllShopList *buyShopsList = [[ZJHBuyAllShopList alloc] init];
        NSMutableArray *shopM = [NSMutableArray array];
        for (ShopsItem *shopsItem in buyShopsList.shops) {
            ZJHListShops *shop = [[ZJHListShops alloc] init];
            shop.name = shopsItem.g_name;
            shop.money = shopsItem.g_price;
            shop.image = @"Snip20160616_1";
            ZJHShopsViewModel *shopsVM = [[ZJHShopsViewModel alloc] init];
            shopsVM.shops = shop;
            [shopM addObject:shopsVM];
        }
        _shops = shopM;
    }

    return _shops;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    设置标题
    self.navigationItem.title = @"购物车";
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    //    夜间模式
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
    
    //   添加标记页面
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:5];
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(editingBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, -60, 0);

}
//点击cell的加好就会调用这个代理方法
-(void)shopCellDidClckPlusBtn:(ZJHListShopsCell *)cell{
    
    int price = self.priceLable.text.intValue + cell.shops.money.intValue;
    self.priceLable.text = [NSString stringWithFormat:@"%d",price];
    if (![self.shoppingCar containsObject:cell.shops]) {
        [self.shoppingCar addObject:cell.shops];
    }
    self.buyBtn.enabled = YES;
    
    
    
}
//点击cell的减号就会调用这个代理方法
-(void)shopCellDidCilckMinusBtn:(ZJHListShopsCell *)cell
{
    
    int price = self.priceLable.text.intValue - cell.shops.money.intValue;
    self.priceLable.text = [NSString stringWithFormat:@"%d",price];
    
    //    清楚某个商品
    if (cell.shops.count == 0) {
        [self.shoppingCar removeObject:cell.shops];
    }
    self.buyBtn.enabled = (price > 0);
}

//结算
- (IBAction)buyBtnn {
    //   打印购买了几件商品
    for (ZJHListShops *shop in self.shoppingCar) {
        NSLog(@"购买了%d部%@",shop.count,shop.name);
    }
    ZJHstrikeController *strike = [[ZJHstrikeController alloc] init];
    strike.hidesBottomBarWhenPushed = YES;
    strike.money = [self.priceLable.text doubleValue];
    [self.navigationController pushViewController:strike animated:YES];
}

//清空购物车
- (IBAction)clearBtn {
    
    self.priceLable.text = @"0";
    for (ZJHListShops *shop in self.shoppingCar) {
        shop.count = 0;
    }
    
    [self.tableView reloadData];
    
    [self.shoppingCar removeAllObjects];
    
    self.buyBtn.enabled = NO;
    
}



#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shops.count;
    
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       ZJHListShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    ZJHShopsViewModel *shopVM = self.shops[indexPath.row];
    cell.shops = shopVM.shops;
    
    cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJHShopsViewModel *shopVM = self.shops[indexPath.row];
    
    return shopVM.cellH;
}



#pragma mark - UITableViewDelegate
/**
 *  只要实现这个方法,就拥有左滑删除功能
 *  点击系统自动的Delete按钮会调用这个方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 修改模型
    ZJHShopsViewModel *shopVM = self.shops[indexPath.row];
    ZJHListShops *shops = shopVM.shops;
    int price = self.priceLable.text.intValue - shops.money.intValue * shops.count;
    self.priceLable.text = [NSString stringWithFormat:@"%d",price];
    [self.shops removeObjectAtIndex:indexPath.row];
    [self.shoppingCar removeObject:shops];
//    删除数据库中的数据
    ZJHBuyAllShopList *buyShopsList = [[ZJHBuyAllShopList alloc] init];
    [buyShopsList.shops removeObject:buyShopsList.shops[indexPath.row]];
    
    // 局部刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

/**
 *  修改系统默认的Delete的文字
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
    //    return [NSString stringWithFormat:@"删除-%zd",indexPath.row];
}

#pragma mark - 按钮的监听事件

//批量删除
- (IBAction)MultipleRemove {
    
    // 进入编辑模式
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    
    // 控制删除按钮隐藏还是显示
//    self.removeBtn.hidden = !self.tableView.isEditing;
    
}
//删除按钮
- (IBAction)remove {
    //    你点击那个行,那么哪一行的索引就通过indexPathsForSelectedRows告诉你了
    //    NSLog(@"%@",self.tableView.indexPathsForSelectedRows);
    // 注意点:千万不要一边遍历数组,一边删除.因为你每删除一个元素,其它元素的索引可能会发生变化
    // 1.获取要删除的模型
    NSMutableArray *deletshop = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
        [deletshop addObject:self.shops[indexPath.row]];
    }
    
    // 2.修改模型
    int price = 0;
    for (ZJHShopsViewModel *shopVm in self.shops) {
        
        ZJHListShops *shops = shopVm.shops;
        shops.count = 1;
        price = price + shops.money.intValue;
        [self.shoppingCar addObject:shops];
    }
    self.priceLable.text = [NSString stringWithFormat:@"%d",price];
    self.buyBtn.enabled = price > 0;
    [self.shops removeObjectsInArray:deletshop];
    
    // 3.刷新
    [self.tableView deleteRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView reloadData];
}



//显示结账界面
-(void)editingBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.editingcontent.constant = self.editingcontent.constant == 0 ?  -50 : 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

//选中全部商品
- (IBAction)allShop:(UIButton *)sender {
  
    [self BuyAllShop];
}

//全部选择商品
-(void)BuyAllShop{
    int price = 0;
    for (ZJHShopsViewModel *shopVm in self.shops) {
        
        ZJHListShops *shops = shopVm.shops;
        shops.count = 1;
        price = price + shops.money.intValue;
        [self.shoppingCar addObject:shops];
    }
    
    self.priceLable.text = [NSString stringWithFormat:@"%d",price];
    self.buyBtn.enabled = price > 0;
    [self.tableView reloadData];
}

@end
