//
//  ZJHFastLoginButton.m
//  myShop
//
//  Created by zjh on 16/6/17.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHFastLoginButton.h"

@implementation ZJHFastLoginButton

- (void)layoutSubviews
{
    // 计算下子控件的位置
    [super layoutSubviews];
    
    self.imageView.zjh_x = (self.zjh_width - self.imageView.zjh_width) * 0.5;
    self.imageView.zjh_y = 0;
    
    // 设置文字宽度 1.计算文字宽度 2.设置label的宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.zjh_x = (self.zjh_width - self.titleLabel.zjh_width) * 0.5;
    self.titleLabel.zjh_y =  self.zjh_height - self.titleLabel.zjh_height;
}

@end
