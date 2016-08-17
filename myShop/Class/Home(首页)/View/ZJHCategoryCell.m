//
//  ZJHCategoryCell.m
//  baisibudejie
//
//  Created by zjh on 16/5/17.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHCategoryCell.h"
#import "ZJHCategoryItem.h"

@interface ZJHCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *selectView;

@end

@implementation ZJHCategoryCell

- (void)awakeFromNib {
//    取消系统设置的自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectView.hidden = !selected;
    self.nameLB.textColor = selected ? [UIColor redColor] : [UIColor blackColor];

}

-(void)setItem:(ZJHCategoryItem *)item
{
    _item = item;
//    self.nameLB.text = item.name;
}
@end
