//
//  BlackListCell.h
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlackListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CircleImageView *imgVIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imgVSex;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelBlack;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;


@property (nonatomic, copy) void(^CancelBlackListBlock)(void);

@end

NS_ASSUME_NONNULL_END
