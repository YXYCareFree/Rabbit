//
//  CountryListView.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryListView : UIView

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) void(^ListSelectedBlock)(NSInteger idx);
@end

NS_ASSUME_NONNULL_END
