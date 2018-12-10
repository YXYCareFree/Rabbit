//
//  GroupTextCell.m
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupTextCell.h"

@implementation GroupTextCell

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
        
    }
    return self;
}

- (void)setType:(GroupTextCellType)type{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    if (type == GroupTextCellTypeIntroduce) {

        [self.contentView addSubview:self.lblDetail];
        [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@16);
            make.bottom.equalTo(@-19);
        }];
        
        [self addVSplit];
    }else{
        self.lblTitle.title(@"群类型");
        [self.contentView addSubview:self.lblTitle];
        [self.contentView addSubview:self.lblDetail];

        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.top.equalTo(@19);
        }];

        if (type == GroupTextCellTypeLocation) {
            self.lblTitle.title(@"群位置");
            [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lblTitle.mas_bottom).offset(13);
                make.left.equalTo(@16);
                make.bottom.equalTo(@-19);
            }];
        }else{
            [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lblTitle.mas_bottom).offset(13);
                make.left.equalTo(@16);
                make.bottom.equalTo(@-19);
            }];
        }
    }
}

- (void)setArrTag:(NSArray *)arrTag{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < arrTag.count; i++) {
        YXYLabel *temp = nil;
        if (arr.count) temp = arr[i - 1];
        YXYLabel *lbl = [[YXYLabel alloc] init];
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setCornerRadius:5];
        lbl.backgroundColor = Color_Main;
        lbl.title(arrTag[i]).titleFont(Font(14)).color(WhiteColor);
        [arr addObject:lbl];
        [self.contentView addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@60);
            make.height.equalTo(@25);
            if (temp) {
                make.left.equalTo(temp.mas_right).offset(15);
            }else{
                make.left.equalTo(@(15));
            }
            make.bottom.equalTo(@(-20));
            make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
        }];
    }
    [self addVSplit];
}

- (void)addVSplit{
    UIView *v = UIView.new;
    v.backgroundColor = Color_E;
    [self.contentView addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
        make.left.right.equalTo(@0);
    }];
}

- (YXYLabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = YXYLabel.new;
        _lblTitle.color(Color_3).titleFont(Font_PingFang_Medium(18));
    }
    return _lblTitle;
}

- (YXYLabel *)lblDetail{
    if (!_lblDetail) {
        _lblDetail = YXYLabel.new;
        _lblDetail.color(Color_3).titleFont(Font(14));
    }
    return _lblDetail;
}
@end
