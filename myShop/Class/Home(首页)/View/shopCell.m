//
//  shopCell.m
//  myShop
//
//  Created by zjh on 16/6/16.
//  Copyright © 2016年 home. All rights reserved.
//

#import "shopCell.h"
#import "ShopsItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface shopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImageV;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UIView *BackView;


@end

@implementation shopCell

#pragma mark - 子视图装载
#pragma mark - 数据装载

-(void)setShopItem:(ShopsItem *)shopItem{
    _shopItem = shopItem;
    
    NSString *Price = [NSString stringWithFormat:@"¥:%@元",shopItem.g_price];
    self.nameLB.text = shopItem.g_name;
    self.priceLB.text = Price;
    
    
#pragma mark - 夜间模式
    self.shopImageV.layer.cornerRadius = 10;
    self.shopImageV.layer.masksToBounds = YES;
    self.shopImageV.backgroundColor = [UIColor clearColor];
    self.shopImageV.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.nameLB.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.BackView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);

}

@end
