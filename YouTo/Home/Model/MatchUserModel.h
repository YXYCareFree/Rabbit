//
//  MatchUserModel.h
//  YouTo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MatchUserModel : NSObject

@property (nonatomic, strong) NSString *matchValue;
@property (nonatomic, strong) NSString *futureGoCityName;
@property (nonatomic, strong) NSString *personalizedSignature;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *birthAddress;
@property (nonatomic, strong) NSString *currentLiveAddress;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *agoGoCityName;

@end

NS_ASSUME_NONNULL_END
