//
//  GroupMemberCell.h
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleImageView.h"
@class GroupMemberModel;

NS_ASSUME_NONNULL_BEGIN

@interface GroupMemberCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblMemberCount;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupOwner;

@property (weak, nonatomic) IBOutlet CircleImageView *imgV0;
@property (weak, nonatomic) IBOutlet CircleImageView *imgV1;
@property (weak, nonatomic) IBOutlet CircleImageView *imgV2;
@property (weak, nonatomic) IBOutlet CircleImageView *imgV3;

@property (weak, nonatomic) IBOutlet UILabel *lblMember0;
@property (weak, nonatomic) IBOutlet UILabel *lblMember1;
@property (weak, nonatomic) IBOutlet UILabel *lblMember2;
@property (weak, nonatomic) IBOutlet UILabel *lblMember3;

@property (nonatomic, strong) NSString *groupId;

@property (nonatomic, strong) NSArray<GroupMemberModel*> *dataSource;

@end

NS_ASSUME_NONNULL_END
