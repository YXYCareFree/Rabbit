//
//  MatchController.h
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "MatchUserCell.h"
#import "MatchGroupCell.h"

typedef NS_ENUM(NSUInteger, MatchControllerType) {
    MatchControllerTypeUser,
    MatchControllerTypeGroup,
};

NS_ASSUME_NONNULL_BEGIN

@interface MatchController : YouToViewController

@property (nonatomic, strong) YXYButton *btnUser;
@property (nonatomic, strong) YXYButton *btnGroup;
@property (nonatomic, strong) YXYButton *btnFilter;

@property (nonatomic, strong) UIView *vIndicate;

@property (nonatomic, assign) MatchControllerType type;

- (void)setMatchedUI;

@end

NS_ASSUME_NONNULL_END
