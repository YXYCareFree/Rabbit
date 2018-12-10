//
//  PublishAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PublishAdapter.h"

@implementation PublishAdapter

+(void)publishMood:(NSString *)info infoImg:(NSString *)infoImg visitType:(NSString *)visitType atCityAdcode:(NSString *)cityAdcode currentAddressAdcode:(NSString *)currentAddressAdcode completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/mood/addMood";
    request.params = @{@"info": info,
                       @"infoImg": infoImg,
                       @"visitType": visitType,
                       @"cityAdcode": cityAdcode,
                       @"currentAddressAdcode": currentAddressAdcode
                       };
    request.modelClass = NSClassFromString(@"MoodDetailModel");
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

+ (void)publishHelp:(NSString *)info infoImg:(NSString *)infoImg title:(NSString *)title atCityAdcode:(NSString *)cityAdcode currentAddressAdcode:(NSString *)currentAddressAdcode completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/seekHelp/addSeekHelp";
    request.params = @{@"info": info,
                       @"infoImg": infoImg,
                       @"title": title,
                       @"cityAdcode": cityAdcode,
                       @"currentAddressAdcode": currentAddressAdcode
                       };
    request.modelClass = NSClassFromString(@"MoodDetailModel");
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
