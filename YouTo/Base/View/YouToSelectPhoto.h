//
//  YouToSelectPhoto.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YouToSelectPhoto : NSObject

+ (void)selectPhoto:(void(^)(NSString *imgUrlStr))completion;

@end

NS_ASSUME_NONNULL_END
