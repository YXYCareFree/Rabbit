//
//  MyLikeAdapter.m
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyLikeAdapter.h"

@implementation MyLikeAdapter

+ (void)getMyLike:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.modelClass = NSClassFromString(@"MoodDetailModel");
    request.apiName = @"/app/member/mood/findMoodByMoodLike";
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
@end
