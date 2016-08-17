//
//  ZJHShopsViewModel.h
//  myShop
//
//  Created by zjh on 16/6/19.
//  Copyright © 2016年 home. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZJHListShops;

@interface ZJHShopsViewModel : NSObject

@property(nonatomic,strong) ZJHListShops * shops;

@property(nonatomic,assign) CGFloat  cellH;

@end
