//
//  UploadAliManager.m
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UploadAliManager.h"
#import <AliyunOSSiOS/OSSService.h>

@interface UploadAliManager ()

@property (strong, nonatomic) OSSClient *client;

@end

@implementation UploadAliManager

+ (instancetype)shareManager{
    static UploadAliManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = UploadAliManager.new;
    });
    return manager;
}

+ (void)uploadImageWithData:(NSData *)data progress:(void (^)(NSString * _Nonnull))progress completion:(void (^)(BOOL, NSString * _Nonnull))completion{
    OSSPutObjectRequest *put = OSSPutObjectRequest.new;
    put.bucketName = @"moheng-youto";
    NSString *objectKey = [UploadAliManager createKey];
    put.objectKey = objectKey;
    put.uploadingData = data;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        if (progress) {
            progress([NSString stringWithFormat:@"%.4f", (float)totalBytesSent / totalBytesExpectedToSend]);
        }
    };
    [UploadAliManager uploadPut:put completion:completion];
}

+ (void)uploadImageWithFileUrl:(NSURL *)url progress:(void (^)(NSString * _Nonnull))progress completion:(void (^)(BOOL , NSString * _Nonnull))completion{
    
    OSSPutObjectRequest *put = OSSPutObjectRequest.new;
    put.bucketName = @"moheng-youto";
    NSString *objectKey = [UploadAliManager createKey];
    put.objectKey = objectKey;
    put.uploadingFileURL = url;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        if (progress) {
            progress([NSString stringWithFormat:@"%.4f", (float)totalBytesSent / totalBytesExpectedToSend]);
        }
    };
    [UploadAliManager uploadPut:put completion:completion];
}

+ (void)uploadPut:(OSSPutObjectRequest *)put completion:(void (^)(BOOL , NSString * _Nonnull))completion {
    UploadAliManager *manager = [UploadAliManager shareManager];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSTask * task = [manager.client putObject:put];
        [task continueWithBlock:^id(OSSTask *task) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!task.error) {
                    NSLog(@"上传图片成功");
                    if (completion) {
                        completion(YES, [@"https://moheng-youto.oss-cn-beijing.aliyuncs.com/" stringByAppendingString:put.objectKey]);
                    }
                }else{
                    NSLog(@"上传图片出错：%@", task.error);
                    if (completion) {
                        completion(NO, @"");
                    }
                }
            });
            return nil;
        }];
    });
}

+ (NSString *)createKey{
    NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSDate *date = [NSDate new];
    CGFloat f = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"iOS/%@%.0f.JPEG", uuid, f];
}

- (OSSClient *)client{
    if (!_client) {
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:@"LTAI5dWyZ1EYmHUc" secretKey:@"hebhS0PV4AKCJIj0AvP7cRx1KI7mSx"];
        OSSClientConfiguration *conf = OSSClientConfiguration.new;
        conf.maxRetryCount = 2;
        conf.timeoutIntervalForRequest = 30;
        conf.timeoutIntervalForResource = 24 * 60 * 60;
        _client = [[OSSClient alloc] initWithEndpoint:@"oss-cn-beijing.aliyuncs.com" credentialProvider:credential clientConfiguration:conf];
    }
    return _client;
}
@end
