//
//  CityAbstractModel.h
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HotMemberModel;

@interface CityAbstractModel : NSObject

@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, strong) NSString *adcode;
@property (nonatomic, strong) NSString *showImg;
@property (nonatomic, strong) NSArray<HotMemberModel *> *hotMember;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *showHeadImg;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *showInfo;

@end


@interface HotMemberModel : NSObject

@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *nickName;

@end

NS_ASSUME_NONNULL_END
