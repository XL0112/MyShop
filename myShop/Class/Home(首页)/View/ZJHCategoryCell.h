//
//  ZJHCategoryCell.h
//  baisibudejie
//
//  Created by zjh on 16/5/17.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJHCategoryItem;
@interface ZJHCategoryCell : UITableViewCell

@property(nonatomic,strong)  ZJHCategoryItem * item;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@end
