//
//  AdvertisementItem.m
//  Entertainer
//
//  Created by funeral on 15/10/6.
//  Copyright © 2015年 funeral. All rights reserved.
//

#import "AdvertisementItem.h"

@implementation AdvertisementItem

+ (instancetype)advertisementItemWithDict:(NSDictionary *)dict {
    AdvertisementItem *adItem = [[self alloc]init];
    adItem.imageName = dict[@"imageName"];
    adItem.labelText = dict[@"text"];
    return adItem;
}

@end
