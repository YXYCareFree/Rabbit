//
//  GroupTypeCell.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupTypeCell.h"

@implementation GroupTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.vTip setCornerRadius:5];
    self.vTip.backgroundColor = Color_Main;
    self.vTip.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
