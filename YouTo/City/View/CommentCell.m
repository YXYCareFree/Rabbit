//
//  CommentCell.m
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CommentCell.h"
#import "AccountManager.h"

@interface CommentCell ()

@property (nonatomic, strong) UIImageView *imgVIcon;
@property (nonatomic, strong) YXYLabel *lblName;
@property (nonatomic, strong) YXYLabel *lblTime;
@property (nonatomic, strong) YXYLabel *lblChoice;

@property (nonatomic, strong) UIView *vReplyBg;//回复的bg

@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
        longPress.minimumPressDuration = 0.5;
        [self.contentView addGestureRecognizer:longPress];
    }
    return self;
}

- (void)longPress{
    UserModel *model = [AccountManager getUserInfo];
    if ([model.memberId isEqualToString:self.model.memberId] || (self.answerDetailModel && [model.memberId isEqualToString:self.answerDetailModel.memberId]) || self.isSelf) {
        if (self.LongPressBlcok) {
            self.LongPressBlcok();
        }
    }
}

- (void)jumpAnswerDetail{
    if (self.JumpAnswerDetailBlcok) {
        self.JumpAnswerDetailBlcok();
    }
}

- (void)lookAll{
    if (self.JumpAnswerDetailBlcok) {
        self.JumpAnswerDetailBlcok();
    }
}

- (void)btnFavourClicked{
    if (self.LikeBlcok) {
        self.LikeBlcok();
    }
}

- (void)setAnswerDetailModel:(MoodAnswerDetailListModel *)answerDetailModel{
    if (!answerDetailModel) return;
   
    [self setUI];

    _answerDetailModel = answerDetailModel;
    [self.imgVIcon sd_setImageWithURL:URLWithStr(answerDetailModel.headImg) placeholderImage:PlaceHolderImage];
    self.lblName.text = answerDetailModel.nickName;
    self.lblTime.text = answerDetailModel.showTime;
    self.lblFavour.text = answerDetailModel.likeNum;
    self.lblDetail.text = answerDetailModel.info;
    if (answerDetailModel.isLike) {
        [_btnFavour setImage:LoadImageWithName(@"mine_zan_sel") forState:UIControlStateNormal];
    }else{
        [_btnFavour setImage:LoadImageWithName(@"mine_zan_nor") forState:UIControlStateNormal];
    }
}

//- (void)setType:(CommentCellType)type{
//    _type = type;
//}

- (void)setModel:(AnswerListModel *)model{
    if (model) {
        _model = model;
        
        [self setUI];

        if (self.type == CommentCellTypeComment) {
            [self addReplyView];
        }

        [self.imgVIcon sd_setImageWithURL:URLWithStr(model.headImg) placeholderImage:PlaceHolderImage];
        self.lblName.text = model.nickName;
        self.lblTime.text = model.showTime;
        self.lblFavour.text = model.likeNum;
        self.lblDetail.text = model.info;
        if (model.isLike) {
            [_btnFavour setImage:LoadImageWithName(@"mine_zan_sel") forState:UIControlStateNormal];
        }else{
            [_btnFavour setImage:LoadImageWithName(@"mine_zan_nor") forState:UIControlStateNormal];
        }
    }
}

- (void)addReplyView{
    
    [self.contentView addSubview:self.vReplyBg];
    [self.vReplyBg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblDetail.mas_bottom).offset(10);
        make.right.equalTo(@(15));
        make.left.equalTo(self.imgVIcon.mas_right).offset(10);
        make.bottom.equalTo(@(-15));
    }];
    
    [self.vReplyBg.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    UILabel *label1;
    UILabel *label2;
    for (NSInteger i = 0; i < self.model.moodAnswerDetailList.count; i++) {
        MoodAnswerDetailListModel *model = self.model.moodAnswerDetailList[i];
        NSMutableAttributedString *mattr = [NSMutableAttributedString new];
        NSDictionary *dict1 = @{NSFontAttributeName: Font_PingFang_Medium(13), NSForegroundColorAttributeName: Color_3};
        NSAttributedString *s1 = [[NSAttributedString alloc] initWithString:model.nickName attributes:dict1];
        NSAttributedString *s2 = [[NSAttributedString alloc] initWithString:@"回复" attributes:@{NSFontAttributeName: Font_PingFang_Medium(13), NSForegroundColorAttributeName: ColorWithHex(@"808080")}];
        NSString *str = [NSString stringWithFormat:@"%@:%@", self.model.nickName, model.info];
        NSAttributedString *s3 = [[NSAttributedString alloc] initWithString:str attributes:dict1];
        [mattr appendAttributedString:s1];
        [mattr appendAttributedString:s2];
        [mattr appendAttributedString:s3];
        
        UILabel *lbl = UILabel.new;
        lbl.numberOfLines = 0;
        lbl.attributedText = mattr;
        [self.vReplyBg addSubview:lbl];
        if (i == 0) {
            label1 = lbl;
            [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(@10);
                make.right.equalTo(@(-10));
                if (self.model.moodAnswerDetailList.count == 1) {
                    make.bottom.equalTo(@(-10));
                }
            }];
        }

        if (i == 1) {
            label2 = lbl;
            [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.right.equalTo(@(-10));
                make.top.equalTo(label1.mas_bottom).offset(3);
                if (self.model.moodAnswerDetailList.count == 2) {
                    make.bottom.equalTo(@(-10));
                }
            }];
            
            if (self.model.moodAnswerDetailList.count > 2) {
                YXYButton *btn = YXYButton.new;
                btn.title(@"查看全部", UIControlStateNormal).titleFont(Font_PingFang_Medium(13)).color(Color_Main, UIControlStateNormal);
                [btn addTarget:self action:@selector(lookAll) forControlEvents:UIControlEventTouchUpInside];
                [self.vReplyBg addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.equalTo(lbl).offset(10);
                    make.bottom.equalTo(@(-10));
                }];
                YXYButton *btn1 = YXYButton.new;
                btn1.tintColor = Color_Main;
                btn1.bgImgae(LoadImageWithName(@"goToDetail"), UIControlStateNormal);
                [btn1 addTarget:self action:@selector(lookAll) forControlEvents:UIControlEventTouchUpInside];
                [self.vReplyBg addSubview:btn1];
                [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(btn);
                    make.left.equalTo(btn.mas_right).offset(4);
                }];
            }
        }
    }
}

