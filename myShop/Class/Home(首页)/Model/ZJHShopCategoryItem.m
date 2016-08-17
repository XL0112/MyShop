//
//  ZJHShopCategoryItem.m
//  myShop
//
//  Created by zjh on 16/6/16.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHShopCategoryItem.h"

@implementation ZJHShopCategoryItem

+ (instancetype)shopCategoryItemWithDict:(NSDictionary *)dict{
    
    ZJHShopCategoryItem *shopItem = [[self alloc]init];
    shopItem.imageName = dict[@"imageName"];
    shopItem.labelText = dict[@"text"];
    return shopItem;
}
@end
