//
//  ZJHAdvertisementViewController.m
//  baisibudejie
//
//  Created by zjh on 16/5/17.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHAdvertisementViewController.h"
#import "ZJHTabBarController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "ZJHADItem.h"



#define ZJHCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface ZJHAdvertisementViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageV;
@property (weak, nonatomic) IBOutlet UIImageView *adImageV;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property(nonatomic,strong) ZJHADItem * item;
@property(nonatomic,strong) NSTimer * timer;


@end

@implementation ZJHAdvertisementViewController
#pragma mark - 点击按钮跳转
- (IBAction)jumpBtnClick:(UIButton *)sender {
    ZJHTabBarController *tabBar = [[ZJHTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    
//    销毁定时器
    [self.timer invalidate];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//   添加底部的图片
    [self setUpBottomImanegV];
    
//    添加广告界面
    [self reloadDataSource];
    
//    设置定时器
   self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChage) userInfo:nil repeats:YES];
}
#pragma mark - 定时器
-(void)timeChage{
    static int i = 3;
    
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%zd)",i] forState:UIControlStateNormal];
    i-- ;
    
    if (i < 0) {
        
        [self jumpBtnClick:self.jumpBtn];
    }
}

#pragma mark - 添加广告界面


-(void)reloadDataSource
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = ZJHCode2;
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/zjh/Desktop/ad.plist" atomically:YES];
        NSDictionary *Dict = [responseObject[@"ad"] firstObject];;
        ZJHADItem *item = [ZJHADItem mj_objectWithKeyValues:Dict];
        self.item = item;
        
        UIImageView *adImageV = [[UIImageView alloc] init];
//        设置和用户交互
        adImageV.userInteractionEnabled = YES;
//        如果有值,那么久设置adImageV的尺寸
        if (_item.w) {
            
            CGFloat h = SCREEN_W / item.w * item.h;
            
            adImageV.frame = CGRectMake(0, 0, SCREEN_W, h);
        }
        //        添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [adImageV addGestureRecognizer:tap];
        
//        添加图片
        [self.adImageV addSubview:adImageV];
        
//        设置图片
        [adImageV sd_setImageWithURL:[NSURL URLWithString:item.w_picurl] placeholderImage:nil];
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DLog(@"%@",error);
    }];
  
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    NSURL *url = [NSURL URLWithString:self.item.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}



#pragma mark - 设置底部图片
-(void)setUpBottomImanegV
{
 
    if (iPhone6P) {
        self.bottomImageV.image = [UIImage imageNamed:@"LaunchImage-800-Portrait"];
    }else if (iPhone6)
    {
        self.bottomImageV.image = [UIImage imageNamed:@"LaunchImage-800"];
        
    }else if (iPhone5)
    {
        self.bottomImageV.image = [UIImage imageNamed:@"LaunchImage-700"];
    }else if (iPhone4){
        self.bottomImageV.image = [UIImage imageNamed:@"LaunchImage"];
    }
}


@end
