//
//  ZJHBuyAllShopList.h
//  myShop
//
//  Created by zjh on 16/7/4.
//  Copyright © 2016年 home. All rights reserved.
//
//单例记录商品信息
#import <Foundation/Foundation.h>

@interface ZJHBuyAllShopList : NSObject

@property(nonatomic,strong) NSMutableArray * shops;

+(instancetype)share;
@end
