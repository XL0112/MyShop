//
//  ZJHLoginRegister ViewController.m
//  baisibudejie
//
//  Created by zjh on 16/5/1.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHLoginRegisterViewController.h"
#import "ZJHLoginRegister.h"
#import "ZJHFastLoginView.h"
#import "ZJHSettingViewController.h"

@interface ZJHLoginRegisterViewController ()
//中间的View
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) ZJHLoginRegister *login;
@property (weak, nonatomic)ZJHLoginRegister *regiter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MiddleLeft;

//底部的View
@property (weak, nonatomic) ZJHFastLoginView *fastLogin;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *backImange;

@end

@implementation ZJHLoginRegisterViewController
//登录注册按钮
- (IBAction)login_register:(UIButton *)sender {
    sender.selected = !sender.selected;
  self.MiddleLeft.constant = self.MiddleLeft.constant == 0 ? -SCREEN_W : 0;
    

    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    添加标题
    self.navigationItem.title = @"个人中心";
    
//    添加中间的登录视图
    [self setUpMiddleView];
    
    //    添加中间的登录视图
    [self setUpBottomView];
//    给背部imageView添加一张图片
    
//设置导航条
    [self setupNavgationBar];

#pragma mark - 夜间模式
    self.view.backgroundColor = [UIColor clearColor];
    self.view.dk_backgroundColorPicker =  DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);

}

#pragma mark - 设置导航条
- (void)setupNavgationBar
{
    // 左边
    //    添加左边按钮
    //    setting
    UIBarButtonItem *setting = [UIBarButtonItem barButton:[UIImage imageNamed:@"mine-setting-icon"] hightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    
    
    //    moon
    UIBarButtonItem *moon = [UIBarButtonItem barButton:[UIImage imageNamed:@"mine-moon-icon"] selesctImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonClick:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,moon];
    
    
    // 影响底部UITabBarButton
    // self.title = @"我的关注";
}
#pragma mark - 设置界面
-(void)settingClick{
    
    ZJHSettingViewController *setting = [[ZJHSettingViewController alloc] init];
    //  设置在跳转后,把view下的导航条隐藏
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark - 夜间模式
-(void)moonClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected == 1) {
        self.dk_manager.themeVersion = DKThemeVersionNight;
    }else if (btn.selected == 0){
        self.dk_manager.themeVersion = DKThemeVersionNormal;
    }
}

#pragma mark - 退出编辑

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 添加中间的登录注册视图
-(void)setUpMiddleView
{
//    创建登录View
    ZJHLoginRegister *login = [ZJHLoginRegister liginView];
     self.login = login;
    [self.middleView addSubview:login];
//  创建注册View
    ZJHLoginRegister *regiter = [ZJHLoginRegister registerView];
    self.regiter = regiter;
    [self.middleView addSubview:regiter];
    
}

#pragma mark - 添加底部的View
-(void)setUpBottomView{
    ZJHFastLoginView *fastLogin = [ZJHFastLoginView fastLogin];
    self.fastLogin = fastLogin;
    [self.bottomView addSubview:fastLogin];
    
}

-(void)viewDidLayoutSubviews
{
    self.login.frame = CGRectMake(0, 0, self.middleView.zjh_width * 0.5, self.middleView.zjh_height);
    
    self.regiter.frame = CGRectMake(self.middleView.zjh_width * 0.5, 0, self.middleView.zjh_width * 0.5, self.middleView.zjh_height);
    
    self.fastLogin.frame = self.bottomView.bounds;
    
    
}



@end
