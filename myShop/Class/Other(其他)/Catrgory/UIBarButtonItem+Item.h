//
//  UIBarButtonItem+Item.h
//  baisibudejie
//
//  Created by zjh on 16/4/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
+(UIBarButtonItem *)barButtonItemWith:(UIImage *)image hlightImage:(UIImage *)hlightImage target:( id)target action:(SEL)action;


+(UIBarButtonItem *)barButtonItemWith:(UIImage *)image selectImage:(UIImage *)selecttImage target:(id)target action:(SEL)action;

@end
