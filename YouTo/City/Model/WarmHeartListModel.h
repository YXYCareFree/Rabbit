//
//  WarmHeartListModel.h
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WarmHeartListModel : NSObject

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *isGoodNum;
@property (nonatomic, assign) BOOL isConcern;//是否关注
@property (nonatomic, strong) NSString *memberId;

@end

NS_ASSUME_NONNULL_END
