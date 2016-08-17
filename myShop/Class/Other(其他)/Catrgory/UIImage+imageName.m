//
//  UIImage+imageName.m
//  baisibudejie
//
//  Created by zjh on 16/4/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "UIImage+imageName.h"


@implementation UIImage (imageName)

+(UIImage *)imageWithOriginalMode:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}


@end
