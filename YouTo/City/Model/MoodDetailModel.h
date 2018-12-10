//
//  MoodDetailModel.h
//  YouTo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AnswerListModel;

@interface MoodDetailModel : NSObject

@property (nonatomic, assign) BOOL isLike;//是否点赞
@property (nonatomic, assign) BOOL isConcern;//是否关注
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *currentAddress;
@property (nonatomic, strong) NSString *lookNum;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *visitAddress;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *commentNum;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSArray *infoImg;
@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSArray<AnswerListModel *> *answerList;

// 0心情  1求助
@property (nonatomic, assign) NSInteger type;

@end


/**
 心情
 */
@class MoodAnswerDetailListModel;
@interface AnswerListModel : NSObject

@property (nonatomic, assign) BOOL isGood;//是否精选回答
@property (nonatomic, assign) BOOL isLike;//是否点赞
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *currentAddress;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSArray<MoodAnswerDetailListModel *> *moodAnswerDetailList;

@end

@interface MoodAnswerDetailListModel : NSObject

@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *mentionName;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *mentionNickName;//@消息
@property (nonatomic, assign) BOOL isLike;


@end
NS_ASSUME_NONNULL_END
