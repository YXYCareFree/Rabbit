//
//  GroupInfoController.h
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "SDCycleScrollView.h"
#import "GroupTextCell.h"
#import "GroupMemberCell.h"
#import "GroupInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, GroupInfoControllerType) {
    GroupInfoControllerTypeShow,
    GroupInfoControllerTypeSearch,
};
@interface GroupInfoController : YouToViewController

- (instancetype)initWithGroupId:(NSString *_Nullable)groupId type:(GroupInfoControllerType)type model:(GroupInfoModel *_Nullable)model;

@property (nonatomic, strong) SDCycleScrollView *sdcView;
@property (nonatomic, strong) YXYLabel *lblGroupTitle;//群名称
@property (nonatomic, strong) YXYLabel *lblGroupNum;//群号

@property (nonatomic, strong) YXYButton *btnJoin;

@property (nonatomic, assign) GroupInfoControllerType type;

@property (nonatomic, strong) GroupInfoModel *model;
@property (nonatomic, strong) NSString *groupId;

@property (nonatomic, assign) BOOL isGroupOwner;//是否是群主

@end

NS_ASSUME_NONNULL_END