- (void)setUI{
    UIView *contenView = self.contentView;
    [contenView addSubview:self.imgVIcon];
    [self.imgVIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@15);
        make.width.height.equalTo(@40);
    }];
    
    [contenView addSubview:self.lblName];
    [self.lblName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgVIcon.mas_right).offset(10);
        make.top.equalTo(@16);
    }];
    
    [contenView addSubview:self.lblTime];
    [self.lblTime mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgVIcon.mas_right).offset(10);
        make.top.equalTo(self.lblName.mas_bottom).offset(2);
    }];
    
    [contenView addSubview:self.lblFavour];
    [self.lblFavour mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.lblName);
    }];
    
    [contenView addSubview:self.btnFavour];
    [self.btnFavour mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblFavour);
        make.right.equalTo(self.lblFavour.mas_left).offset(-5);
    }];
    
    [self.contentView addSubview:self.lblChoice];
    [self.lblChoice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgVIcon.mas_right).offset(10);
        if (self.model.isGood) {
            make.width.equalTo(@55);
        }else{
            make.width.equalTo(@0);
        }
        make.top.equalTo(self.lblTime.mas_bottom).offset(4);
    }];
    
    [self.contentView addSubview:self.lblDetail];
    [self.lblDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.model.isGood) {
            make.left.equalTo(self.lblChoice.mas_right).offset(8);
        }else{
            make.left.equalTo(self.lblChoice.mas_right).offset(0);
        }
        make.centerY.equalTo(self.lblChoice);
        make.right.equalTo(@(-23));
        if (self.type == CommentCellTypeDetail) {
            make.bottom.equalTo(@(-15));
        }else{
            if (!self.model.moodAnswerDetailList.count) {
                make.bottom.equalTo(@(-15));
            }
        }
    }];
}
#pragma mark--Setter Getter

- (UIView *)vReplyBg{
    if (!_vReplyBg) {
        _vReplyBg = [[UIView alloc] init];
        _vReplyBg.backgroundColor = Color_E;
        [_vReplyBg setCornerRadius:5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpAnswerDetail)];
        [_vReplyBg addGestureRecognizer:tap];
    }
    return _vReplyBg;
}

- (YXYLabel *)lblName{
    if (!_lblName) {
        _lblName = YXYLabel.new;
        _lblName.titleFont(Font_PingFang_Medium(14)).color(ColorWithHex(@"4d4d4d"));
    }
    return _lblName;
}

- (YXYLabel *)lblTime{
    if (!_lblTime) {
        _lblTime = YXYLabel.new;
        _lblTime.color(ColorWithHex(@"b3b3b3")).titleFont(Font_PingFang_Medium(11));
    }
    return _lblTime;
}

- (YXYLabel *)lblFavour{
    if (!_lblFavour) {
        _lblFavour = YXYLabel.new;
        _lblFavour.titleFont(Font_PingFang_Medium(12)).color(ColorWithHex(@"666666"));
    }
    return _lblFavour;
}

- (YXYButton *)btnFavour{
    if (!_btnFavour) {
        _btnFavour = YXYButton.new;
        [_btnFavour addTarget:self action:@selector(btnFavourClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnFavour;
}

- (YXYLabel *)lblChoice{
    if (!_lblChoice) {
        _lblChoice = YXYLabel.new;
        _lblChoice.titleFont(Font(11)).color(ColorWithHex(@"fc592d")).title(@"  精选回答  ");
        _lblChoice.layer.borderColor = ColorWithHex(@"fc592d").CGColor;
        _lblChoice.layer.borderWidth = 1;
        [_lblChoice setCornerRadius:5];
    }
    return _lblChoice;
}

- (UIImageView *)imgVIcon{
    if (!_imgVIcon) {
        _imgVIcon = [UIImageView new];
        [_imgVIcon setCornerRadius:20];
    }
    return _imgVIcon;
}

- (YXYLabel *)lblDetail{
    if (!_lblDetail) {
        _lblDetail = YXYLabel.new;
        _lblDetail.color(Color_3).titleFont(Font_PingFang_Medium(14));
    }
    return _lblDetail;
}
@end
