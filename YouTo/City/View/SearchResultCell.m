//
//  SearchResultCell.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
