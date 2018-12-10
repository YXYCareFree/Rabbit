//
//  GroupAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupAdapter.h"

@implementation GroupAdapter

+ (void)getGroupInfo:(NSString *)groupId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.modelClass = NSClassFromString(@"GroupInfoModel");
    request.apiName = @"/app/member/memberGroup/findGroupByGroupId";
    request.params = @{@"groupId": groupId};
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

+ (void)getMemberInfo:(NSString *)memberId inGroupId:(NSString *)groupId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
//    request.modelClass = NSClassFromString(@"GroupInfoModel");
    request.apiName = @"/app/member/memberGroup/findMemberGroupNameRemarkByGroupIdAndMemberId";
    request.params = @{@"groupId": groupId, @"memberId": memberId};
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

+ (void)deleteGroup:(NSString *)groupId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/memberGroup/deleteGroup";
    request.params = @{@"groupId": groupId};
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

+ (void)exitGroup:(NSString *)groupId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/memberGroup/outGroup";
    request.params = @{@"groupId": groupId};
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

+ (void)getGroupMemberList:(NSString *)groupId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.modelClass = NSClassFromString(@"GroupMemberModel");
    request.apiName = @"/app/member/memberGroup/findGroupMemberList";
    request.params = @{@"groupId": groupId};
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

+ (void)applyJoinGroup:(NSString *)groupId applyReason:(NSString *)reason completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.modelClass = NSClassFromString(@"GroupMemberModel");
    request.apiName = @"/app/member/memberGroup/joinGroup";
    request.params = @{@"groupId": groupId, @"info": reason};
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

+ (void)deleteMember:(NSString *)memberId inGroup:(NSString *)groupId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/memberGroup/deleteGroupMember";
    request.params = @{@"groupId": groupId, @"memberId": memberId};
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

+ (void)setGroupRemarkName:(NSString *)name groupId:(NSString *)groupId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/memberGroup/addMemberGroupNameRemark";
    request.params = @{@"memberGroupId": groupId, @"remark": name};
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

+ (void)getRemarkNameInGroup:(NSString *)groupId memberId:(NSString *)memberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/memberGroup/findMemberGroupNameRemarkByGroupIdAndMemberId";
    request.params = @{@"groupId": groupId, @"memberId": memberId};
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
