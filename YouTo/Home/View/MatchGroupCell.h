//
//  MatchGroupCell.h
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GroupInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MatchGroupCell : UITableViewCell

@property (nonatomic, strong) GroupInfoModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgVGroupIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupSum;

@end

NS_ASSUME_NONNULL_END
