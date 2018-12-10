//
//  MessageCell.m
//  YouTo
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconClicked)];
    [self.imgVIcon addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)userIconClicked{
    if (self.UserIconClickedBlock) {
        self.UserIconClickedBlock();
    }
}
@end
