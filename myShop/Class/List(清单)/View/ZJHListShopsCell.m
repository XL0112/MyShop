//
//  ZJHListShopsCell.m
//  myShop
//
//  Created by zjh on 16/6/19.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHListShopsCell.h"
#import "ZJHListShops.h"

@interface ZJHListShopsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ZJHListShopsCell

- (void)awakeFromNib {
//    self.addBtn.layer.borderWidth = 1;
//    self.addBtn.layer.borderColor = [UIColor orangeColor].CGColor;
//    self.addBtn.layer.cornerRadius = self.addBtn.frame.size.width * 0.5;
    
//    self.removeBtn.layer.borderWidth = 1;
//    self.removeBtn.layer.borderColor = [UIColor orangeColor].CGColor;
//    self.removeBtn.layer.cornerRadius = self.removeBtn.frame.size.width * 0.5;
}

//添加按钮
- (IBAction)addShopBtnClick:(UIButton *)sender {
    self.shops.count ++;
    self.countLabel.text= [NSString stringWithFormat:@"%d",self.shops.count];
    self.removeBtn.enabled = YES;
    
    if ([self.delegate respondsToSelector:@selector(shopCellDidClckPlusBtn:)]) {
        [self.delegate shopCellDidClckPlusBtn:self];
    
}
}


//减去按钮
- (IBAction)removeBtnClick:(UIButton *)sender {
    self.shops.count --;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.shops.count];
    
    if (self.shops.count <= 0) {
        self.removeBtn.enabled = NO;
    }
    if ([self.delegate respondsToSelector:@selector(shopCellDidCilckMinusBtn:)]) {
        [self.delegate shopCellDidCilckMinusBtn:self];
    }
  
    
}

////给cell中的数据
-(void)setShops:(ZJHListShops *)shops{
    _shops = shops;

    self.iconImageView.image = [UIImage imageNamed:shops.image];
    self.title.text = shops.name;
    self.price.text = shops.money;
    self.countLabel.text = [NSString stringWithFormat:@"%d",shops.count];
    if (shops.count >= 1) {
        self.removeBtn.enabled = YES;
    } else {
        self.removeBtn.enabled = NO;
    }
}



@end
