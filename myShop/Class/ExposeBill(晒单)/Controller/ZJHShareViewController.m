//
//  ZJHShareViewController.m
//  myShop
//
//  Created by zjh on 16/7/4.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHShareViewController.h"
#import "UMSocial.h"

@interface ZJHShareViewController ()

@end

@implementation ZJHShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//qq
- (IBAction)qqShareBtnClick:(UIButton *)sender {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"特价商品五折促销,机不可失,失不再来.https://bng-pc.taobao.com/?spm=a217m.8005144.308794.1.MlBvvx" image:[UIImage imageNamed:@"item_pic"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}
//微信
- (IBAction)weChatShareBtnClick:(UIButton *)sender {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"特价商品五折促销,机不可失,失不再来.https://bng-pc.taobao.com/?spm=a217m.8005144.308794.1.MlBvvx" image:[UIImage imageNamed:@"item_pic"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}
//微博
- (IBAction)weiboShareBtnClick:(UIButton *)sender {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"特价商品五折促销,机不可失,失不再来.https://bng-pc.taobao.com/?spm=a217m.8005144.308794.1.MlBvvx" image:[UIImage imageNamed:@"item_pic"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}
//空间
- (IBAction)kongjianShareBtnClick:(UIButton *)sender {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"特价商品五折促销,机不可失,失不再来.https://bng-pc.taobao.com/?spm=a217m.8005144.308794.1.MlBvvx" image:[UIImage imageNamed:@"item_pic"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}
//朋友圈
- (IBAction)pengyouShareBtnClick:(UIButton *)sender {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"特价商品五折促销,机不可失,失不再来.https://bng-pc.taobao.com/?spm=a217m.8005144.308794.1.MlBvvx" image:[UIImage imageNamed:@"item_pic"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
