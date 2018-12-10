//
//  MultiCityView.h
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiCityView : UIView

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) void(^RemoveCity)(NSString *city);

@end


@interface CityView : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) void(^RemoveCityBlock)(NSString *city);


- (instancetype)initWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
