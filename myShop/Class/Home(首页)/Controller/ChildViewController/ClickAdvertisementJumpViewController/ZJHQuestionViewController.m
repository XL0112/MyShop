//
//  ZJHQuestionViewController.m
//  myShop
//
//  Created by zjh on 16/6/16.
//  Copyright © 2016年 home. All rights reserved.
//

#import "ZJHQuestionViewController.h"

@interface ZJHQuestionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textV;

@end

@implementation ZJHQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
#pragma mark - 夜间模式
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.textV.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
//    cell.dk_backgroundColorPicker = DKColorPickerWithKey(bg);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
