//
//  loadImage.h
//  BaiSi
//
//  Created by zjh on 16/5/3.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>


typedef void(^SDWebImageCompletionBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);
@interface loadImage : NSObject


/**
 *  给ImnageView添加图片,并且做缓存处理
 *
 *  @param urlStr 图片的url
 *  @param placeholder 占位图片
 *  @param completedBlock 加载完成,回调
 *  @param pictureView 图片的imageView

 */

+ (void)ZJH_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock WithPictureView:(UIImageView *)pictureView;

@end
