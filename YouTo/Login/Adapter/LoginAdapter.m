//
//  LoginAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LoginAdapter.h"

@implementation LoginAdapter

+ (void)loginWithPhone:(NSString *)phone authCode:(NSString *)code completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/login";
    request.params = @{@"messageCode": code,
                       @"mobile": phone
                       };
    request.success = ^(id obj) {
        if (completion) {
            [UserDefaults setObject:[obj valueForKey:@"token"] forKey:AccessToken];
            [UserDefaults synchronize];
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

+ (void)loginByWXOpenid:(NSString *)openid phone:(NSString *)phone authCode:(NSString *)code completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/wxLogin";
    request.params = @{@"messageCode": code,
                       @"phone": phone,
                       @"openid": openid
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

+ (void)autoLoginByToken:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/tokenLogin";
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

+ (void)getAuthCode:(NSString *)phone completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/sendMsgCode";
    request.params = @{@"mobile": phone};
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

+ (void)sendDeviceToken:(NSString *)deviceToken completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/deviceToken";
    request.params = @{@"deviceToken": deviceToken};
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

+ (void)WXJudgeBindPhoneByOpenid:(NSString *)openid completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/findOpenidIsExist";
    request.params = @{@"openid": openid};
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

+ (void)getUserInfo:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/findMyHome";
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

+ (void)uploadLocation:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/position";
    request.params = @{@"adcode": @"",
                       @"cityCode": @"",
                       @"lat": @"",
                       @"lng": @""
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

+ (void)updateUserInfo:(NSDictionary *)params completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/update";
    request.params = params;
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

+ (void)getAreaCity:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/area/findTierData";
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

+ (void)getRCToken:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/getRongCloudToken";
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

+ (void)getUserInfoByMemberId:(NSString *)memberId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/getMemberInfoOnlyBaseByMemberId";
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

@end
