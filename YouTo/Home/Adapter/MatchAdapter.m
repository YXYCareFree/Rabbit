//
//  MatchAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MatchAdapter.h"
#import "MatchUserModel.h"

@implementation MatchAdapter

+ (void)matchUserPageNum:(NSString *)pageNum filterProperty:(NSString *)filterProperty orderProperty:(NSString *)orderProperty completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.modelClass = [MatchUserModel class];
    request.apiName = @"/app/member/findMemberAndGroup";
    request.params = @{@"pageNum": pageNum,
                       @"pageSize": @"30",
                       @"filterProperty": filterProperty,
                       @"orderProperty": orderProperty,
                       @"currentAdcode": GetAdcode
                       };
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

+ (void)matchUserWithFilter:(NSString *)filter completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.modelClass = [MatchUserModel class];
    request.apiName = @"/app/member/findMemberAndGroup";
    request.params = @{@"filterProperty": filter,
                       @"currentAdcode": GetAdcode
                       };
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

+ (void)matchGroupPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.modelClass = NSClassFromString(@"GroupInfoModel");
    request.apiName = @"/app/member/findGroupByAdcode";
    request.params = @{@"pageNum": pageNum,
                       @"pageSize": @"30",
                       @"currentAdcode": GetAdcode
                       };
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
