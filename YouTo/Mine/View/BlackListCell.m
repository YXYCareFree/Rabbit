//
//  BlackListCell.m
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BlackListCell.h"

@implementation BlackListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btnCancelBlack setCornerRadius:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (IBAction)btnCancelBlackClicked:(id)sender {
    if (self.CancelBlackListBlock) {
        self.CancelBlackListBlock();
    }
}
@end
