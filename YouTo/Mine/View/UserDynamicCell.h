//
//  UserDynamicCell.h
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDynamicModel.h"
#import "MoodDetailModel.h"
#import "YXYImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserDynamicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;

@property (weak, nonatomic) IBOutlet UILabel *lblFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblAtLocation;

@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UILabel *lblLike;

@property (weak, nonatomic) IBOutlet UIView *vBg;

@property (weak, nonatomic) IBOutlet UIView *vImgVBg;
@property (strong, nonatomic) UIImageView *imgV1;
//@property (strong, nonatomic) YXYImageView *imgV1;

@property (strong, nonatomic) UIImageView *imgV2;
@property (strong, nonatomic) UIImageView *imgV3;
@property (strong, nonatomic) UIImageView *imgV4;
@property (strong, nonatomic) UIImageView *imgV5;
@property (strong, nonatomic) UIImageView *imgV6;

@property (nonatomic, copy) void(^LikeBlock)(void);

@property (nonatomic, strong) MoodDetailModel *model;

@end

NS_ASSUME_NONNULL_END
