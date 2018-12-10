//
//  JoinGroupDetailController.m
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "JoinGroupDetailController.h"
#import "NotifiAdapter.h"
#import "NotifiJoinGroupModel.h"
#import "ApplyJoinGroupController.h"

@interface JoinGroupDetailController ()

@property (nonatomic, strong) NotifiJoinGroupModel *model;

@end

@implementation JoinGroupDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NotifiAdapter getJoinGroupDetail:self.sourceId completion:^(BOOL success, id response) {
        if (success) {
            self.model = response;
            [self refreshUI];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    self.lblTitle.text = @"申请详情";
    [self.imgV setCornerRadius:27];
    self.imgV.contentMode = UIViewContentModeScaleAspectFill;
    self.btnRefuse.layer.borderColor = Color_Main.CGColor;
    self.btnRefuse.layer.borderWidth = 1;
    self.btnAccept.backgroundColor = Color_Main;
    [self.btnAccept setCornerRadius:20];
    [self.btnRefuse setCornerRadius:20];
}

//- (void)setSourceId:(NSString *)sourceId{
//    _sourceId = sourceId;
//    [NotifiAdapter getJoinGroupDetail:sourceId completion:^(BOOL success, id response) {
//        if (success) {
//            self.model = response;
//            [self refreshUI];
//        }
//    }];
//}

- (void)refreshUI{
    [self.imgV sd_setImageWithURL:URLWithStr(self.model.faceUrl) placeholderImage:PlaceHolderImage];
    self.lblName.text = self.model.nickName;
    self.lblGroupName.text = self.model.groupName;
    self.lblTime.text = self.model.showTime;
    self.lblReason.text = self.model.checkInfo;
    self.lblAddress.text = self.model.currentLiveAddress;
    if ([self.model.sex isEqualToString:@"男"]) {
        self.imgVSex.image = LoadImageWithName(@"man");
    }else{
        self.imgVSex.image = LoadImageWithName(@"woman");
    }
}

- (IBAction)refuseClicked:(id)sender {
    ApplyJoinGroupController *vc = [ApplyJoinGroupController new];
    vc.type = ApplyJoinGroupControllerTypeRefuse;
    vc.BtnClickedBlock = ^(NSString * _Nonnull str) {
        [NotifiAdapter checkJoinGroup:self.model.sourceId status:NO refuse:str completion:^(BOOL success, id response) {
            if (success) {
                [MBProgressHUD showText:@"拒绝成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    };
    PushVC(vc);
}

- (IBAction)acceptClicked:(id)sender {
    [NotifiAdapter checkJoinGroup:self.model.sourceId status:YES refuse:nil completion:^(BOOL success, id response) {
        if (success) {
            [MBProgressHUD showText:@"同意成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
