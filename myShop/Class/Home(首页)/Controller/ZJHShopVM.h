//
//  ZJHShopVM.h
//  myShop
//
//  Created by zjh on 16/7/3.
//  Copyright © 2016年 home. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShopsItem;

@interface ZJHShopVM : NSObject

@property(nonatomic,strong) ShopsItem * item;
@property(nonatomic,assign) CGFloat * cell_H;
@end
