//
//  UIView+frame.m
//  baisibudejie
//
//  Created by zjh on 16/5/6.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

//宽度
-(void)setZjh_width:(CGFloat)zjh_width
{
    CGRect frame = self.frame;
    frame.size.width = zjh_width;
    self.frame = frame;
}

-(CGFloat)zjh_width
{
    return self.frame.size.width;
}

//高度
-(void)setZjh_height:(CGFloat)zjh_height
{
    CGRect frame = self.frame;
    frame.size.height = zjh_height;
    self.frame = frame;
}

-(CGFloat)zjh_height
{
    return self.frame.size.height;
}

//x
-(void)setZjh_x:(CGFloat)zjh_x
{
    CGRect frame = self.frame;
    frame.origin.x = zjh_x;
    self.frame = frame;
}
-(CGFloat)zjh_x
{
    return self.frame.origin.x;
}

//Y
-(void)setZjh_y:(CGFloat)zjh_y
{
    CGRect frame = self.frame;
    frame.origin.y = zjh_y;
    self.frame = frame;
}

-(CGFloat)zjh_y
{
    return self.frame.origin.y;
}
@end
