//
//  NotifiDynamicModel.h
//  YouTo
//
//  Created by apple on 2018/12/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotifiDynamicModel : NSObject

@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, assign) BOOL isSkip;
@property (nonatomic, strong) NSString *futureGoCityName;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *faceUrl;
@property (nonatomic, strong) NSString *currentLiveAddress;
@property (nonatomic, strong) NSString *agoGoCityName;
@property (nonatomic, strong) NSString *birthAddress;
@property (nonatomic, strong) NSString *personalizedSignature;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *memberId;

@end

NS_ASSUME_NONNULL_END
