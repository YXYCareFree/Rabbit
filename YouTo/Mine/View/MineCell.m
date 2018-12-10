//
//  MineCell.m
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (IBAction)goToDetailClicked:(id)sender {
    
}

@end
