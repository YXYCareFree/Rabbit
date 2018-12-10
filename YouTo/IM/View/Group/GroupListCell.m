//
//  GroupListCell.m
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupListCell.h"

@implementation GroupListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.imgV setCornerRadius:27];
    [self.lblGroupOwner setCornerRadius:5];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconClicked)];
    [self.imgV addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (void)userIconClicked{
    if (self.UserIconClicked) {
        self.UserIconClicked();
    }
}
@end
