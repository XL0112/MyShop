//
//  ZJHShopsViewModel.m
//  myShop
//
//  Created by zjh on 16/6/19.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHShopsViewModel.h"
#import "ZJHListShops.h"

@implementation ZJHShopsViewModel

-(void)setShops:(ZJHListShops *)shops{
    _shops = shops;
    // 先计算好每个cell的高度
    // 计算topView
    CGFloat margin = 10;
    CGFloat imageW = 50;
    CGFloat priceLbH = 25 ;

    CGFloat nameLbW = SCREEN_W - (2 * margin + imageW);
    NSString *nameLb = [shops name];
    // 注意：计算文字高度，使用constrainedToSize
    CGFloat nameLbH = [nameLb sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(nameLbW, MAXFLOAT)].height;
    
    _cellH = nameLbH + 2 * margin + priceLbH;
}
@end
