//
//  MoodDetailHeaderCell.m
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MoodDetailHeaderCell.h"
#import "CityCommonAdapter.h"
#import "UserInfoController.h"
#import "AccountManager.h"
#import "MHPhotoBrowserController.h"
#import "CommonDetailAdapter.h"

@implementation MoodDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btnAttention.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.btnAttention setCornerRadius:15];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconClicked)];
    [self.icon addGestureRecognizer:tap];
    self.icon.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)userIconClicked{
    UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:self.model.memberId];
    PushVC(vc);
}

- (void)setModel:(MoodDetailModel *)model{
    if (!model) return;
    
    _model = model;
    self.btnDelete.hidden = ![[AccountManager memberId] isEqualToString:model.memberId];
    switch (self.type) {
        case CityContentTypeHelp:
        case CityContentTypeMood: break;
        default: self.btnDelete.hidden = YES; break;
    }
    [self.icon sd_setImageWithURL:URLWithStr(model.headImg) placeholderImage:nil];
    self.lblTitle.text = model.title;
    self.titleTopConstraint.constant = model.title.length ? 15 : 0;
    self.lblTime.text = model.showTime;
    self.lblName.text = model.nickName;
    self.lblDetail.text = model.info;
    self.lblComment.text = model.commentNum;
    
    self.imgVAt.image = LoadImageWithName(@"mine_at");
    self.imgVLocation.image = LoadImageWithName(@"mine_location");
    self.imgVAt.hidden = self.imgVLocation.hidden = NO;
    
    self.lblLocation.text = model.currentAddress;
    self.lblAtLocation.text = model.visitAddress;
    //设置关注状态
    [self setAttentionStatus];

    if (self.type == CityContentTypeMood || self.type == CityContentTypeHelp) {
        self.lblLocation.text = model.currentAddress;
        self.lblAtLocation.text = model.visitAddress;
        self.imgVAt.hidden = !model.visitAddress.length;

        if (!model.currentAddress.length && model.visitAddress.length) {
            self.lblLocation.text = model.visitAddress;
            self.imgVLocation.image = LoadImageWithName(@"mine_at");
            self.imgVAt.image = nil;
        }
        
        if (self.type == CityContentTypeMood) {
            self.lblLike.text = model.likeNum;
            if (model.isLike) {
                [self.btnLike setImage:LoadImageWithName(@"mine_zan_sel") forState:UIControlStateNormal];
            }else{
                [self.btnLike setImage:LoadImageWithName(@"mine_zan_nor") forState:UIControlStateNormal];
            }
        }else{
            self.lblLike.text = model.lookNum;
            [self.btnLike setImage:LoadImageWithName(@"look") forState:UIControlStateNormal];
        }
    }
    
    if (self.type == CityContentTypeNews) {
        self.lblLike.text = model.lookNum;
        self.imgVAt.hidden = self.imgVLocation.hidden = YES;
        [self.btnLike setImage:LoadImageWithName(@"look") forState:UIControlStateNormal];
    }

    if (self.type == CityContentTypeMood) {
        self.lblLike.text = model.likeNum;
    }
    
    [self.imgvBg.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    if (!model.infoImg || !model.infoImg.count) {
        return;
    }
    NSInteger count = model.infoImg.count;
    if (count == 1) {
        [self.imgvBg addSubview:self.imgV1];
        [self.imgV1 sd_setImageWithURL:URLWithStr(model.infoImg[0]) placeholderImage:PlaceHolderImage_City];
        [self.imgV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.imgvBg);
            make.height.equalTo(@(self.imgvBg.yxy_w * 0.475));
        }];
        return;
    }
    
    [self.imgvBg addSubview:self.imgV1];
    [self.imgvBg addSubview:self.imgV2];
    [self.imgV1 sd_setImageWithURL:URLWithStr(model.infoImg[0]) placeholderImage:PlaceHolderImage_City];
    [self.imgV2 sd_setImageWithURL:URLWithStr(model.infoImg[1]) placeholderImage:PlaceHolderImage_City];

    CGFloat width = (kScreenWidth - 30 - 20) / 3;
    CGFloat height = width * 3 / 4;
    
    [self.imgV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.imgvBg);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    [self.imgV2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV1.mas_right).offset(10);
        if (count < 4) {
            make.bottom.equalTo(self.imgvBg);
        }
        make.top.equalTo(self.imgvBg);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    if (count == 4) {
        [self.imgvBg addSubview:self.imgV4];
        [self.imgvBg addSubview:self.imgV5];
        [self.imgV4 sd_setImageWithURL:URLWithStr(model.infoImg[2]) placeholderImage:PlaceHolderImage_City];
        [self.imgV5 sd_setImageWithURL:URLWithStr(model.infoImg[3]) placeholderImage:PlaceHolderImage_City];
        
        [self.imgV4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgvBg);
            make.bottom.equalTo(self.imgvBg);
            make.top.equalTo(self.imgV1.mas_bottom).offset(10);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
        [self.imgV5 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imgV4);
            make.left.equalTo(self.imgV4.mas_right).offset(10);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
        return;
    }
    
    if (count < 3) return;
    [self.imgvBg addSubview:self.imgV3];
    [self.imgV3 sd_setImageWithURL:URLWithStr(model.infoImg[2]) placeholderImage:PlaceHolderImage_City];
    [self.imgV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV2);
        make.right.equalTo(@0);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    if (count < 5) return;
    [self.imgvBg addSubview:self.imgV4];
    [self.imgV4 sd_setImageWithURL:URLWithStr(model.infoImg[3]) placeholderImage:PlaceHolderImage_City];
    [self.imgV4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgvBg);
        make.bottom.equalTo(self.imgvBg);
        make.top.equalTo(self.imgV1.mas_bottom).offset(10);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    [self.imgvBg addSubview:self.imgV5];
    [self.imgV5 sd_setImageWithURL:URLWithStr(model.infoImg[4]) placeholderImage:PlaceHolderImage_City];
    [self.imgV5 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV4);
        make.left.equalTo(self.imgV4.mas_right).offset(10);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    if (count < 6) return;
    [self.imgvBg addSubview:self.imgV6];
    [self.imgV6 sd_setImageWithURL:URLWithStr(model.infoImg[5]) placeholderImage:PlaceHolderImage_City];
    [self.imgV6 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV4);
        make.left.equalTo(self.imgV5.mas_right).offset(10);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
}

