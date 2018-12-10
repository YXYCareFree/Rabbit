//
//  UploadAliManager.h
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadAliManager : NSObject

+ (void)uploadImageWithFileUrl:(NSURL *)url progress:(void(^)(NSString *progress))progress completion:(void(^)(BOOL success, NSString *imageUrl))completion;

+ (void)uploadImageWithData:(NSData *)data progress:(void(^)(NSString *progress))progress completion:(void(^)(BOOL success, NSString *imageUrl))completion;

@end

NS_ASSUME_NONNULL_END
