//
//  AttentionListCell.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AttentionListCell.h"

@implementation AttentionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btnAttention setCornerRadius:16];
    [self.imgV setCornerRadius:27];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconClicked)];
    [self.imgV addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)attentionClicked:(id)sender {
    if (self.AttentionClickedBlock) {
        self.AttentionClickedBlock();
    }
}

- (void)userIconClicked{
    if (self.UserIconClickedBlock) {
        self.UserIconClickedBlock();
    }
}

@end
