//
//  WarmHeartListCell.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WarmHeartListCell.h"
#import "WarmHeartListModel.h"
#import "UserInfoController.h"

@implementation WarmHeartListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btnAttention setCornerRadius:16];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClicked)];
    [self.imgVUserIcon addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(WarmHeartListModel *)model{
    if (!model) return;
    
    _model = model;
    [self.imgVUserIcon sd_setImageWithURL:URLWithStr(model.headImg) placeholderImage:PlaceHolderImage];
    self.lblDetail.text = [NSString stringWithFormat:@"回答被%@次选为精选答案", model.isGoodNum];
    self.lblName.text = model.nickName;
    if (model.isConcern) {
        [self.btnAttention setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
        [self.btnAttention setTitle:@"关注" forState:UIControlStateNormal];
    }
}
- (IBAction)btnAttentionClicked:(id)sender {
    if (self.WarmHeartListCellBlock) {
        self.WarmHeartListCellBlock();
    }
}

- (void)iconClicked{
    UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:self.model.memberId];
    PushVC(vc);
}

@end
