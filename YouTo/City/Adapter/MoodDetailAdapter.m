//
//  MoodDetailAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MoodDetailAdapter.h"

@implementation MoodDetailAdapter

- (void)getDetailInfo:(NSString *)ID completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/mood/findMoodById";
    request.params = @{@"moodId": ID};
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

- (void)addReplyInfo:(NSString *)info infoId:(NSString *)infoId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/moodAnswer/addMoodAnswer";
    request.params = @{@"info": info,
                       @"moodId": infoId
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

- (void)addAnswerInfo:(NSString *)info infoId:(NSString *)infoId mentionId:(NSString *)mentionId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/moodAnswer/addMoodAnswerDetail";
    if (mentionId) {
        request.params = @{@"moodAnswerId": infoId,
                           @"info": info,
                           @"mentionId": mentionId
                           };
    }else{
        request.params = @{@"moodAnswerId": infoId,
                           @"info": info
                           };
    }

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

- (void)likeReplyId:(NSString *)replyId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/moodAnswer/addMoodAnswerLikeRecord";
    request.params = @{@"moodAnswerId": replyId};
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

- (void)likeAnswerId:(NSString *)answerId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/moodAnswer/addMoodAnswerDetailLikeRecord";
    request.params = @{@"moodAnswerDetailId": answerId};
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

- (void)unlikeReplyId:(NSString *)replyId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/moodAnswer/deleteMoodAnswerLikeRecord";
    request.params = @{@"moodId": replyId};
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

- (void)unlikeAnswerId:(NSString *)answerId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/moodAnswer/deleteMoodAnswerDetailLikeRecord";
    request.params = @{@"moodAnswerDetailId": answerId};
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

- (void)deleteReplyId:(NSString *)replyId msgId:(NSString *)msgId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/moodAnswer/deleteMoodAnswer";
    request.params = @{@"moodId": msgId,
                       @"moodAnswerId": replyId
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

- (void)findMoreReply:(NSString *)replyId pageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/moodAnswer/findMoodAnswerById";
    request.modelClass = NSClassFromString(@"AnswerListModel");
    request.params = @{@"moodAnswerId": replyId,
                       @"pageNum": pageNum,
                       @"pageSize": @"10"
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

- (void)updateMoodVist:(NSString *)moodId visitType:(NSString *)visitType completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/mood/updateMoodVisit";
    request.params = @{@"moodId": moodId,
                       @"visitType": visitType
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

- (void)deleteMood:(NSString *)moodId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/mood/deleteMoodById";
    request.params = @{@"moodId": moodId
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
@end
