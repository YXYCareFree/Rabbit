//
//  ThirdPartServiceManager.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdPartServiceManager : NSObject

+ (void)registerService:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
