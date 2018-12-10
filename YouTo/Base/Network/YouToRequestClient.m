//
//  YouToRequestClient.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToRequestClient.h"
#import "NSObject+YYModel.h"
#import "RSA.h"
#import "MatchUserModel.h"

static NSString *const publicKey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArJ0hSbrR5dFKbSk9shGbcmEaoo5hnv1+wgRb76NBfhIdIDj+SKAxjc4/O9l3+9VWBLOKdwEsMavY2sGcQaQLScmZ8jG1hHehN4wFWOMZU/pKMzYUVwscw1c0rwufJ+kTrAWC9d/nGJm8usOBbGTNb3GOHDjq2pXIQTMLnTzsJ3KR67OL3CSFN3aJcdhLUF9UNFXTdB6pAwp31g+JczEo2udnUw+WBqFphVVHRsyg3QaiUFT+9VfySV0nh3NEtRnIuc/6VJ4oYbCYzLRZjDQM+9B0ZdisoeFaqTTHiv7kVd7f2iSkih4apJftNiNBpKQfJGvW9/gV1wKcPbyBH6Rl6QIDAQAB";

@interface YouToRequestClient ()

@property (nonatomic, strong) YXYHTTPRequestClient *manager;

@end

@implementation YouToRequestClient

+ (instancetype)shareClient{
    static YouToRequestClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [YouToRequestClient new];
        client.manager = [YXYHTTPRequestClient shareManagerWithBaseUrl:BASE_URL cerPath:nil AFSSLPinningMode:0];
    });
    return client;
}

- (void)startRequest:(YXYRequest *)request{
    request.params = [self addCommonParams:request.params];
    if ([request.apiName hasPrefix:@"/app/member"]) {
        request.apiName = [NSString stringWithFormat:@"/app/member/%@/%@", API_VERSION, [request.apiName substringFromIndex:12]];
    }
    [self.manager startRequest:request success:^(id responseObj, id cacheObj) {
        int code = [[responseObj valueForKey:@"code"] intValue];
        if (code == 200) {
            NSLog(@"请求成功url==%@,params==%@", request.apiName, request.params);
            id data = [responseObj valueForKey:@"data"];
            if (request.modelClass) {
                if (data) {
                    if (request.success) {
                        if ([data isKindOfClass:[NSArray class]]) {
                           request.success([NSArray yy_modelArrayWithClass:request.modelClass json:data]);
                        }else if ([data isKindOfClass:[NSDictionary class]]) {
                            request.success([request.modelClass yy_modelWithJSON:data]);
                        }else{
                            request.success(data);
                        }
                    }
                }else{
                    NSLog(@"url==%@,params==%@\n%@", request.apiName, request.params, responseObj);
                    if (request.showErrMsg) {
                        [MBProgressHUD showText:@"服务器异常，请稍后再试"];
                    }
                    if (request.failure) {
                        request.failure(@"服务器异常，请稍后再试", nil);
                    }
                }
            }else{
                if (request.success) {
                    request.success(data);
                }
            }
        }else{
            if (code == 401) {
                if ([CurrentVC isKindOfClass:NSClassFromString(@"LoginController")]) {
                    return ;
                }
                if (!CurrentVC.navigationController) {
                    [CurrentVC presentViewController:[NSClassFromString(@"LoginController") new] animated:YES completion:nil];
                }else{
                    PushVCWithClassName(@"LoginController");
                }
            }
            NSLog(@"请求异常url==%@,params==%@\n%@, msg=%@", request.apiName, request.params, responseObj, [responseObj valueForKey:@"msg"]);

            if (request.showErrMsg) {
                [MBProgressHUD showText:[responseObj valueForKey:@"msg"]];
            }
            if (request.failure) {
                request.failure([responseObj valueForKey:@"msg"], nil);
            }

            if (code == 406){
//                NSLog(@"参数异常 url==%@\nparams==%@", request.apiName, request.params);
            }
        }

    } failure:^(NSError *error) {
        NSLog(@"url==%@,params==%@\n%@", request.apiName, request.params, error);

        if (request.failure) {
            request.failure(nil, error);
        }
        if (request.showErrMsg) {
            [MBProgressHUD showText:@"服务器异常，请稍后再试"];
        }
    }];
}

- (NSMutableDictionary *)addCommonParams:(NSDictionary *)params{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:params];
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *version = [infoDic objectForKey:@"CFBundleShortVersionString"];
    [mDict setObject:version forKey:@"version"];
    [mDict setObject:@"ios" forKey:@"deviceType"];
    NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *time = [NSString stringWithFormat:@"%.0f", NSDate.new.timeIntervalSince1970 * 1000];
    [mDict setObject:uuid forKey:@"nonceStr"];
    [mDict setObject:time forKey:@"timestamp"];
    NSDictionary *dict = @{@"nonceStr": uuid, @"timestamp": time};
    NSString *sign = [RSA encryptString:[dict yy_modelToJSONString] publicKey:publicKey];
    [mDict setObject:sign forKey:@"sign"];
    [mDict setObject:[UserDefaults objectForKey:AccessToken]?:@"" forKey:@"token"];
    [mDict setObject:GetAdcode forKey:@"adcode"];
    if (![mDict objectForKey:@"isPosition"]) {
        BOOL isPosition = YES;
        if ([UserDefaults objectForKey:IsPosition] && ![[UserDefaults objectForKey:IsPosition] boolValue]) {
            isPosition = NO;
        }
        [mDict setObject:@(isPosition) forKey:@"isPosition"];
    }

    return mDict;
}
@end
