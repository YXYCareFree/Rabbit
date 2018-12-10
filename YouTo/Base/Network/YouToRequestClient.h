//
//  YouToRequestClient.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXYHTTPRequestClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface YouToRequestClient : NSObject

+ (instancetype)shareClient;

- (void)startRequest:(YXYRequest *)request;

@end

NS_ASSUME_NONNULL_END
