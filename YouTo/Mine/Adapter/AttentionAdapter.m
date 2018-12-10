//
//  AttentionAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AttentionAdapter.h"

@implementation AttentionAdapter

+ (void)getAttentionMePageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.modelClass = NSClassFromString(@"UserModel");
    request.apiName = @"/app/member/concern/findListByConcernMe";
    request.params = @{@"pagerNum": pageNum, @"pageSize": @"20"};
    request.success = ^(id obj) {
        if (completion) {
            completion(YES, obj);
        }
    };
    request.failure = ^(NSString *msg, NSError *error) {
        if (completion) {
            completion(NO, msg);
        }
    };
    [RequestClient startRequest:request];
}

+ (void)getMyAttentionPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.modelClass = NSClassFromString(@"UserModel");
    request.apiName = @"/app/member/concern/findListByMyConcern";
    request.params = @{@"pagerNum": pageNum, @"pageSize": @"20"};
    request.success = ^(id obj) {
        if (completion) {
            completion(YES, obj);
        }
    };
    request.failure = ^(NSString *msg, NSError *error) {
        if (completion) {
            completion(NO, msg);
        }
    };
    [RequestClient startRequest:request];
}

+ (void)getAttentionEachOtherPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.modelClass = NSClassFromString(@"UserModel");
    request.apiName = @"/app/member/concern/findListByConcernTogether";
    request.params = @{@"pagerNum": pageNum, @"pageSize": @"20"};
    request.success = ^(id obj) {
        if (completion) {
            completion(YES, obj);
        }
    };
    request.failure = ^(NSString *msg, NSError *error) {
        if (completion) {
            completion(NO, msg);
        }
    };
    [RequestClient startRequest:request];
}
@end
