//
//  ZJHBuyAllShopList.m
//  myShop
//
//  Created by zjh on 16/7/4.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHBuyAllShopList.h"

@implementation ZJHBuyAllShopList

-(NSMutableArray *)shops
{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
        
    }
    return _shops;
}


//1.提供一个静态变量

static ZJHBuyAllShopList * _instance;

//2.重写该方法控制只分配一次空间
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
    
}
+(instancetype)share
{
    return [[self alloc] init];
}
@end
