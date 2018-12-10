//
//  GroupSettingController.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupSettingController.h"
#import "GroupSettingCell.h"
#import "GroupSettingHeadCell.h"
#import "YXYSelectView.h"
#import "GroupAdapter.h"
#import "GroupInfoController.h"
#import "AccountManager.h"
#import "ApplyJoinGroupController.h"

@interface GroupSettingController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) GroupInfoModel *model;

@end

@implementation GroupSettingController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    self.lblTitle.text = @"群设置";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupSettingCell" bundle:nil] forCellReuseIdentifier:@"GroupSettingCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupSettingHeadCell" bundle:nil] forCellReuseIdentifier:@"GroupSettingHeadCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@400);
    }];

    YXYButton *btn = [[YXYButton alloc] init];
    btn.color(WhiteColor, UIControlStateNormal).titleFont(Font_PingFang_Medium(15)).title(@"退出该群", UIControlStateNormal).backgroundColor = UIColor.redColor;
    [btn setCornerRadius:20];
    [btn addTarget:self action:@selector(exitGroupClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom).offset(10);
        make.height.equalTo(@40);
        make.width.equalTo(@145);
    }];
    
    [GroupAdapter getGroupInfo:self.groupId completion:^(BOOL success, id response) {
        if (success) {
            self.model = response;
            if ([self.model.groupMemberId isEqualToString:[AccountManager memberId]]) {
                self.isGroupOwner = YES;
                btn.title(@"解散该群", UIControlStateNormal);
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)exitGroupClicked{
    if ([self.model.groupMemberId isEqualToString:[AccountManager memberId]]) {
        [GroupAdapter deleteGroup:self.model.groupId completion:^(BOOL success, id response) {
            if (success) {
                [MBProgressHUD showText:@"解散群聊成功"];
                Notifi(Delete_Group, self.model.groupId, nil);
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }else{
        [GroupAdapter exitGroup:self.model.groupId completion:^(BOOL success, id response) {
            if (success) {
                [MBProgressHUD showText:@"退出群聊成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GroupSettingHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupSettingHeadCellID" forIndexPath:indexPath];
        [cell.imgV sd_setImageWithURL:URLWithStr(self.model.faceUrl) placeholderImage:cell.imgV.image];
        cell.lblName.text = self.model.name;
        cell.lblDetail.text = self.model.info;
        return cell;
    }
    
    GroupSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupSettingCellID" forIndexPath:indexPath];
    NSString *str = @"群名片";
    switch (indexPath.row) {
        case 0:break;
        case 1: str = @"消息设置"; break;
        default:
            break;
    }
    cell.lblTitle.text = str;
    cell.lblDetail.text = @"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        switch (indexPath.row) {
            case 0:{
                ApplyJoinGroupController *vc = [[ApplyJoinGroupController alloc] init];
                vc.type = ApplyJoinGroupControllerTypeGroupNickName;
                vc.BtnClickedBlock = ^(NSString * _Nonnull str) {
                    [GroupAdapter setGroupRemarkName:str groupId:self.model.groupId completion:^(BOOL success, id response) {
                        if (success) {
                            [MBProgressHUD showText:@"设置成功"];
                        }
                    }];
                };
                PushVC(vc);
            }break;
            case 1:{
                NSArray *arr = @[@"开启", @"接收但不提示", @"关闭"];
                [YXYSelectView initWithDataSource:arr title:@"消息设置" confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
                    GroupSettingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.lblDetail.text = arr[idx];
                }];
            }break;
            default:
                break;
        }
    }else{
        GroupInfoController *vc = [[GroupInfoController alloc] initWithGroupId:nil type:GroupInfoControllerTypeShow model:self.model];
        PushVC(vc);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = Color_E;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 10;
    }
    return 0;
}
@end
