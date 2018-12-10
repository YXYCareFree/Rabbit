//
//  MineCell.h
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgVGoToDetail;

@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgVLeftConstraint;

@end

NS_ASSUME_NONNULL_END
