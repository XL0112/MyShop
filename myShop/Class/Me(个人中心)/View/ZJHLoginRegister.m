//
//  ZJHLoginRegister.m
//  baisibudejie
//
//  Created by zjh on 16/5/6.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHLoginRegister.h"

@interface ZJHLoginRegister ()

@end

@implementation ZJHLoginRegister

+(instancetype)liginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


+(instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
