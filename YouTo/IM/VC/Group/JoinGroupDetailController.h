//
//  JoinGroupDetailController.h
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JoinGroupDetailController : YouToViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgVSex;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblReason;
@property (weak, nonatomic) IBOutlet UIButton *btnRefuse;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;

@property (nonatomic, strong) NSString *sourceId;

@end

NS_ASSUME_NONNULL_END
