//
//  UIBarButtonItem+ZJHItem.h
//  BaiSi
//
//  Created by zjh on 16/4/25.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZJHItem)


+(UIBarButtonItem *)barButton:(UIImage *)image hightImage:(UIImage *)hightImage target:( id)target action:(SEL)action;


+(UIBarButtonItem *)barButton:(UIImage *)image selesctImage:(UIImage *)selectImage target:( id)target action:(SEL)action;
@end
