//
//  RCIMManager.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RCIMManager.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import "LoginAdapter.h"
#import "GroupAdapter.h"
#import "GroupInfoModel.h"

static NSString *appKey = @"0vnjpoad06pyz";
@interface RCIMManager ()<RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMGroupMemberDataSource, RCIMGroupUserInfoDataSource, RCIMReceiveMessageDelegate>


@end

@implementation RCIMManager

+ (instancetype)sharedInstance{
    static RCIMManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RCIMManager alloc] init];
    });
    return manager;
}

+ (void)loginIM{
    [LoginAdapter getRCToken:^(BOOL success, id response) {
        if (success) {
//             && ((NSString *)[response valueForKey:@"rongCloudToken"]).length
            if ([response valueForKey:@"rongCloudToken"]) {
                [[RCIM sharedRCIM] initWithAppKey:appKey];
                [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
                [RCIM sharedRCIM].userInfoDataSource = [RCIMManager sharedInstance];
                [RCIM sharedRCIM].groupInfoDataSource = [RCIMManager sharedInstance];
                [RCIM sharedRCIM].groupMemberDataSource = [RCIMManager sharedInstance];
                [RCIM sharedRCIM].groupUserInfoDataSource = [RCIMManager sharedInstance];
                [RCIM sharedRCIM].receiveMessageDelegate = [RCIMManager sharedInstance];;
//                [[RCIMClient sharedRCIMClient] initWithAppKey:appKey];
//                [[RCIMClient sharedRCIMClient] connectWithToken:[response valueForKey:@"rongCloudToken"]
//                                                        success:^(NSString *userId) {
//                                                            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//                                                        } error:^(RCConnectErrorCode status) {
//                                                            NSLog(@"登陆的错误码为:%ld", status);
//                                                        } tokenIncorrect:^{
//                                                            //token过期或者不正确。
//                                                            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//                                                            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//                                                            NSLog(@"token错误");
//                                                        }];
                [[RCIM sharedRCIM] connectWithToken:[response valueForKey:@"rongCloudToken"] success:^(NSString *userId) {
                    NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"登陆的错误码为:%ld", (long)status);
                    [RCIMManager loginIM];
                } tokenIncorrect:^{
                    NSLog(@"token错误");
                }];
            }
        }
    }];
}
#pragma mark RCIMReceiveMessageDelegate
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    if ([message.objectName isEqualToString:@"My:joinGroupMessage"]) {
     //加群消息
        Notifi(Msg_Tip, nil, nil);
        [UserDefaults setObject:@YES forKey:Msg_Tip];//初始化消息页面时显示小红点
    }
}

#pragma mark RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{
    if ([userId isEqualToString:@"admin"])  return;
    
    [LoginAdapter getUserInfoByMemberId:userId completion:^(BOOL success, id response) {
        if (success) {
            if (completion) {
                RCUserInfo *info = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@", [response valueForKey:@"id"]] name:[response valueForKey:@"nickName"] portrait:[response valueForKey:@"headImg"]];
                completion(info);
            }
        }
    }];
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    [GroupAdapter getGroupInfo:groupId completion:^(BOOL success, id response) {
        if (success) {
            GroupInfoModel *model = response;
            RCGroup *group = [[RCGroup alloc] initWithGroupId:groupId groupName:model.name portraitUri:model.faceUrl];
            completion(group);
        }
    }];
}

- (void)getUserInfoWithUserId:(NSString *)userId inGroup:(NSString *)groupId completion:(void (^)(RCUserInfo *))completion {
    if ([userId isEqualToString:@"admin"])  return;

    [GroupAdapter getRemarkNameInGroup:groupId memberId:userId completion:^(BOOL success, id response) {
        if (success) {
            RCUserInfo *info = [[RCUserInfo alloc] initWithUserId:userId name:[response valueForKey:@"remark"] portrait:nil];
            completion(info);
        }
    }];
}

@end
