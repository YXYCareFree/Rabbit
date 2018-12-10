//
//  RankingCell.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RankingCell.h"
#import "UIButton+WebCache.h"

@implementation RankingCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.btnFirst setCornerRadius:27];
    [self.btnSecond setCornerRadius:27];
    [self.btnThird setCornerRadius:27];

    [self setBtnContenModel:self.btnFirst];
    [self setBtnContenModel:self.btnSecond];
    [self setBtnContenModel:self.btnThird];
}

- (void)setBtnContenModel:(UIButton *)btn{
    [btn imageView].contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [_dataSource enumerateObjectsUsingBlock:^(WarmHeartListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [self.btnFirst sd_setImageWithURL:URLWithStr(obj.headImg) forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [self.btnFirst setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }];
        }
        if (idx == 1) {
            [self.btnSecond sd_setImageWithURL:URLWithStr(obj.headImg) forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [self.btnSecond setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }];
        }
        if (idx == 2) {
            [self.btnThird sd_setImageWithURL:URLWithStr(obj.headImg) forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [self.btnThird setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }];
        }
    }];
}

- (IBAction)btnFirstClicked:(id)sender {
    [self runBlock:0];
}

- (IBAction)btnSecondClicked:(id)sender {
    [self runBlock:1];
}

- (IBAction)btnThirdClicked:(id)sender {
    [self runBlock:2];
}

- (IBAction)rankClicked:(id)sender {
    [self runBlock:3];
}

- (IBAction)rank1Clicked:(id)sender {
    [self runBlock:3];
}

- (void)runBlock:(NSInteger)rank{
    if (self.RankingBlock) {
        self.RankingBlock(rank);
    }
}
@end
