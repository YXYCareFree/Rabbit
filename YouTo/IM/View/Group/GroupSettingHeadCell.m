//
//  GroupSettingHeadCell.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupSettingHeadCell.h"

@implementation GroupSettingHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imgV setCornerRadius:27];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
