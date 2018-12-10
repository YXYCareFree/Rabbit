//
//  MessageCell.h
//  YouTo
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseTableViewCell.h"
#import "CircleImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : YXYBaseTableViewCell

@property (weak, nonatomic) IBOutlet CircleImageView *imgVIcon;

@property (weak, nonatomic) IBOutlet UIImageView *imgVNoDisturbing;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgVTip;

@property (nonatomic, copy) void(^UserIconClickedBlock)(void);

@end

NS_ASSUME_NONNULL_END
