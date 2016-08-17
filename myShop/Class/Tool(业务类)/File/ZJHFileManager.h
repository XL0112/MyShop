//
//  ZJHFileManager.h
//  BaiSi
//
//  Created by zjh on 16/5/1.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHFileManager : NSObject
/**
 *  //计算尺寸
 *
 *  @param directoryPath 文件的总路径
 */

+(NSInteger)getSizeOfDirectoryPath:(NSString *)directoryPath;

/**
 *  //移动沙盒中缓存的文件
 *
 *  @param directoryPath 文件的总路径
 */

+(void)removeDirectoryPath:(NSString *)directoryPath;
@end
