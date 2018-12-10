//
//  GroupSettingCell.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupSettingCell : YXYBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;

@end

NS_ASSUME_NONNULL_END
