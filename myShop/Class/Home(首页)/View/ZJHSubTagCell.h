//
//  ZJHSubTagCell.h
//  baisibudejie
//
//  Created by zjh on 16/5/13.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJHSubTagItem,ZJHSubUserItem;
@interface ZJHSubTagCell : UITableViewCell

@property(nonatomic,strong)  ZJHSubTagItem * item;


@property(nonatomic,strong) ZJHSubUserItem * userItem;
@end
