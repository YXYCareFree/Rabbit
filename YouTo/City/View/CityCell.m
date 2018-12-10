//
//  CityCell.m
//  YouTo
//
//  Created by apple on 2018/12/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityCell.h"
#import "MoodDetailHeaderCell.h"
#import "MoodDetailController.h"
#import "AccountManager.h"

@implementation CityCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CityContentType)type{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.type = type;
        [self setUI];
    }
    return self;
}

- (void)setUI{

    self.vc.type = self.type;
    [self.contentView addSubview:self.vc.view];
    [self.vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (CityController *)vc{
    if (!_vc) {
        _vc = [[CityController alloc] initWithType:self.type];
        WEAKSELF;
        _vc.ChangeCityContentBlock = ^(CityContentType type) {
            if (weakSelf.ChangeCityContentBlock) {
                weakSelf.ChangeCityContentBlock(type);
            }
        };
    }
    return _vc;
}

//#pragma mark UITableViewDelegate UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.dataSource.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    MoodDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoodDetailHeaderCellID" forIndexPath:indexPath];
//    cell.model = self.dataSource[indexPath.section];
//    cell.LikeClickedBlock = ^{
//    };
//    cell.CommentClickedBlock = ^{
//        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
//    };
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MoodDetailModel *model = self.dataSource[indexPath.section];
//
////    UserModel *user = [AccountManager getUserInfo];
////    MoodDetailController *vc = [[MoodDetailController alloc] initWithType:type moodId:model.ID isSelf:[user.memberId isEqualToString:model.memberId]];
////    PushVC(vc);
//}


@end
