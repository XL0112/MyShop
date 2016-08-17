//
//  AdvertisementViewController.h
//  Entertainer
//
//  Created by funeral on 15/10/6.
//  Copyright © 2015年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisementViewController : UICollectionViewController

/**< 需要展示的广告模型 */
@property (weak, nonatomic) NSArray *advertisementItems;
/**< 需要展示的View的尺寸 */
@property (assign, nonatomic) CGSize viewSize;

@end
