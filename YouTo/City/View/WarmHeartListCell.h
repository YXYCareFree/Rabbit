//
//  WarmHeartListCell.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleImageView.h"
@class WarmHeartListModel;

NS_ASSUME_NONNULL_BEGIN

@interface WarmHeartListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *imgVRank;

@property (weak, nonatomic) IBOutlet CircleImageView *imgVUserIcon;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnAttention;

@property (nonatomic, copy) void(^WarmHeartListCellBlock)(void);

@property (nonatomic, strong) WarmHeartListModel *model;

@end

NS_ASSUME_NONNULL_END
