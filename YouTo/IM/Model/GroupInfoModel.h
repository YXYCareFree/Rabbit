//
//  GroupInfoModel.h
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupInfoModel : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *faceUrl;
@property (nonatomic, strong) NSString *notification;
@property (nonatomic, strong) NSString *groupType;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *groupMemberId;//群主的memberId
@property (nonatomic, assign) BOOL isAlreadyGroupMember;//是否是群成员

@end

NS_ASSUME_NONNULL_END
