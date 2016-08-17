//
//  ZJHFileManager.m
//  BaiSi
//
//  Created by zjh on 16/5/1.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHFileManager.h"

@implementation ZJHFileManager
//计算尺寸
+(NSInteger)getSizeOfDirectoryPath:(NSString *)directoryPath
{
    //    1创建文件管理者
    
    NSFileManager *manager = [NSFileManager defaultManager];
    //    1.0看看是否不是文件
    BOOL isDirectory = NO;
    BOOL isExct = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExct || !isDirectory)
    {
        NSException *exception = [NSException exceptionWithName:@"fileerror" reason:@"你传的路径是错误的,请重新传路径" userInfo:nil];
        
        //        抛出异常
        [exception raise];
    }
    //    2取出所有的文件
    
    NSArray *arr = [manager subpathsAtPath:directoryPath];
    //    3遍历所有文件
    NSInteger totalSize = 0;
    for (NSString *subPath in arr) {
        //        3.0获取文件的全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        //    3.1看看是否是隐藏文件
        
        if ([filePath containsString:@".DS"]) continue;
        
        //    3.2看看是否不是文件
        BOOL isDirectory = NO;
        BOOL isExct = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if (!isExct || !isDirectory) continue;
        //        如果是文件 那就计算文件的尺寸
        NSInteger fileSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
        totalSize += fileSize;
    }
    
    return totalSize;
}

//移动沙盒中缓存的文件
+(void)removeDirectoryPath:(NSString *)directoryPath
{
//    创建路径管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    //    3.2看看是否不是文件
    BOOL isDirectory = NO;
    BOOL isExct = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExct || !isDirectory)
    {
        NSException *exception = [NSException exceptionWithName:@"fileerror" reason:@"你传的路径是错误了,请重新传路径" userInfo:nil];
        
//        抛出异常
        [exception raise];
    }
    //            获取沙盒存储的缓存地址的路径
    NSString *DirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //            获得该路径下的子文件
    NSArray *arr = [manager contentsOfDirectoryAtPath: DirectoryPath error:nil];
    //            遍历子文件,根据全路径地址  全部删除
    for (NSString *subPath in arr) {
        NSString *filePath = [DirectoryPath stringByAppendingPathComponent:subPath];
        [manager removeItemAtPath:filePath error:nil];
    }
}























@end
