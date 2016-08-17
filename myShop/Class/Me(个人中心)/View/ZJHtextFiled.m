//
//  ZJHtextFiled.m
//  baisibudejie
//
//  Created by zjh on 16/5/6.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHtextFiled.h"

@interface ZJHtextFiled ()

@property (nonatomic,strong) UILabel *placeholderlb;
@end

@implementation ZJHtextFiled

-(void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    UILabel *placeholder = [self valueForKey:@"placeholderLabel"];
    placeholder.textColor = [UIColor lightGrayColor];
    self.placeholderlb = placeholder;
}

-(void)textBegin
{
    self.placeholderlb.textColor = [UIColor whiteColor];
}


-(void)textEnd
{
    self.placeholderlb.textColor = [UIColor lightGrayColor];
}

@end
