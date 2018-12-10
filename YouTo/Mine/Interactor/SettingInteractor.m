//
//  SettingInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SettingInteractor.h"
#import "MineCell.h"
#import "ApplyJoinGroupController.h"

@implementation SettingInteractor

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCellID" forIndexPath:indexPath];
    NSString *str = @"";
    switch (row) {
        case 0: str = @"版本信息"; break;
        case 1: str = @"黑名单"; break;
        case 2: str = @"用户反馈"; break;
        default:
            break;
    }
    cell.imgVLeftConstraint.constant = -2;
    cell.lblTitle.text = str;
    if (row == 0) {
        cell.lblSubTitle.text = [@"游兔" stringByAppendingString: [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:
            PushVCWithClassName(@"BlackListController");
            break;
        case 2:{
            ApplyJoinGroupController *vc = ApplyJoinGroupController.new;
            vc.type = ApplyJoinGroupControllerTypeFeedback;
            PushVC(vc);
        } break;
        default:
            break;
    }
}
@end