- (void)setAttentionStatus{
    self.btnAttention.hidden = [self.model.memberId isEqualToString:[AccountManager memberId]];
    if (self.model.isConcern) {
        self.btnAttention.tintColor = Color_Main;
        self.btnAttention.layer.borderColor = Color_Main.CGColor;
        self.btnAttention.layer.borderWidth = 1;
        self.btnAttention.backgroundColor = WhiteColor;
        [self.btnAttention setTitle:@"取关" forState:UIControlStateNormal];
    }else{
        self.btnAttention.tintColor = WhiteColor;
        [self.btnAttention setTitle:@"关注" forState:UIControlStateNormal];
        self.btnAttention.backgroundColor = Color_Main;
    }
}

- (IBAction)btnCommentClicked:(id)sender {
    if (self.CommentClickedBlock) {
        self.CommentClickedBlock();
    }
}

- (IBAction)btnAttentionClicked:(id)sender {
    CommonDetailAdapter *adapter = [[CommonDetailAdapter alloc] init];
    if (self.model.isConcern) {
        [adapter cancelAttentionMemberId:self.model.ID completion:^(BOOL success, id response) {
            if (success) {
                self.model.isConcern = !self.model.isConcern;
                [self setAttentionStatus];
                [MBProgressHUD showText:@"取关成功"];
            }
        }];
    }else{
        [adapter addAttentionMemberId:self.model.ID completion:^(BOOL success, id response) {
            if (success) {
                self.model.isConcern = !self.model.isConcern;
                [self setAttentionStatus];
                [MBProgressHUD showText:@"关注成功"];
            }
        }];
    }
}

