//
//  GroupInfoInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupInfoInteractor.h"
#import "GroupAdapter.h"
#import "ApplyJoinGroupController.h"
#import "GroupListController.h"

@implementation GroupInfoInteractor

- (void)loadData{
    [GroupAdapter getGroupMemberList:SelfVC.model.groupId?:SelfVC.groupId completion:^(BOOL success, id response) {
        if (success) {
            self.groupMemberData = response;
            [SelfVC.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)btnJoinClicked{
    ApplyJoinGroupController *vc = [[ApplyJoinGroupController alloc] init];
    vc.groupId = SelfVC.model.groupId;
    vc.type = ApplyJoinGroupControllerTypeApply;
    PushVC(vc);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row == 1) {
        GroupMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupMemberCellID" forIndexPath:indexPath];
        cell.dataSource = self.groupMemberData;
        cell.groupId = SelfVC.model.groupId;
        return cell;
    }
    
    GroupTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupTextCellID" forIndexPath:indexPath];
    if (row == 0) {
        cell.type = GroupTextCellTypeIntroduce;
        cell.lblDetail.text = SelfVC.model.info;
    }
    if (row == 2) {
        cell.type = GroupTextCellTypeTag;
        cell.arrTag = [SelfVC.model.groupType componentsSeparatedByString:@","];
    }
    if (row == 3) {
        cell.type = GroupTextCellTypeLocation;
        cell.lblDetail.text = SelfVC.model.address;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        GroupListController *vc = [[GroupListController alloc] init];
        vc.groupId = SelfVC.model.groupId;
        PushVC(vc);
    }
}

@end
