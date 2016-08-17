//
//  ZJHMeViewController.m
//  myShop
//
//  Created by zjh on 16/6/15.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHMeViewController.h"

@interface ZJHMeViewController ()

@end

@implementation ZJHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    设置标题
//    self.navigationItem.title = @"个人中心";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"白天" forState:UIControlStateNormal];
    [btn setTitle:@"夜晚" forState:UIControlStateSelected];
    
    btn.frame = CGRectMake(0, 0, 30, 20);
    [btn addTarget:self action:@selector(NightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)NightBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected == 1) {
        self.dk_manager.themeVersion = DKThemeVersionNight;
    }else if (btn.selected == 0){
        self.dk_manager.themeVersion = DKThemeVersionNormal;
    }
}



@end
