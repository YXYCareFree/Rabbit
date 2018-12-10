//
//  GroupListInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupListInteractor.h"
#import "GroupListCell.h"
#import "GroupAdapter.h"
#import "GroupMemberModel.h"
#import "UserInfoController.h"
#import "AccountManager.h"

@implementation GroupListInteractor

- (void)loadData{
    [GroupAdapter getGroupMemberList:SelfVC.groupId completion:^(BOOL success, id response) {
        if (success) {
            self.dataSource = [NSMutableArray arrayWithArray:response];
            [SelfVC.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupListCellID" forIndexPath:indexPath];
    cell.lblGroupOwner.hidden = indexPath.row;
    GroupMemberModel *model = self.dataSource[indexPath.row];
    cell.lblName.text = model.nickName;
    cell.lblAddress.text = model.currentLiveAddress;
    cell.lblGroupOwner.hidden = !model.isMaster;
    [cell.imgV sd_setImageWithURL:URLWithStr(model.faceUrl) placeholderImage:PlaceHolderImage];
    if ([model.sex isEqualToString:@"男"]) {
        cell.imgVSex.image = LoadImageWithName(@"man");
    }else{
        cell.imgVSex.image = LoadImageWithName(@"woman");
    }
    
    cell.UserIconClicked = ^{
        UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:model.memberId];
        PushVC(vc);
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupMemberModel *model = self.dataSource[indexPath.row];
    [GroupAdapter deleteMember:model.memberId inGroup:SelfVC.groupId completion:^(BOOL success, id response) {
        if (success) {
            [MBProgressHUD showText:@"删除成功"];
            [tableView reloadData];
        }
    }];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupMemberModel *model = self.dataSource[0];
    if ([model.memberId isEqualToString:[AccountManager memberId]]) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row) {
        return YES;
    }
    return NO;
}

@end
