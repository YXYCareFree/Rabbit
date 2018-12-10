//
//  UserInfoController.h
//  YouTo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "UserDynamicCell.h"
#import "UserInfoCell.h"
#import "MatchUserModel.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoController : YouToViewController

- (instancetype)initWithMemberId:(NSString *)memberId;

@property (nonatomic, strong) UIImageView *imgVUserIcon;
@property (nonatomic, strong) UIImageView *imgVUserSex;
@property (nonatomic, strong) UIImageView *imgVAttention;
@property (nonatomic, strong) YXYLabel *lblAttention;

@property (nonatomic, strong) YXYLabel *lblMatchDegree;
@property (nonatomic, strong) YXYLabel *lblUserName;
@property (nonatomic, strong) YXYLabel *lblUserSign;
@property (nonatomic, strong) YXYLabel *lblCurrAddress;
@property (nonatomic, strong) YXYLabel *lblBirthAddress;

@property (nonatomic, strong) YXYButton *btnFutureCity;
@property (nonatomic, strong) YXYButton *btnAgoCity;

@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) MatchUserModel *userInfoModel;
//@property (nonatomic, strong) UserModel *userInfoModel;

@property (nonatomic, assign) BOOL isSelf;

@end

NS_ASSUME_NONNULL_END
