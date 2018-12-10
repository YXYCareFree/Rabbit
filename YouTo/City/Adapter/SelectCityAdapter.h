//
//  SelectCityAdapter.h
//  YouTo
//
//  Created by apple on 2018/12/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectCityAdapter : NSObject

+ (void)getCityData:(YXYCompletionBlock)completion;

+ (void)searchKeywords:(NSString *)words completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
