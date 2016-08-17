//
//  ZJHBuyShopViewController.m
//  myShop
//
//  Created by zjh on 16/7/4.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHBuyShopViewController.h"
#import "CarouselViewController.h"
#import "ShopsItem.h"
#import "ZJHBuyAllShopList.h"
#import "ZJHShopCarViewController.h"

//展示图片的高度
CGFloat carouselViewHeight = 165;
@interface ZJHBuyShopViewController ()
@property (weak, nonatomic) IBOutlet UIView *scrolleShop;

/**< 需要展示的图片数组 */
@property (strong, nonatomic) NSArray *images;

@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneName;

@end

@implementation ZJHBuyShopViewController

- (NSArray *)images {
    if (_images == nil) {
        _images = [NSArray arrayWithObjects:@"iPhone",@"xiaomi", @"leshi",nil];
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpScrolleShop];

    //    夜间模式
    self.view.backgroundColor = [UIColor clearColor];
    self.view.dk_backgroundColorPicker =  DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
}

-(void)setUpScrolleShop
{
    CarouselViewController *carouselViewController = [[CarouselViewController alloc]init];
    carouselViewController.images = self.images;
    carouselViewController.viewSize = CGSizeMake(SCREEN_W, carouselViewHeight);
    carouselViewController.view.zjh_x = 0;
    carouselViewController.view.zjh_y = -5;
    [self.scrolleShop addSubview:carouselViewController.view];
//    [self.view addSubview:carouselViewController.view];
    [self addChildViewController:carouselViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setItem:(ShopsItem *)item
{
    _item = item;
    self.phoneName.text = item.g_name;
    self.priceLB.text = [NSString stringWithFormat:@"¥:%@",item.g_price];
    
    
}
//购买页面
- (IBAction)buyBtnClick:(UIButton *)sender {
    ZJHBuyAllShopList *buyShopList = [ZJHBuyAllShopList share];
    [buyShopList.shops addObject:_item];
    
    
    
}

//加入购物车
- (IBAction)addShopingList:(UIButton *)sender {
//    单例来存储购买的商品信息
    ZJHBuyAllShopList *buyShopList = [ZJHBuyAllShopList share];
    if (![buyShopList.shops containsObject:_item]) {
        [buyShopList.shops addObject:_item];
    }

}

@end
