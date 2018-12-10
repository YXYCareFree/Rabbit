//
//  CommentDetailController.h
//  YouTo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "CommentCell.h"
#import "InputField.h"


NS_ASSUME_NONNULL_BEGIN

@interface CommentDetailController : YouToViewController

- (instancetype)initWithCommentId:(NSString *)commentId type:(CityContentType)type;

@property (nonatomic, strong) NSString *commentId;//评论的ID

@property (nonatomic, strong) InputField *inputField;
@property (nonatomic, assign) CityContentType type;

@end

NS_ASSUME_NONNULL_END
