//
//  ZJHShopCategoryItem.h
//  myShop
//
//  Created by zjh on 16/6/16.
//  Copyright © 2016年 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHShopCategoryItem : NSObject

/**< 展示的图片名字 */
@property (copy, nonatomic) NSString *imageName;
/**< 展示的文字 */
@property (copy, nonatomic) NSString *labelText;

+ (instancetype)shopCategoryItemWithDict:(NSDictionary *)dict;
@end
