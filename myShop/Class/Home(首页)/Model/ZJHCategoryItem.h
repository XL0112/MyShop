//
//  ZJHCategoryItem.h
//  baisibudejie
//
//  Created by zjh on 16/5/17.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHCategoryItem : NSObject

@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * ID;

@property(nonatomic,strong) NSString * next_page;
@property(nonatomic,strong) NSString * total_page;
@property(nonatomic,strong) NSMutableArray * users;
@end
