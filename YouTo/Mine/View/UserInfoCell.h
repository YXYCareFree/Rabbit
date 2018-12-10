//
//  UserInfoCell.h
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchUserModel.h"
#import "UserModel.h"

typedef NS_ENUM(NSUInteger, UserInfoCellType) {
    UserInfoCellTypeMine,
    UserInfoCellTypeDynamic,
};
NS_ASSUME_NONNULL_BEGIN

@interface UserInfoCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgVUserIcon;
@property (nonatomic, strong) UIImageView *imgVUserSex;

@property (nonatomic, strong) YXYLabel *lblMatch;
@property (nonatomic, strong) YXYLabel *lblMatchDegree;
@property (nonatomic, strong) YXYLabel *lblUserName;
@property (nonatomic, strong) YXYLabel *lblUserSign;
@property (nonatomic, strong) YXYLabel *lblCurrAddress;
@property (nonatomic, strong) YXYLabel *lblBirthAddress;

@property (nonatomic, strong) YXYButton *btnFutureCity;
@property (nonatomic, strong) YXYButton *btnAgoCity;

@property (nonatomic, strong) MatchUserModel *matchModel;
@property (nonatomic, strong) UserModel *model;
@property (nonatomic, assign) UserInfoCellType type;

@property (nonatomic, strong) YXYButton *btnEdit;
@property (nonatomic, copy) void(^EditBlock)(void);

@property (nonatomic, assign) BOOL isSelf;

@end

NS_ASSUME_NONNULL_END
