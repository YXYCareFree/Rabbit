//
//  SelectCityAdapter.m
//  YouTo
//
//  Created by apple on 2018/12/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SelectCityAdapter.h"

@implementation SelectCityAdapter

+ (void)getCityData:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/area/findSelectData";
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

+ (void)searchKeywords:(NSString *)words completion:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/area/findCityByName";
    request.params = @{@"searchWord": words};
    request.modelClass = NSClassFromString(@"SearchCityModel");
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
