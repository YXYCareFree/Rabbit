//
//  PopView.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopView : UIView

+ (void)popWithDataSource:(NSArray *)dataSource imageDataSource:(NSArray *)imageDataSource baseView:(UIView *)baseView completion:(void(^)(NSInteger idx))completion;

@end

NS_ASSUME_NONNULL_END
