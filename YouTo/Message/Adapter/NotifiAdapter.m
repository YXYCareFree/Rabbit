//
//  NotifiAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NotifiAdapter.h"

@implementation NotifiAdapter

+ (void)getAllNotifi:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.modelClass = NSClassFromString(@"NotifiModel");
    request.apiName = @"/app/member/message/findInfoAll";
    request.params = @{};
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

+ (void)getAllNotifiByType:(NSString *)type completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/message/findListByAcceptIdAndSourceType";
//    request.modelClass = NSClassFromString(@"")
    request.params = @{@"sourceType": type};
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

+ (void)getJoinGroupDetail:(NSString *)sourceId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/message/findJoinGroupMessageBySourceId";
    request.modelClass = NSClassFromString(@"NotifiJoinGroupModel");
    request.params = @{@"sourceId": sourceId};
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

+ (void)checkJoinGroup:(NSString *)joinGroupInfoId status:(BOOL)status refuse:(NSString *)reason completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/memberGroup/checkJoinGroupInfo";
    NSString *str = status?@"checkSuccess":@"checkFail";
    if (reason) {
        request.params = @{@"sourceId": joinGroupInfoId, @"status": str, @"failInfo": reason};
    }else{
        request.params = @{@"sourceId": joinGroupInfoId, @"status": str};
    }
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
