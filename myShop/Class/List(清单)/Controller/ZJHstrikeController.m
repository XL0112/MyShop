//
//  ZJHstrikeController.m
//  myShop
//
//  Created by zjh on 16/6/18.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHstrikeController.h"
#import "DCPaymentView.h"

@interface ZJHstrikeController ()
@property(nonatomic,strong)  UIAlertController *alet;
@end

@implementation ZJHstrikeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//  弹窗
    [self jumpWind];
    
    //    夜间模式
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//        由于点击样式是这cell创建出来之前设置,所以不能再外面设置cell点击样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"支付方式";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = @"余额支付";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(bg);
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self presentViewController:self.alet animated:YES completion:nil];

    }
}

//弹窗
-(void)jumpWind{
//    self.alet = [UIAlertController alertControllerWithTitle:@"支付" message:nil preferredStyle:UIAlertControllerStyleAlert];
      self.alet = [[UIAlertController alloc]init];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"余额支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        DCPaymentView *payAlert = [[DCPaymentView alloc]init];
        payAlert.title = @"请输入支付密码";
        payAlert.detail = @"付款";
        payAlert.amount= _money;
        [payAlert show];
        payAlert.completeHandle = ^(NSString *inputPwd) {
            NSLog(@"密码是%@",inputPwd);
        };
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"支付宝支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
            [self.alet addAction:action];
            [self.alet addAction:action1];
            [self.alet addAction:action2];

}

@end
