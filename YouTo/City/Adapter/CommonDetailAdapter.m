//
//  DetailAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CommonDetailAdapter.h"

@implementation CommonDetailAdapter

- (void)addAttentionMemberId:(NSString *)focusedMemberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/concern/addConcern";
    request.params = @{@"focusedMemberId": focusedMemberId};
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

- (void)cancelAttentionMemberId:(NSString *)focusedMemberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/concern/cancelConcern";
    request.params = @{@"focusedMemberId": focusedMemberId};
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
