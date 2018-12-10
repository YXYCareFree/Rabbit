//
//  GroupListCell.h
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imgVSex;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupOwner;

@property (nonatomic, copy) void(^UserIconClicked)(void);

@end

NS_ASSUME_NONNULL_END
