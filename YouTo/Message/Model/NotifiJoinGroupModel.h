//
//  NotifiJoinGroupModel.h
//  YouTo
//
//  Created by apple on 2018/11/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotifiJoinGroupModel : NSObject

@property (nonatomic, assign) BOOL isSkip;//是否跳转

@property (nonatomic, strong) NSString *faceUrl;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *checkInfo;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *currentLiveAddress;
@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *memberId;

@property (nonatomic, strong) NSString *sex;

@end

NS_ASSUME_NONNULL_END
