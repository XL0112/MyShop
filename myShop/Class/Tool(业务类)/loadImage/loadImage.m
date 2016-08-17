//
//  loadImage.m
//  BaiSi
//
//  Created by zjh on 16/5/3.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "loadImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation loadImage


+ (void)ZJH_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock WithPictureView:(UIImageView *)pictureView{
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    
    if (cacheImage) {
        
//        pictureView.image = cacheImage;
        [pictureView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    }else
    {
//        加载图片
        
        [pictureView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil completed:completedBlock];
        
        [pictureView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
    }
    
}
@end
