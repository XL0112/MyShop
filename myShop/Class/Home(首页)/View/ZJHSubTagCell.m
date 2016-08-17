//
//  ZJHSubTagCell.m
//  baisibudejie
//
//  Created by zjh on 16/5/13.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHSubTagCell.h"
#import "ZJHSubUserItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ZJHSubTagCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *dingyueLB;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;

@end

@implementation ZJHSubTagCell

- (void)awakeFromNib {
    
    self.autoresizingMask = UIViewAutoresizingNone;
}



#pragma mark - 关注界面中左边标题按钮中的推荐专注数据
-(void)setUserItem:(ZJHSubUserItem *)userItem
{
    _userItem = userItem;
//    self.nameLB.text = userItem.screen_name;
//    
//    NSInteger fans = [userItem.fans_count integerValue];
//    NSString *fansStr = [NSString stringWithFormat:@"%zd订阅",fans];
//    if (fans >= 10000) {
//       CGFloat fansF = fans / 10000.0;
//        fansStr = [NSString stringWithFormat:@"%.1lf万订阅",fansF];
//        fansStr = [fansStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
//    }
//   
//    self.dingyueLB.text = fansStr;
//    
//    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:userItem.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image == nil) return ;
//        //        开始一个上下文
//        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
//        
//        //        描绘裁剪区域
//        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//        
//        //        设置裁剪区域
//        [bezierPath addClip];
//        //        画图
//        [image drawAtPoint:CGPointZero];
//        //        获得图片
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        
//        //        关闭上下文
//        UIGraphicsEndImageContext();
//        
//        //        给图片赋值
//        self.iconImageV.image = image;
//        
//    }];
}


@end
