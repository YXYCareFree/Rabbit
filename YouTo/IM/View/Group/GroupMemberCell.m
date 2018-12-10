//
//  GroupMemberCell.m
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupMemberCell.h"
#import "GroupMemberModel.h"
#import "GroupListController.h"

@implementation GroupMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.lblGroupOwner setCornerRadius:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Configure the view for the selected state
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    self.lblMemberCount.text = [NSString stringWithFormat:@"共%ld人", dataSource.count];
    
    [self setImage:self.imgV0 name:self.lblMember0 model:dataSource[0]];
    if (dataSource.count > 1) {
        [self setImage:self.imgV1 name:self.lblMember1 model:dataSource[1]];
    }
    if (dataSource.count > 2) {
        [self setImage:self.imgV2 name:self.lblMember2 model:dataSource[2]];
    }
    if (dataSource.count > 3) {
        [self setImage:self.imgV3 name:self.lblMember3 model:dataSource[3]];
    }
}

- (void)setImage:(UIImageView *)imgV name:(UILabel *)lbl model:(GroupMemberModel *)model{
    imgV.hidden = lbl.hidden = NO;
    [imgV sd_setImageWithURL:URLWithStr(model.faceUrl) placeholderImage:PlaceHolderImage];
    lbl.text = model.nickName;
}

- (IBAction)lookMoreMember:(id)sender {
    GroupListController *vc = [[GroupListController alloc] init];
    vc.groupId = self.groupId;
    PushVC(vc);
}



@end
