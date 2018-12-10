//
//  HelpDetailAdapter.m
//  YouTo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HelpDetailAdapter.h"

@implementation HelpDetailAdapter

- (void)getDetailInfo:(NSString *)ID completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/seekHelp/findById";
    request.params = @{@"id": ID};
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
    request.apiName = @"/app/member/seekHelpAnswer/addSeekHelpAnswer";
    request.params = @{@"info": info,
                       @"seekHelpId": infoId
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
    request.apiName = @"/app/member/seekHelpAnswer/addSeekHelpAnswerDetail";
    if (mentionId) {
        request.params = @{@"seekHelpAnswerId": infoId,
                           @"info": info,
                           @"mentionId": mentionId
                           };
    }else{
        request.params = @{@"seekHelpAnswerId": infoId,
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
    request.apiName = @"/app/member/seekHelpAnswer/addSeekHelpAnswerLikeRecord";
    request.params = @{@"seekHelpAnswerId": replyId};
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
    request.apiName = @"/app/member/seekHelpAnswer/addSeekHelpAnswerDetailLikeRecord";
    request.params = @{@"seekHelpAnswerDetailId": answerId};
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
    request.apiName = @"/app/member/seekHelpAnswer/deleteSeekHelpAnswerLikeRecord";
    request.params = @{@"seekHelpAnswerId": replyId};
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
    request.apiName = @"/app/member/seekHelpAnswer/deleteSeekHelpAnswerDetailLikeRecord";
    request.params = @{@"seekHelpAnswerDetailId": answerId};
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
    request.apiName = @"/app/member/seekHelpAnswer/deleteSeekHelpAnswer";
    request.params = @{@"seekHelpId": msgId,
                       @"seekHelpAnswerId": replyId
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
    request.apiName = @"/app/member/seekHelpAnswer/findSeekHelpAnswerById";
    request.modelClass = NSClassFromString(@"AnswerListModel");
    request.params = @{@"seekHelpAnswerId": replyId,
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

- (void)setGoodChoice:(NSString *)choiceId completion:(YXYCompletionBlock)completion{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/seekHelpAnswer/seekHelpAnswerChooseGood";
    request.params = @{@"seekHelpAnswerId": choiceId};
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
    request.apiName = @"/app/member/seekHelp/deleteSeekHelpById";
    request.params = @{@"id": moodId};
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
