//
//  MatchGroupCell.m
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MatchGroupCell.h"
#import "GroupInfoModel.h"

@implementation MatchGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgVGroupIcon.layer.borderColor = UIColor.whiteColor.CGColor;
    self.imgVGroupIcon.layer.borderWidth = 2;
    [self.imgVGroupIcon setCornerRadius:30];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setModel:(GroupInfoModel *)model{
    if (!model) return;
    
    _model = model;
    
    [self.imgVGroupIcon sd_setImageWithURL:URLWithStr(model.faceUrl) placeholderImage:PlaceHolderImage];
    self.lblGroupTitle.text = model.name;
    self.lblGroupSum.text = model.info;
}

@end
