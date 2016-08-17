//
//  CarouselCell.m
//  Entertainer
//
//  Created by funeral on 15/10/6.
//  Copyright © 2015年 funeral. All rights reserved.
//

#import "CarouselCell.h"

@interface CarouselCell ()

@property (weak, nonatomic) UIImageView *showImageView;

@end

@implementation CarouselCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    UIImageView *tempImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:tempImageView];
    self.showImageView = tempImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.showImageView.frame = self.bounds;
}

- (void)setImageName:(NSString *)imageName {
    self.showImageView.image = [UIImage imageNamed:imageName];
}

@end
