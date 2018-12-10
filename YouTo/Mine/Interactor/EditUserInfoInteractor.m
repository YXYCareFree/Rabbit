//
//  EditUserInfoInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "EditUserInfoInteractor.h"
#import "EditUserInfoCell.h"
#import "AccountManager.h"
#import "UIButton+WebCache.h"
#import "YXYSelectView.h"
#import "YXYSelectBirthdaySheet.h"
#import "AccountManager.h"
#import "ApplyJoinGroupController.h"
#import "FillLocationController.h"
#import "YouToSelectPhoto.h"

@implementation EditUserInfoInteractor

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arrLeft = @[@"", @"昵称", @"性别", @"生日", @"个性签名", @"城市信息"];
    UserModel *model = [UserModel getUserModel];
    EditUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditUserInfoCellID" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.btnLeftWidthConstraint.constant = 42;
        [cell.btnLeft sd_setBackgroundImageWithURL:URLWithStr(model.headImg) forState:UIControlStateNormal placeholderImage:PlaceHolderImage];
        cell.lblRight.text = @"更换头像";
        [cell.btnLeft setCornerRadius:21];
    }else{
        [cell.btnLeft setBackgroundImage:nil forState:UIControlStateNormal];
        cell.btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cell.btnLeftWidthConstraint.constant = 100;
        [cell.btnLeft setCornerRadius:0];
        [cell.btnLeft setTitle:arrLeft[indexPath.row] forState:UIControlStateNormal];
        NSString *str = @"";
        switch (indexPath.row) {
            case 1: str = model.nickName; break;
            case 2: str = model.sex; break;
            case 3: str = model.dateOfBirth; break;
            case 4: str = model.personalizedSignature; break;
            default:
                break;
        }

        cell.lblRight.text = str;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditUserInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    switch (indexPath.row) {
        case 0:{
            [YouToSelectPhoto selectPhoto:^(NSString * _Nonnull imgUrlStr) {
                [self updateUserInfo:@{@"headImg": imgUrlStr} completion:^(BOOL success, id response) {
                    [cell.btnLeft sd_setBackgroundImageWithURL:URLWithStr(imgUrlStr) forState:UIControlStateNormal placeholderImage:cell.btnLeft.currentBackgroundImage];
                }];
            }];
        }  break;
        case 1: {
            ApplyJoinGroupController *vc = [[ApplyJoinGroupController alloc] init];
            vc.type = ApplyJoinGroupControllerTypeNickName;
            PushVC(vc);
        } break;
        case 2:{
            [YXYSelectView initWithDataSource:@[@"男", @"女"] confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
                NSString *sex = @"";
                if ([str isEqualToString:@"男"]) {
                    sex = @"boy";
                }else{
                    sex = @"girl";
                }
                [self updateUserInfo:@{@"sex": sex} completion:^(BOOL success, id response) {
                        cell.lblRight.text = str;
                }];
            }];
        }  break;
        case 3:{
            [YXYSelectBirthdaySheet initWithSelectedBirthdayConfirmColor:Color_Main cancelColor:Color_Main completion:^(NSString *birthday) {
                [self updateUserInfo:@{@"dateOfBirth": birthday} completion:^(BOOL success, id response) {
                        cell.lblRight.text = birthday;
                }];
            }];
        }  break;
        case 4:{
            ApplyJoinGroupController *vc = [[ApplyJoinGroupController alloc] init];
            vc.type = ApplyJoinGroupControllerTypeSign;
            PushVC(vc);
        }  break;
        case 5:{
            FillLocationController *vc = [[FillLocationController alloc] init];
            vc.type = FillLocationControllerTypeEdit;
            PushVC(vc);
        }  break;

        default:
            break;
    }
}

- (void)updateUserInfo:(NSDictionary *)dict completion:(YXYCompletionBlock)completion{
    [AccountManager refreshUserInfoWithParams:dict completion:^(UserModel * _Nonnull model) {
        if (completion) {
            completion(YES, nil);
        }
    }];
}
@end
