//
//  FilterView.h
//  YouTo
//
//  Created by 杨肖宇 on 2018/12/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterView : UIView

@property (nonatomic, copy) void(^FilterBlock)(double min, double max, NSString *str);

+ (void)showFilterView:(void(^)(double min, double max, NSString *str))completion;

@end
