//
//  YXYSelectPhoto.h
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXYSelectView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXYSelectPhoto : NSObject

+ (void)initWith:(UIImagePickerControllerSourceType)sourceType fromVC:(UIViewController *)vc completion:(void(^)(NSString *urlStr))completion;

@end

NS_ASSUME_NONNULL_END
