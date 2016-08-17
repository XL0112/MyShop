//
//  UIBarButtonItem+ZJHItem.m
//  BaiSi
//
//  Created by zjh on 16/4/25.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "UIBarButtonItem+ZJHItem.h"

@implementation UIBarButtonItem (ZJHItem)


//高亮按钮的设置
+(UIBarButtonItem *)barButton:(UIImage *)image hightImage:(UIImage *)hightImage target:( id)target action:(SEL)action
{
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hightImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
  
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}


//选中按钮设置
+(UIBarButtonItem *)barButton:(UIImage *)image selesctImage:(UIImage *)selectImage target:( id)target action:(SEL)action
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}





@end
