//
//  MoodDetailHeaderCell.h
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleImageView.h"
#import "MoodDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoodDetailHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CircleImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UIView *imgvBg;
@property (weak, nonatomic) IBOutlet UIButton *btnAttention;

@property (weak, nonatomic) IBOutlet UIButton *btnDelete;//自己发布的可以删除

@property (weak, nonatomic) IBOutlet UIImageView *imgVLocation;
@property (weak, nonatomic) IBOutlet UIImageView *imgVAt;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblAtLocation;


@property (weak, nonatomic) IBOutlet UILabel *lblLike;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;

@property (strong, nonatomic) UIImageView *imgV1;
@property (strong, nonatomic) UIImageView *imgV2;
@property (strong, nonatomic) UIImageView *imgV3;
@property (strong, nonatomic) UIImageView *imgV4;
@property (strong, nonatomic) UIImageView *imgV5;
@property (strong, nonatomic) UIImageView *imgV6;

@property (nonatomic, strong) MoodDetailModel *model;
@property (nonatomic, assign) CityContentType type;

@property (nonatomic, copy) void(^LikeClickedBlock)(void);
@property (nonatomic, copy) void(^CommentClickedBlock)(void);
@property (nonatomic, copy) void(^DeleteClickedBlock)(void);

@end

NS_ASSUME_NONNULL_END
