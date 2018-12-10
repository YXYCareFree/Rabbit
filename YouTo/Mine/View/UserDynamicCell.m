//
//  UserDynamicCell.m
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UserDynamicCell.h"
#import "MHPhotoBrowserController.h"

@implementation UserDynamicCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.contentView.layer.shadowColor = Color_C.CGColor;
    self.contentView.layer.shadowOffset = CGSizeZero;
    self.contentView.layer.shadowOpacity = 0.3;
    [self.vBg setCornerRadius:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (void)setModel:(MoodDetailModel *)model{
    if (!model) return;
    _model = model;

    self.lblTitle.text = model.title;
    self.titleTopConstraint.constant = model.title.length ? 15 : 10;
    self.lblTime.text = model.showTime;
    self.lblDetail.text = model.info;
    self.lblComment.text = model.commentNum;
    if (model.type) {//求助
       self.lblFrom.text = @"来自求助";
    }else{
        self.lblFrom.text = @"来自心情";
    }

    self.lblLocation.text = model.currentAddress;
    self.lblAtLocation.text = model.visitAddress;
    
    if (model.isLike) {
        [self.btnLike setImage:LoadImageWithName(@"mine_zan_sel") forState:UIControlStateNormal];
    }else{
        [self.btnLike setImage:LoadImageWithName(@"mine_zan_nor") forState:UIControlStateNormal];
    }

    self.lblLike.text = model.lookNum;
    self.lblLike.text = model.likeNum;

    [self.vImgVBg.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    if (!model.infoImg || !model.infoImg.count) {
        return;
    }
    NSInteger count = model.infoImg.count;
    if (count == 1) {
        [self.vImgVBg addSubview:self.imgV1];
        [self.imgV1 sd_setImageWithURL:URLWithStr(model.infoImg[0]) placeholderImage:PlaceHolderImage_City];
        [self.imgV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.vImgVBg);
            make.height.equalTo(@(self.vBg.yxy_w * 0.475));
        }];
        return;
    }
    
    [self.vImgVBg addSubview:self.imgV1];
    [self.vImgVBg addSubview:self.imgV2];
//    self.imgV1.urlStr = model.infoImg[0];
    [self.imgV1 sd_setImageWithURL:URLWithStr(model.infoImg[0]) placeholderImage:PlaceHolderImage_City];
    [self.imgV2 sd_setImageWithURL:URLWithStr(model.infoImg[1]) placeholderImage:PlaceHolderImage_City];
    
    CGFloat width = (kScreenWidth - 30 - 20 - 20) / 3;
    CGFloat height = width * 3 / 4;
    
    [self.imgV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.vImgVBg);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    [self.imgV2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV1.mas_right).offset(10);
        if (count < 4) {
            make.bottom.equalTo(self.vImgVBg);
        }
        make.top.equalTo(self.vImgVBg);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    if (count == 4) {
        [self.vImgVBg addSubview:self.imgV4];
        [self.vImgVBg addSubview:self.imgV5];
        [self.imgV4 sd_setImageWithURL:URLWithStr(model.infoImg[2]) placeholderImage:PlaceHolderImage_City];
        [self.imgV5 sd_setImageWithURL:URLWithStr(model.infoImg[3]) placeholderImage:PlaceHolderImage_City];
        
        [self.imgV4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.vImgVBg);
            make.bottom.equalTo(self.vImgVBg);
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
    [self.vImgVBg addSubview:self.imgV3];
    [self.imgV3 sd_setImageWithURL:URLWithStr(model.infoImg[2]) placeholderImage:PlaceHolderImage_City];
    [self.imgV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV2);
        make.right.equalTo(@0);
        make.left.equalTo(self.imgV2.mas_right).offset(10);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    if (count < 5) return;
    [self.vImgVBg addSubview:self.imgV4];
    [self.imgV4 sd_setImageWithURL:URLWithStr(model.infoImg[3]) placeholderImage:PlaceHolderImage_City];
    [self.imgV4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vImgVBg);
        make.bottom.equalTo(self.vImgVBg);
        make.top.equalTo(self.imgV1.mas_bottom).offset(10);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    [self.vImgVBg addSubview:self.imgV5];
    [self.imgV5 sd_setImageWithURL:URLWithStr(model.infoImg[4]) placeholderImage:PlaceHolderImage_City];
    [self.imgV5 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV4);
        make.left.equalTo(self.imgV4.mas_right).offset(10);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
    
    if (count < 6) return;
    [self.vImgVBg addSubview:self.imgV6];
    [self.imgV6 sd_setImageWithURL:URLWithStr(model.infoImg[5]) placeholderImage:PlaceHolderImage_City];
    [self.imgV6 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgV4);
        make.left.equalTo(self.imgV5.mas_right).offset(10);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
}

- (IBAction)btnLikeClicked:(id)sender {
    if (self.LikeBlock) {
        self.LikeBlock();
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
    vc.currentImgIndex = [self.model.infoImg indexOfObject:str];
    vc.imgArray = [NSMutableArray arrayWithArray:self.model.infoImg];
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
