//
//  AttentionListCell.h
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttentionListCell : YXYBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imgVSex;
@property (weak, nonatomic) IBOutlet YXYButton *btnAttention;

@property (nonatomic, copy) void(^AttentionClickedBlock)(void);
@property (nonatomic, copy) void(^UserIconClickedBlock)(void);

@end

NS_ASSUME_NONNULL_END
