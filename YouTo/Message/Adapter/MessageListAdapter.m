//
//  MessageListAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MessageListAdapter.h"

@implementation MessageListAdapter

+ (void)getGroupList:(YXYCompletionBlock)completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/concern/findListByMyConcern";
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

+ (void)getC2CList:(YXYCompletionBlock)completion{
    
}

@end
