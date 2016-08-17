//
//  ZJHTabBar.m
//  baisibudejie
//
//  Created by zjh on 16/4/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#import "ZJHTabBar.h"
#import "ZJHShareViewController.h"

@interface ZJHTabBar()

@property(nonatomic,weak) UIButton * publish;
@end

@implementation ZJHTabBar


-(UIButton *)publish
{
    if (_publish == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageWithOriginalMode:@"tab_publish_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithOriginalMode:@"tab_publish_add_pressed"] forState:UIControlStateSelected];
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _publish = btn;
    }
    return _publish;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
//    NSLog(@"%@",self.subviews);
    
    
    CGFloat btnW = screenW / (count + 1);
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    int indext = 0;
    for (UIButton *btn in self.subviews) {
        
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            btnX = indext * btnW ;
            if (indext >= 2) {
                btnX = btnX + btnW;
            }
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            indext ++;
        }
    }
    self.publish.frame = CGRectMake(0, 0, btnW, self.bounds.size.height);
    self.publish.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}


-(void)publishClick
{
    ZJHShareViewController *share = [[ZJHShareViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:share animated:YES completion:nil];
}
@end
