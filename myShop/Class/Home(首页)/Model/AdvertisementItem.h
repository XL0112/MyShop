//
//  AdvertisementItem.h
//  Entertainer
//
//  Created by funeral on 15/10/6.
//  Copyright © 2015年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisementItem : NSObject

/**< 展示的图片名字 */
@property (copy, nonatomic) NSString *imageName;
/**< 展示的文字 */
@property (copy, nonatomic) NSString *labelText;

+ (instancetype)advertisementItemWithDict:(NSDictionary *)dict;

@end
