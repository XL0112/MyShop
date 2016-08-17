//
//  ZJHLoginTextField.m
//  myShop
//
//  Created by zjh on 16/6/17.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHLoginTextField.h"

@implementation ZJHLoginTextField
/*
 1.文本框光标变成白色
 2.文本框开始编辑的时候，文本框占位文字颜色变成白色
 3.当文本框结束编辑，文本框要恢复之前占位文字颜色
 */


- (void)awakeFromNib
{

    self.tintColor = [UIColor darkGrayColor];
    // 监听文本框编辑:1.代理 2.通知 3.target
    // 不要自己成为自己代理
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;
    
}

// 文本框开始编辑的时候调用
- (void)textBegin
{
    // 设置占位文字为白色
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;
    
    // 快速设置占位文字颜色
    // self.placeholderColor = []
    
    //    UILabel *label;
    //    label.textColor;
    
}
// 文本框结束编辑的时候调用
- (void)textEnd
{
    // 设置占位文字为灰色
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    self.attributedPlaceholder = attrStr;
    
}
// 在哪写代码：考虑设置多少一次

@end
