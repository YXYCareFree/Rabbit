//
//  MatchUserCell.h
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MatchUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface MatchUserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgVUserIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgVSex;

@property (weak, nonatomic) IBOutlet UILabel *lblCurrentAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblFutureCity;
@property (weak, nonatomic) IBOutlet UILabel *lblAgoCity;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchValue;


@property (nonatomic, strong) MatchUserModel *model;

@end

NS_ASSUME_NONNULL_END
