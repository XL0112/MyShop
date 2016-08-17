//
//  AdvertisementCell.m
//  myShop
//
//  Created by zjh on 16/6/16.
//  Copyright © 2016年 home. All rights reserved.
//

#import "AdvertisementCell.h"
#import "AdvertisementItem.h"

@interface AdvertisementCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *BackView;

@end

@implementation AdvertisementCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - 数据装载
- (void)setAdvertisementItem:(AdvertisementItem *)advertisementItem {
    _advertisementItem = advertisementItem;
    
    self.imageV.image = [UIImage imageNamed:advertisementItem.imageName];
    
    self.titleLb.text = advertisementItem.labelText;
    
#pragma mark - 夜间模式
    self.imageV.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.titleLb.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.BackView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

@end
