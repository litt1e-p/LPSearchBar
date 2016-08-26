//
//  RightImgBtn.h
//  LPSearchBarSample
//
//  Created by litt1e-p on 16/8/26.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RightImgAlignment)
{
    RightImgAlignmentCenter = 1,
    RightImgAlignmentRight,
    RightImgAlignmentLeft,
    RightImgAlignmentFill,
};

@interface RightImgBtn : UIButton

@property (nonatomic, assign) RightImgAlignment rightImgAlignment;

@end
