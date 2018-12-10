//
//  MoodDetailController.h
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "CommentCell.h"
#import "InputField.h"


NS_ASSUME_NONNULL_BEGIN

@interface MoodDetailController : YouToViewController

- (instancetype)initWithType:(CityContentType)type moodId:(NSString *)moodId isSelf:(BOOL)isSelf;

@property (nonatomic, copy) void(^DeleteBlock)(void);

@property (nonatomic, assign) CityContentType type;

@property (nonatomic, strong) NSString *moodId;

@property (nonatomic, assign) BOOL isSelf;

@property (nonatomic, strong) InputField *inputField;

@property (nonatomic, strong) UIImageView *imgVAttention;
@property (nonatomic, strong) YXYLabel *lblAttention;

@end

NS_ASSUME_NONNULL_END
