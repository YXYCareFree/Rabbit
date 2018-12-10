//
//  AccountManager.m
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AccountManager.h"
#import "LoginAdapter.h"
#import <RongIMLib/RongIMLib.h>

@implementation AccountManager

+ (NSString *)memberId{
    return [UserModel getUserModel].memberId;
}

+ (UserModel *)getUserInfo{
    return [UserModel getUserModel];
}

+ (void)refreshUserInfoWithParams:(NSDictionary *)params completion:(void (^)(UserModel * _Nonnull))completion{
    if (params) {
        [LoginAdapter updateUserInfo:params completion:^(BOOL success, id response) {
            if (success) {
                [LoginAdapter getUserInfo:^(BOOL success, id response) {
                    if (success) {
                        [UserModel saveUserInfo:response];
                        if (completion) {
                            completion([UserModel getUserModel]);
                        }
                    }
                }];
            }
        }];
    }else{
        [LoginAdapter getUserInfo:^(BOOL success, id response) {
            if (success) {
                [UserModel saveUserInfo:response];
                if (completion) {
                    completion([UserModel getUserModel]);
                }
            }
        }];
    }
}

+ (void)addBlackList:(NSString *)memberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/blacklist/addBlackList";
    request.params = @{@"beMemberId": memberId};
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
    
    [[RCIMClient sharedRCIMClient] addToBlacklist:memberId success:^{
        
    } error:^(RCErrorCode status) {
        NSLog(@"融云加入黑名单错误==%ld", status);
    }];
}

+ (void)removeBlackList:(NSString *)memberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/blacklist/deleteBlackList";
    request.params = @{@"beMemberId": memberId};
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
    
    [[RCIMClient sharedRCIMClient] removeFromBlacklist:memberId success:^{
        
    } error:^(RCErrorCode status) {
        NSLog(@"融云移除黑名单错误==%ld", status);
    }];
}

+ (void)getBlackListPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/blacklist/blackList";
    request.modelClass = NSClassFromString(@"UserModel");
    request.params = @{@"pageNum": pageNum, @"pageSize": @"20"};
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

+ (void)getOtherUserInfoByMemberId:(NSString *)memberId pageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/findMemberById";
    request.params = @{@"pageNum": pageNum, @"pageSize": @"30", @"memberId": memberId};
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

+ (void)checkIsAttentionByMemeberId:(NSString *)memberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/concern/findIsAddConcern";
    request.params = @{@"memberId": memberId};
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

+ (void)getRemarkName:(NSString *)memberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/memberNameRemark/findByMemberIdAndBeMemberId";
    request.params = @{@"beMemberId": memberId};
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

+ (void)checkIsInBlackList:(NSString *)memberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/blacklist/findIsAddBlackList";
    request.params = @{@"beMemberId": memberId};
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
