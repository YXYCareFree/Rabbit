//
//  ChatCell.m
//  YouTo
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ChatTextCell.h"

@interface ChatTextCell ()

@property (nonatomic, strong) YXYLabel *lblName;
@property (nonatomic, strong) YXYLabel *lblContent;
@property (nonatomic, strong) UIImageView *imgVIcon;
@property (nonatomic, strong) UIView *vContent;

@end

@implementation ChatTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.clearColor;

        [self.contentView addSubview:self.imgVIcon];
        [self.contentView addSubview:self.lblName];
        [self.contentView addSubview:self.vContent];
        [self.vContent addSubview:self.lblContent];
        [self.lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@12);
            make.right.bottom.equalTo(@(-12));
        }];
        self.lblContent.text = @"啊飒飒空间都能想起我看到你请我看jgvhgv jhbjhbhj";
        [self setUI];
    }
    return self;
}

- (void)setUI{
    BOOL isSelf = YES;
    [self.imgVIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (isSelf) {
            make.right.equalTo(@(-15));
        }else{
            make.left.equalTo(@(15));
        }
        make.top.equalTo(@15);
        make.width.height.equalTo(@45);
    }];
    
    [self.lblName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        if (isSelf) {
            make.right.equalTo(self.imgVIcon.mas_left).offset(-5);
        }else{
            make.left.equalTo(self.imgVIcon.mas_right).offset(5);
        }
    }];
    
    [self.vContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblName.mas_bottom).offset(10);
        make.bottom.equalTo(@(-15));
        if (isSelf) {
            make.right.equalTo(self.imgVIcon.mas_left).offset(-5);
            make.left.equalTo(@72);
        }else{
            make.left.equalTo(self.imgVIcon.mas_right).offset(5);
            make.right.equalTo(@(-72));
        }
    }];
}

- (YXYLabel *)lblName{
    if (!_lblName) {
        _lblName = [[YXYLabel alloc] init];
        _lblName.color(Color_6).titleFont(Font_PingFang_Medium(13));
    }
    return _lblName;
}

- (UIImageView *)imgVIcon{
    if (!_imgVIcon) {
        _imgVIcon = [[UIImageView alloc] initWithImage:PlaceHolderImage];
        _imgVIcon.contentMode = UIViewContentModeScaleAspectFill;
        [_imgVIcon setCornerRadius:22.5];
    }
    return _imgVIcon;
}

- (YXYLabel *)lblContent{
    if (!_lblContent) {
        _lblContent = [[YXYLabel alloc] init];
        _lblContent.color(Color_3).titleFont(Font_PingFang_Medium(15));
    }
    return _lblContent;
}

- (UIView *)vContent{
    if (!_vContent) {
        _vContent = [[UIView alloc] init];
        _vContent.backgroundColor = WhiteColor;
        [_vContent setCornerRadius:5];
    }
    return _vContent;
}
@end
