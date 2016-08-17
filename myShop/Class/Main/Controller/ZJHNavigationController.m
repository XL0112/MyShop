//
//  ZJHNavigationController.m
//  baisibudejie
//
//  Created by zjh on 16/4/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHNavigationController.h"

@interface ZJHNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) id interactive;
@end

@implementation ZJHNavigationController
+(void)load
{
    UINavigationBar *NavigationBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [NavigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

    [NavigationBar setTitleTextAttributes:dict];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    创建全局侧滑手势
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
////    不允许边缘手势的触发
//    self.interactivePopGestureRecognizer.enabled = NO;
//    
//    pan.delegate = self;
    
//    夜间模式

   
    self.navigationBar.backgroundColor = [UIColor clearColor];
     self.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
     
  
    
}

//
////控制手势是否触发
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    return self.childViewControllers.count > 1;
//}
//
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.childViewControllers.count) {
//        
//        
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        
//        [backBtn sizeToFit];
//        
//        [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
////        当控制器push的时候就隐藏
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//    
//}
//
//
//-(void)backBtnClick
//{
//    [self popViewControllerAnimated:YES];
//}



@end
