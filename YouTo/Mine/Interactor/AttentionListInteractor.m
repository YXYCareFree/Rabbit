//
//  AttentionListInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AttentionListInteractor.h"
#import "AttentionListCell.h"
#import "AttentionAdapter.h"
#import "CommonDetailAdapter.h"
#import "UserInfoController.h"
#import "UserModel.h"

@interface AttentionListInteractor ()

@end

@implementation AttentionListInteractor

- (void)loadData{
    switch (SelfVC.type) {
        case AttentionListControllerTypeAttentionOther:{
            [AttentionAdapter getMyAttentionPageNum:self.pageNum completion:^(BOOL success, id response) {
                if (success) {
                    self.dataSource = [NSMutableArray arrayWithArray:response];
                    [SelfVC.tableView reloadData];
                }
            }];
        } break;
        case AttentionListControllerTypeAttentionMe:{
            [AttentionAdapter getAttentionMePageNum:self.pageNum completion:^(BOOL success, id response) {
                if (success) {
                    self.dataSource = [NSMutableArray arrayWithArray:response];
                    [SelfVC.tableView reloadData];
                }
            }];
        }break;
        case AttentionListControllerTypeEachOther:{
            [AttentionAdapter getAttentionEachOtherPageNum:self.pageNum completion:^(BOOL success, id response) {
                if (success) {
                    self.dataSource = [NSMutableArray arrayWithArray:response];
                    [SelfVC.tableView reloadData];
                }
            }];
        } break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionListCellID" forIndexPath:indexPath];
    UserModel *model = self.dataSource[indexPath.row];
    [cell.imgV sd_setImageWithURL:URLWithStr(model.headImg) placeholderImage:PlaceHolderImage];
    cell.lblName.text = model.nickName;
    cell.lblDetail.text = [NSString stringWithFormat:@"现居地 %@  出生地 %@", model.currentLiveAddress, model.birthAddress];
    if ([model.sex isEqualToString:@"男"]) {
        cell.imgVSex.image = LoadImageWithName(@"man");
    }else{
        cell.imgVSex.image = LoadImageWithName(@"woman");
    }
    switch (SelfVC.type) {
        case AttentionListControllerTypeAttentionMe:{
            if (model.isConcern) {
                [cell.btnAttention setTitle:@"取关" forState:UIControlStateNormal];
                [cell.btnAttention setTitleColor:Color_Main forState:UIControlStateNormal];
                cell.btnAttention.backgroundColor = WhiteColor;
                cell.btnAttention.layer.borderWidth = 1;
                cell.btnAttention.layer.borderColor = Color_Main.CGColor;
            }else{
                cell.btnAttention.backgroundColor = Color_Main;
                [cell.btnAttention setTitle:@"关注" forState:UIControlStateNormal];
                [cell.btnAttention setTitleColor:WhiteColor forState:UIControlStateNormal];
            }
        }
            break;
            
        default:{
            [cell.btnAttention setTitle:@"取关" forState:UIControlStateNormal];
            [cell.btnAttention setTitleColor:Color_Main forState:UIControlStateNormal];
            cell.btnAttention.backgroundColor = WhiteColor;
            cell.btnAttention.layer.borderWidth = 1;
            cell.btnAttention.layer.borderColor = Color_Main.CGColor;
        }
            break;
    }
    
    cell.UserIconClickedBlock = ^{
        UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:model.memberId];
        PushVC(vc);
    };
    
    cell.AttentionClickedBlock = ^{
        switch (SelfVC.type) {
            case AttentionListControllerTypeAttentionMe:{
                if (model.isConcern) {
                    [[[CommonDetailAdapter alloc] init]cancelAttentionMemberId:model.memberId completion:^(BOOL success, id response) {
                        if (success) {
                            [MBProgressHUD showText:@"取注成功"];
                            [SelfVC.tableView.mj_header beginRefreshing];
                        }
                    }];
                }else{
                    [[[CommonDetailAdapter alloc] init] addAttentionMemberId:model.memberId completion:^(BOOL success, id response) {
                        if (success) {
                            [MBProgressHUD showText:@"关注成功"];
                            [SelfVC.tableView.mj_header beginRefreshing];
                        }
                    }];
                }
                
            } break;
                
            default:{
                [[[CommonDetailAdapter alloc] init]cancelAttentionMemberId:model.memberId completion:^(BOOL success, id response) {
                    if (success) {
                        [MBProgressHUD showText:@"取注成功"];
                        [SelfVC.tableView.mj_header beginRefreshing];
                    }
                }];
            }
                break;
        }
    };
    return cell;
}

@end
