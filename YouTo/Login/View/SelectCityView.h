//
//  SelectCityView.h
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectCityView : UIView

@property (nonatomic, copy) void(^SelectCityBlock)(NSString *city, NSString *code);

+ (void)showSelectViewWithDataSource:(NSArray *)dataSource completion:(void(^)(NSString *city, NSString *code))completion;

@end

NS_ASSUME_NONNULL_END
