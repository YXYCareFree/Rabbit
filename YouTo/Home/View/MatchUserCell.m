//
//  MatchUserCell.m
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MatchUserCell.h"
#import "MatchUserModel.h"

@implementation MatchUserCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.imgVUserIcon setCornerRadius:42];
    self.imgVUserIcon.layer.borderWidth = 2;
    self.imgVUserIcon.layer.borderColor = UIColor.whiteColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setModel:(MatchUserModel *)model{
    if (!model) return;
    
    _model = model;
    
    [self.imgVUserIcon sd_setImageWithURL:URLWithStr(model.headImg) placeholderImage:nil];
    self.lblName.text = model.nickName;
    NSString *sex;
    if ([model.sex isEqualToString:@"男"]) {
        sex = @"man";
    }else{
        sex = @"woman";
    }
    self.imgVSex.image = LoadImageWithName(sex);
    if (model.currentLiveAddress.length) {
        self.lblCurrentAddress.text = model.currentLiveAddress;
    }else{
        self.lblCurrentAddress.text = @"杭州";
        self.lblCurrentAddress.hidden = YES;
    }
    if (model.birthAddress.length) {
        self.lblBirthAddress.text = model.birthAddress;
    }else{
        self.lblBirthAddress.text = @"杭州";
        self.lblBirthAddress.hidden = YES;
    }

    self.lblFutureCity.text = model.futureGoCityName;
    self.lblAgoCity.text = model.agoGoCityName;
    self.lblMatchValue.text = model.matchValue;
}

@end
