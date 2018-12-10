//
//  SettingChatUserInfoInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SettingChatUserInfoInteractor.h"
#import "MineCell.h"
#import "ApplyJoinGroupController.h"
#import "CommonDetailAdapter.h"
#import "AccountManager.h"

@interface SettingChatUserInfoInteractor ()

@property (nonatomic, assign) BOOL isAttention;
@property (nonatomic, assign) BOOL isBlack;

@end

@implementation SettingChatUserInfoInteractor

- (void)getRemarkName:(void (^)(NSString * _Nonnull))block{
    [AccountManager getRemarkName:SelfVC.memberId completion:^(BOOL success, id response) {
        if (success) {
            if (block) {
                block([response valueForKey:@"remark"]);
            }
        }
    }];
}

- (void)loadData{
    __block BOOL attention = NO;
    __block BOOL black = NO;
    [AccountManager checkIsAttentionByMemeberId:SelfVC.memberId completion:^(BOOL success, id response) {
        if (success) {
            self.isAttention = [response boolValue];
            attention = YES;
            if (black) {
                [SelfVC.tableView reloadData];
            }
        }
    }];
    [AccountManager checkIsInBlackList:SelfVC.memberId completion:^(BOOL success, id response) {
        if (success) {
            black = YES;
            self.isBlack = [response boolValue];
            if (attention) {
                [SelfVC.tableView reloadData];
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCellID" forIndexPath:indexPath];
    cell.imgVLeftConstraint.constant = 0;
    cell.imgVGoToDetail.hidden = indexPath.row;
    switch (indexPath.row) {
        case 0: cell.lblTitle.text = @"设置备注"; break;
        case 1:{
            cell.lblTitle.text = self.isAttention ? @"取消关注" : @"关注";
        } break;
        case 2: {
            cell.lblTitle.text = self.isBlack ? @"移除黑名单" : @"加入黑名单";
        }break;

        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            ApplyJoinGroupController *vc = [[ApplyJoinGroupController alloc] init];
            vc.type = ApplyJoinGroupControllerTypeSign;
            vc.remarkId = SelfVC.memberId;
            PushVC(vc);
        }break;
        case 1:{
            if (self.isAttention) {
                [[[CommonDetailAdapter alloc] init] cancelAttentionMemberId:SelfVC.memberId completion:^(BOOL success, id response) {
                    if (success) {
                        [MBProgressHUD showText:@"取关成功"];
                        [self loadData];
                    }
                }];
            }else{
                [[[CommonDetailAdapter alloc] init] addAttentionMemberId:SelfVC.memberId completion:^(BOOL success, id response) {
                    if (success) {
                        [MBProgressHUD showText:@"关注成功"];
                        [self loadData];
                    }
                }];
            }
        } break;
        case 2:{
            if (self.isBlack) {
                [AccountManager removeBlackList:SelfVC.memberId completion:^(BOOL success, id response) {
                    if (success) {
                        [MBProgressHUD showText:@"移除黑名单成功"];
                        [self loadData];
                    }
                }];
            }else{
                [AccountManager addBlackList:SelfVC.memberId completion:^(BOOL success, id response) {
                    if (success) {
                        [MBProgressHUD showText:@"添加黑名单成功"];
                        [self loadData];
                    }
                }];
            }
        }break;
        default:
            break;
    }
}
@end
