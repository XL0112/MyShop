//
//  CarouselViewController.h
//  Entertainer
//
//  Created by funeral on 15/10/6.
//  Copyright © 2015年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselViewController : UIViewController

/**< 需要展示的图片数组 */
@property (weak, nonatomic) NSArray *images;
/**< 需要展示的View的尺寸 */
@property (assign, nonatomic) CGSize viewSize;

@end
