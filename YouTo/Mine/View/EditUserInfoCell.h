//
//  EditUserInfoCell.h
//  YouTo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditUserInfoCell : YXYBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UILabel *lblRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnLeftWidthConstraint;

@end

NS_ASSUME_NONNULL_END
