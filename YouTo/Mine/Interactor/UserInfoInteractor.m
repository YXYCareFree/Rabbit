//
//  UserInfoInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UserInfoInteractor.h"
#import "AccountManager.h"
#import "LoginAdapter.h"
#import "AccountManager.h"
#import "UserModel.h"
#import "NSObject+YYModel.h"

#import "CommonDetailAdapter.h"
#import "HelpDetailAdapter.h"
#import "MoodDetailAdapter.h"

#import "MoodDetailController.h"
#import "ChatController.h"

@interface UserInfoInteractor ()

@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, strong) CommonDetailAdapter *adapter;
@property (nonatomic, assign) BOOL isAttention;
@property (nonatomic, strong) NSString *memberId;

@end

@implementation UserInfoInteractor

- (void)loadData{
    if (SelfVC.isSelf) {
        self.userModel = [UserModel getUserModel];
    }else{
        self.memberId = SelfVC.memberId?:SelfVC.userInfoModel.memberId;
        [AccountManager getOtherUserInfoByMemberId:self.memberId pageNum:self.pageNum completion:^(BOOL success, id response) {
            if (success) {
                self.userModel = [UserModel yy_modelWithJSON:response];
                [SelfVC.tableView reloadData];
            }
        }];
        [AccountManager checkIsAttentionByMemeberId:self.memberId completion:^(BOOL success, id response) {
            if (success) {
                self.isAttention = [response boolValue];
                [self setAttentionStatus];
            }
        }];
    }
}

- (void)setAttentionStatus{
    if (self.isAttention) {
        SelfVC.imgVAttention.image = LoadImageWithName(@"cancel_attention");
        SelfVC.lblAttention.text = @"取关";
    }else{
        SelfVC.imgVAttention.image = LoadImageWithName(@"attention");
        SelfVC.lblAttention.text = @"关注";
    }
}

- (void)atttionClicked{
    if (self.isAttention) {
        [[[CommonDetailAdapter alloc] init] cancelAttentionMemberId:self.memberId completion:^(BOOL success, id response) {
            if (success) {
                [MBProgressHUD showText:@"取关成功"];
                self.isAttention = NO;
                [self setAttentionStatus];
            }
        }];
    }else{
        [[[CommonDetailAdapter alloc] init] addAttentionMemberId:self.memberId completion:^(BOOL success, id response) {
            if (success) {
                [MBProgressHUD showText:@"关注成功"];
                self.isAttention = YES;
                [self setAttentionStatus];
            }
        }];
    }
}

- (void)chatClicked{
    ChatController *vc = [[ChatController alloc] initWithConversationType:ConversationType_PRIVATE targetId:self.memberId];
    vc.title = SelfVC.userInfoModel.nickName;
    PushVC(vc);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.userModel.dataList.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UserInfoCell *cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserInfoCellID"];
        cell.isSelf = SelfVC.isSelf;
        cell.type = UserInfoCellTypeDynamic;
        if (SelfVC.isSelf) {
            cell.model = [UserModel getUserModel];
        }else{
            cell.model = self.userModel;
        }
        return cell;
    }
    UserDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserDynamicCellID" forIndexPath:indexPath];
    cell.model = self.userModel.dataList[indexPath.section - 1];
    __weak UserDynamicCell *wCell = cell;
    cell.LikeBlock = ^{
        CommonDetailAdapter *adapter;
        // 0心情  1求助
        if (wCell.model.type) {
            adapter = [[HelpDetailAdapter alloc] init];
        }else{
            adapter = [[MoodDetailAdapter alloc] init];
        }
        if (wCell.model.isLike) {
            [adapter unlikeReplyId:wCell.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    wCell.model.isLike = NO;
                    [wCell.btnLike setImage:LoadImageWithName(@"mine_zan_nor") forState:UIControlStateNormal];
                    int num = [wCell.model.likeNum intValue];
                    wCell.model.likeNum = [NSString stringWithFormat:@"%d", --num];
                    wCell.lblLike.text = wCell.model.likeNum;
                }
            }];
        }else{
            [adapter likeReplyId:wCell.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    wCell.model.isLike = YES;
                    [wCell.btnLike setImage:LoadImageWithName(@"mine_zan_sel") forState:UIControlStateNormal];
                    int num = [wCell.model.likeNum intValue];
                    wCell.model.likeNum = [NSString stringWithFormat:@"%d", ++num];
                    wCell.lblLike.text = wCell.model.likeNum;
                }
            }];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return;
    
    MoodDetailModel *model = self.userModel.dataList[indexPath.section - 1];
    MoodDetailController *vc = [[MoodDetailController alloc] initWithType:model.type ? CityContentTypeHelp : CityContentTypeMood moodId: model.ID isSelf:SelfVC.isSelf];
    PushVC(vc);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:0];
    CGFloat height = [self.vc.tableView rectForRowAtIndexPath:path].size.height;
    NSLog(@"%f, %f", height, scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > height) {
        SelfVC.colorBack = UIColor.blackColor;
        SelfVC.lblTitle.color(UIColor.blackColor);
        SelfVC.vNavBar.backgroundColor = UIColor.whiteColor;
    }else{
        SelfVC.colorBack = WhiteColor;
        SelfVC.lblTitle.color(WhiteColor);
        SelfVC.vNavBar.backgroundColor = UIColor.clearColor;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 15;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = UIView.new;
    view.layer.shadowColor = Color_C.CGColor;
    view.layer.shadowOffset = CGSizeMake(0, -5);
    view.layer.shadowOpacity = 0.3;
    return view;
}


@end
