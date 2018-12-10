//
//  MineInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MineInteractor.h"
#import "MineCell.h"
#import "UserInfoCell.h"
#import "UserInfoController.h"
#import "AccountManager.h"
#import "YXYSelectView.h"
#import "ShareView.h"
#import "MineHeaderCell.h"

@interface MineInteractor ()

@property (nonatomic, strong) NSArray *arrTitle;
@property (nonatomic, strong) NSArray *arrImg;

@end

@implementation MineInteractor


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrImg.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row == 0) {
        MineHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHeaderCellID" forIndexPath:indexPath];
        cell.model = [AccountManager getUserInfo];
        cell.EditBlock = ^{
            PushVCWithClassName(@"EditUserInfoController");
        };
        cell.IconBlock = ^{
            
        };
        return cell;
    }
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCellID" forIndexPath:indexPath];
    cell.imgVLeftConstraint.constant = 15;
    cell.imgV.image = LoadImageWithName(self.arrImg[row]);
    cell.lblTitle.text = self.arrTitle[row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:{
            UserInfoController *vc = [[UserInfoController alloc] init];
            vc.isSelf = YES;
            PushVC(vc);
        }break;
        case 2:{
            PushVCWithClassName(@"MyLikeController");
        }break;
        case 3: PushVCWithClassName(@"AttentionTabBarController"); break;
        case 4: {
            if (IsInstallWX) {
               [ShareView share];
            }else{
                PushVCWithClassName(@"SettingController");
            }
        } break;
        case 5: PushVCWithClassName(@"SettingController"); break;

        default:
            break;
    }
}

- (NSArray *)arrImg{
    if (!_arrImg) {
        if (!IsInstallWX) {
            _arrImg = @[@"", @"mine_dynamic", @"mine_like", @"mine_attention", @"mine_set"];
        }else{
            _arrImg = @[@"", @"mine_dynamic", @"mine_like", @"mine_attention", @"mine_share", @"mine_set"];
        }
    }
    return _arrImg;
}

- (NSArray *)arrTitle{
    if (!_arrTitle) {
        if (IsInstallWX) {
            _arrTitle = @[@"", @"我的主页", @"我的喜欢", @"我的关注", @"分享游兔", @"设置"];
        }else{
            _arrTitle = @[@"", @"我的主页", @"我的喜欢", @"我的关注", @"设置"];
        }
    }
    return _arrTitle;
}
@end
