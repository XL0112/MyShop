//
//  ZJHListShopsCell.h
//  myShop
//
//  Created by zjh on 16/6/19.
//  Copyright © 2016年 home. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZJHListShops,ZJHListShopsCell;
@protocol ZJHListShopsCellDelegate <NSObject>

-(void)shopCellDidClckPlusBtn:(ZJHListShopsCell *)cell;
-(void)shopCellDidCilckMinusBtn:(ZJHListShopsCell *)cell;

@end

@interface ZJHListShopsCell : UITableViewCell



@property(nonatomic,strong) ZJHListShops * shops;

@property(nonatomic,weak)id<ZJHListShopsCellDelegate> delegate;
@end
