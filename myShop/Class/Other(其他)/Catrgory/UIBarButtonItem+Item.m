//
//  UIBarButtonItem+Item.m
//  baisibudejie
//
//  Created by zjh on 16/4/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

//设置高亮状态下的按钮设置
+(UIBarButtonItem *)barButtonItemWith:(UIImage *)image hlightImage:(UIImage *)hlightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hlightImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *contetView = [[UIView alloc] initWithFrame:btn.bounds];
    [contetView addSubview:btn];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:contetView];
}


//设置点击状态下的按钮设置
+(UIBarButtonItem *)barButtonItemWith:(UIImage *)image selectImage:(UIImage *)selecttImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selecttImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *contetView = [[UIView alloc] initWithFrame:btn.bounds];
    [contetView addSubview:btn];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:contetView];
}
@end
