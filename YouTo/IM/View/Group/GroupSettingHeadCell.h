//
//  GroupSettingHeadCell.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupSettingHeadCell : YXYBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@end

NS_ASSUME_NONNULL_END
