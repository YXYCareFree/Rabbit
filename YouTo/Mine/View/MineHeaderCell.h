//
//  MineHeaderCell.h
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelView.h"
#import "AccountManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnIconTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnEditTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imgVBg;

@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgVSex;
@property (weak, nonatomic) IBOutlet UILabel *lblSign;
@property (weak, nonatomic) IBOutlet UIImageView *imgVRank;

@property (nonatomic, strong) YXYLabel *levelName;
@property (nonatomic, strong) YXYLabel *levelRank;
@property (nonatomic, strong) YXYLabel *levelNum;
@property (nonatomic, strong) LevelView *vlevel;

@property (nonatomic, copy) void(^EditBlock)(void);
@property (nonatomic, copy) void(^IconBlock)(void);

@property (nonatomic, strong) UserModel *model;

@end

NS_ASSUME_NONNULL_END
