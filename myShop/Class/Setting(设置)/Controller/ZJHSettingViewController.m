//
//  ZJHSettingViewController.m
//  BaiSi
//
//  Created by zjh on 16/4/25.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "ZJHSettingViewController.h"
#import "ZJHFileManager.h"
#import <SDWebImage/SDImageCache.h>

static NSString *const ID = @"cell";
@interface ZJHSettingViewController ()

@end

@implementation ZJHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    去除底部视图
    self.tableView.tableFooterView = [[UIView alloc] init];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"jump" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);

}


-(void)jump:(UIButton *)btn
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:13 weight:10];
    cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(bg);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
//            这个是底层实现的原理调用的方法
            cell.textLabel.text = [self sizeString];
//            NSInteger size = [[SDImageCache sharedImageCache] getSize];
//            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存%ld",size];
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"find match"];
            cell.textLabel.text = @"个人资料";
            
        }else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"find match"];
            cell.textLabel.text = @"消息";
        }else if (indexPath.row == 3){
            cell.imageView.image = [UIImage imageNamed:@"find match"];
            cell.textLabel.text = @"关于myShop";
            
        }else if (indexPath.row == 4){
            cell.imageView.image = [UIImage imageNamed:@"find match"];
            cell.textLabel.text = @"通用";
        }
    }
 
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
            [ZJHFileManager removeDirectoryPath:directoryPath];

        }
    }
    [self.tableView reloadData];
}

#pragma mark - 清除缓存的底层实现
-(NSString *)sizeString
{
    NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    [ZJHFileManager getSizeOfDirectoryPath:@"asdas"];
//    由于额外多的,可能是电脑和模拟机的区别,就在这里减掉了
    NSInteger size = [ZJHFileManager getSizeOfDirectoryPath:directoryPath] - 102;
    
    NSString *sizeString = @"清除缓存";
    if (size > 1000 * 1000) {
        CGFloat sizeMB = size / 1000.0 / 1000.0;
       sizeString = [NSString stringWithFormat:@"%@(%.1fMB)",sizeString,sizeMB];
        
    }else if (size > 1000)
    {
        CGFloat sizeKB = size / 1000.0;
        sizeString = [NSString stringWithFormat:@"%@(%.1fKB)",sizeString,sizeKB];
        
    }else if (size >= 0)
    {
        sizeString = [NSString stringWithFormat:@"%@(%ldB)",sizeString,size];
    }
    
    
    return sizeString;
    
}















@end
