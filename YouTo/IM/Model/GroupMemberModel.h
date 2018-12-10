//
//  GroupMemberModel.h
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupMemberModel : NSObject

@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *futureGoCityName;
@property (nonatomic, strong) NSString *faceUrl;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) NSString *groupType;
@property (nonatomic, strong) NSString *birthAddress;
@property (nonatomic, strong) NSString *currentLiveAddress;
@property (nonatomic, strong) NSString *agoGoCityName;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *personalizedSignature;
@property (nonatomic, assign) BOOL isMaster;//是否是群主

@end

NS_ASSUME_NONNULL_END