- (IBAction)btnLikeClicked:(id)sender {
    if (self.type == CityContentTypeMood) {
        if (self.model.isLike) {
            [CityCommonAdapter unlikeWiehMoodID:self.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    self.model.isLike = NO;
                    [self.btnLike setImage:LoadImageWithName(@"mine_zan_nor") forState:UIControlStateNormal];
                    int num = [self.model.likeNum intValue];
                    self.model.likeNum = [NSString stringWithFormat:@"%d", --num];
                    self.lblLike.text = self.model.likeNum;
                }
            }];
        }else{
            [CityCommonAdapter likeWiehMoodID:self.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    self.model.isLike = YES;
                    [self.btnLike setImage:LoadImageWithName(@"mine_zan_sel") forState:UIControlStateNormal];
                    int num = [self.model.likeNum intValue];
                    self.model.likeNum = [NSString stringWithFormat:@"%d", ++num];
                    self.lblLike.text = self.model.likeNum;
                }
            }];
        }
    }
}

- (IBAction)btnDeleteClicked:(id)sender {
    if (self.DeleteClickedBlock) {
        self.DeleteClickedBlock();
    }
}

- (void)tap:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    NSString *str;
    if (self.model.infoImg.count == 4) {
        if (view.tag - Tag_Photo > 2) {
            str = self.model.infoImg[view.tag - Tag_Photo - 1];
        }else{
            str = self.model.infoImg[view.tag - Tag_Photo];
        }
    }else{
        str = self.model.infoImg[view.tag - Tag_Photo];
    }
    MHPhotoBrowserController *vc = [[MHPhotoBrowserController alloc] init];
    vc.imgArray = [NSMutableArray arrayWithArray:self.model.infoImg];
    vc.currentImgIndex = [self.model.infoImg indexOfObject:str];
    if ([CurrentVC isKindOfClass:[UIViewController class]]) {
        [CurrentVC presentViewController:vc animated:YES completion:nil];
    }
}

- (UIImageView *)imgV1{
    if (!_imgV1) {
        _imgV1 = UIImageView.new;
        _imgV1.contentMode = UIViewContentModeScaleAspectFill;
        [_imgV1 setCornerRadius:5];
        _imgV1.userInteractionEnabled = YES;
        _imgV1.tag = Tag_Photo;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imgV1 addGestureRecognizer:tap];
    }
    return _imgV1;
}

- (UIImageView *)imgV2{
    if (!_imgV2) {
        _imgV2 = UIImageView.new;
        _imgV2.contentMode = UIViewContentModeScaleAspectFill;
        [_imgV2 setCornerRadius:5];
        _imgV2.userInteractionEnabled = YES;
        _imgV2.tag = Tag_Photo + 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imgV2 addGestureRecognizer:tap];
    }
    return _imgV2;
}

- (UIImageView *)imgV3{
    if (!_imgV3) {
        _imgV3 = UIImageView.new;
        [_imgV3 setCornerRadius:5];
        _imgV3.contentMode = UIViewContentModeScaleAspectFill;
        _imgV3.userInteractionEnabled = YES;
        _imgV3.tag = Tag_Photo + 2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imgV3 addGestureRecognizer:tap];
    }
    return _imgV3;
}

- (UIImageView *)imgV4{
    if (!_imgV4) {
        _imgV4 = UIImageView.new;
        [_imgV4 setCornerRadius:5];
        _imgV4.contentMode = UIViewContentModeScaleAspectFill;
        _imgV4.userInteractionEnabled = YES;
        _imgV4.tag = Tag_Photo + 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imgV4 addGestureRecognizer:tap];
    }
    return _imgV4;
}

- (UIImageView *)imgV5{
    if (!_imgV5) {
        _imgV5 = UIImageView.new;
        [_imgV5 setCornerRadius:5];
        _imgV5.contentMode = UIViewContentModeScaleAspectFill;
        _imgV5.userInteractionEnabled = YES;
        _imgV5.tag = Tag_Photo + 4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imgV5 addGestureRecognizer:tap];
    }
    return _imgV5;
}

- (UIImageView *)imgV6{
    if (!_imgV6) {
        _imgV6 = UIImageView.new;
        [_imgV6 setCornerRadius:5];
        _imgV6.contentMode = UIViewContentModeScaleAspectFill;
        _imgV6.userInteractionEnabled = YES;
        _imgV6.tag = Tag_Photo + 5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_imgV6 addGestureRecognizer:tap];
    }
    return _imgV6;
}
@end
