//
//  ZJHTabBarController.m
//  baisibudejie
//
//  Created by zjh on 16/4/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHTabBarController.h"
#import "ZJHHomeViewController.h"
#import "ZJHShopCarViewController.h"
#import "ZJHNewShopCatogaryController.h"
#import "ZJHTabBar.h"
#import "ZJHNavigationController.h"
#import "ZJHLoginRegisterViewController.h"

@interface ZJHTabBarController ()

@end

@implementation ZJHTabBarController


//appearance一定要在view显示之前  设置
+(void)load
{
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:dict1 forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
//    添加子控制器
    [self setUpChildViewController];
    
//    设置tabar的按钮标题
    [self setUpTabBarBtnTitle];
    
//    设置自定义tabBar
    
    [self setUpTabBar];
    
//    设置夜间模式

    self.tabBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
}

/*****************************自定义TabBar**************************/

-(void)setUpTabBar
{
    ZJHTabBar *tabBar = [[ZJHTabBar alloc] init];
    
    [self setValue:tabBar forKey:@"tabBar"];
}
/*****************************tabBar按钮的标题**************************/
-(void)setUpTabBarBtnTitle
{
//    首页
   
    UIViewController *VC = self.childViewControllers[0];
    VC.tabBarItem.title = @"首页";
    VC.tabBarItem.image = [UIImage imageWithOriginalMode:@"tab_首页"];
    VC.tabBarItem.selectedImage = [UIImage imageWithOriginalMode:@"tab_首页_pressed"];
    
//    新品
    UIViewController *VC1 = self.childViewControllers[1];
    VC1.tabBarItem.title = @"新品";
    VC1.tabBarItem.image = [UIImage imageWithOriginalMode:@"tab_分类"];
    VC1.tabBarItem.selectedImage = [UIImage imageWithOriginalMode:@"tab_分类_pressed"];
    
//    清单
    UIViewController *VC2 = self.childViewControllers[2];
    VC2.tabBarItem.title = @"购物车";
    VC2.tabBarItem.image = [UIImage imageWithOriginalMode:@"tab_好物"];
    VC2.tabBarItem.selectedImage = [UIImage imageWithOriginalMode:@"tab_好物_pressed"];
    
    
//    个人中心
    UIViewController *VC3 = self.childViewControllers[3];
    VC3.tabBarItem.title = @"个人中心";
    VC3.tabBarItem.image = [UIImage imageWithOriginalMode:@"tab_我的"];
    VC3.tabBarItem.selectedImage = [UIImage imageWithOriginalMode:@"tab_我的_pressed"];

}

/*****************************设置子控制器**************************/

-(void)setUpChildViewController
{
//    首页
    ZJHHomeViewController *essenceVC = [[ZJHHomeViewController alloc] init];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:naVC];
    
    
//    新品
    ZJHNewShopCatogaryController *newVC = [[ZJHNewShopCatogaryController alloc] init];
    UINavigationController *naVC1 = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:naVC1];
    
    
    
//    清单
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ZJHShopCarViewController" bundle:nil];
    ZJHShopCarViewController *frendThreadVC = [sb instantiateInitialViewController];
    UINavigationController *naVC2 = [[UINavigationController alloc] initWithRootViewController:frendThreadVC];
    [self addChildViewController:naVC2];
    
//    我
    ZJHLoginRegisterViewController *meVC = [[ZJHLoginRegisterViewController alloc] init];
    
    UINavigationController *naVC3 = [[UINavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:naVC3];
    
}




@end
