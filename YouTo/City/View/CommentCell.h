//
//  CommentCell.h
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodDetailModel.h"

typedef NS_ENUM(NSUInteger, CommentCellType) {
    CommentCellTypeComment,
    CommentCellTypeDetail,
};
NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) YXYButton *btnFavour;
@property (nonatomic, strong) YXYLabel *lblFavour;
@property (nonatomic, strong) YXYLabel *lblDetail;

@property (nonatomic, strong) AnswerListModel *model;
@property (nonatomic, strong) MoodAnswerDetailListModel *answerDetailModel;

/**
 必需先设置type再去设置model
 */
@property (nonatomic, assign) CommentCellType type;

@property (nonatomic, assign) BOOL isSelf;//是否是自己发布的心情的评论

@property (nonatomic, copy) void(^LikeBlcok)(void);
@property (nonatomic, copy) void(^LongPressBlcok)(void);
@property (nonatomic, copy) void(^JumpAnswerDetailBlcok)(void);

@end

NS_ASSUME_NONNULL_END
