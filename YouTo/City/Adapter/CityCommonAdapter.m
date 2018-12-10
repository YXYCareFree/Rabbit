//
//  CityCommonAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityCommonAdapter.h"

@implementation CityCommonAdapter

+ (void)getCityAbstract:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/area/findAreaByAdcode";
    request.params = @{};
    request.modelClass = NSClassFromString(@"CityAbstractModel");
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

+ (void)getCityHelpDataPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/seekHelp/findListByCity";
    request.modelClass = NSClassFromString(@"MoodDetailModel");
    request.params = @{@"pageNum": pageNum,
                       @"pageSize": @10,
                       @"adcode":GetAdcode
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

+ (void)getCitySquareDataPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/mood/findListByPlaza";
    request.params = @{@"pageNum": pageNum,
                       @"pageSize": @10,
                       @"adcode": GetAdcode
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

+ (void)getCityNewsDataPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/seekHelp/findCounselingListByCity";
    request.params = @{@"pageNum": pageNum,
                       @"pageSize": @10,
                       @"adcode": GetAdcode
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

+ (void)getCityStrategyDataPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/seekHelp/findPlanListByCity";
    request.params = @{@"pageNum": pageNum,
                       @"pageSize": @10,
                       @"adcode": GetAdcode
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

+ (void)getWarmHeartList:(NSString *)pageNum adcode:(NSString *)adcode completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/seekHelp/findAnswerList";
    request.params = @{@"pageNum": pageNum,
                       @"pageSize": @10,
                       @"adcode": adcode
                       };
    request.modelClass = NSClassFromString(@"WarmHeartListModel");
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
+ (void)likeWiehMoodID:(NSString *)moodID completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/mood/addMoodLikeRecord";
    request.params = @{@"moodId": moodID};
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

+ (void)unlikeWiehMoodID:(NSString *)moodID completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/mood/deleteMoodLikeRecord";
    request.params = @{@"moodId": moodID};
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

+ (void)attention:(NSString *)memberID completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/concern/addConcern";
    request.params = @{@"focusedMemberId": memberID};
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

+ (void)unattention:(NSString *)memberID completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/concern/cancelConcern";
    request.params = @{@"focusedMemberId": memberID};
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


+ (void)likeCity:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/area/addLikeCityRecord";
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

+ (void)unlikeCity:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/area/deleteLikeCityRecord";
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
