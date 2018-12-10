//
//  NotifiInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NotifiInteractor.h"
#import "MessageCell.h"
#import "NotifiAdapter.h"
#import "NotifiJoinGroupModel.h"
#import "NSObject+YYModel.h"
#import "JoinGroupDetailController.h"
#import "NotifiModel.h"
#import "NotifiDynamicModel.h"
#import "AccountManager.h"

#import "UserInfoController.h"
#import "MoodDetailController.h"
#import "CommentDetailController.h"

@interface NotifiInteractor ()

@property (nonatomic, strong)  NSArray *arrImage;
@property (nonatomic, strong)  NSArray *arrTitle;

@end

@implementation NotifiInteractor

- (void)loadData{
    if (SelfVC.type == NotifiControllerTypeAll) {
        [NotifiAdapter getAllNotifi:^(BOOL success, id response) {
            if (success) {
                self.dataSource = [NSMutableArray arrayWithArray:response];
                [SelfVC.tableView reloadData];
            }
        }];
        return;
    }
    NSString *type;
    switch (SelfVC.type) {
        case NotifiControllerTypeGroup:
            type = @"appGroupMessage_joinGroup";
            break;
        case NotifiControllerTypeDynamic:
            type = @"appDynamicMessage_beConcern";
            break;
        case NotifiControllerTypeOfficial:
            type = @"appOfficialMessage";
            break;
        default:
            break;
    }
    
    if (type) {
        [NotifiAdapter getAllNotifiByType:type completion:^(BOOL success, id response) {
            if (success) {
                switch (SelfVC.type) {
                    case NotifiControllerTypeGroup: self.dataSource = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[NotifiJoinGroupModel class] json:response]]; break;
                    case NotifiControllerTypeDynamic: self.dataSource = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[NotifiDynamicModel class] json:response]]; break;
                    case NotifiControllerTypeOfficial: self.dataSource = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[NotifiJoinGroupModel class] json:response]]; break;
                    default:
                        break;
                }
                [SelfVC.tableView reloadData];
            }
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCellID" forIndexPath:indexPath];
    switch (SelfVC.type) {
        case NotifiControllerTypeAll:{
            cell.imgVIcon.image = LoadImageWithName(self.arrImage[indexPath.row]);
            cell.lblTitle.text = self.arrTitle[indexPath.row];
            NotifiModel *model = self.dataSource[indexPath.row];
            cell.lblTime.text = model.showTime;
            cell.lblDetail.text = model.message;
        } break;
        case NotifiControllerTypeGroup:{
            NotifiJoinGroupModel *model = self.dataSource[indexPath.row];
            [cell.imgVIcon sd_setImageWithURL:URLWithStr(model.faceUrl) placeholderImage:PlaceHolderImage];
            cell.lblTime.text = model.showTime;
            cell.lblTitle.text = model.nickName;
            cell.lblDetail.text = model.info;
            cell.UserIconClickedBlock = ^{
                UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:model.memberId];
                PushVC(vc);
            };
        }break;
        case NotifiControllerTypeDynamic:{
            NotifiDynamicModel *model = self.dataSource[indexPath.row];
            [cell.imgVIcon sd_setImageWithURL:URLWithStr(model.faceUrl) placeholderImage:PlaceHolderImage];
            cell.lblTime.text = model.showTime;
            cell.lblTitle.text = model.nickName;
            cell.lblDetail.text = model.info;
            cell.UserIconClickedBlock = ^{
                UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:model.memberId];
                PushVC(vc);
            };
        }break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (SelfVC.type == NotifiControllerTypeAll) {
        NotifiController *vc = [[NotifiController alloc] init];
        NotifiControllerType type = NotifiControllerTypeOfficial;
        switch (indexPath.row) {
            case 0: type = NotifiControllerTypeOfficial; break;
            case 1: type = NotifiControllerTypeDynamic; break;
            case 2: type = NotifiControllerTypeGroup; break;
            default: break;
        }
        vc.type = type;
        PushVC(vc);
        return;
    }

    if (SelfVC.type == NotifiControllerTypeGroup) {
        NotifiJoinGroupModel *model = self.dataSource[indexPath.row];
        if (!model.isSkip) return;
        JoinGroupDetailController *vc = [[JoinGroupDetailController alloc] init];
        vc.sourceId = model.sourceId;
        PushVC(vc);
        return;
    }
    
    if (SelfVC.type == NotifiControllerTypeDynamic) {
        NotifiDynamicModel *model = self.dataSource[indexPath.row];
        
        if ([model.type isEqualToString:@"appDynamicMessage_beConcern"]) {
            UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:model.memberId];
            PushVC(vc);
            return;
        }
        
        if ([model.type hasPrefix:@"appDynamicMessage_mood"] || [model.type hasPrefix:@"appDynamicMessage_seek"] || [model.type hasPrefix:@"appDynamicMessage_goodAnswer"]) {
            CityContentType type = CityContentTypeMood;
            if ([model.type hasPrefix:@"appDynamicMessage_mood"]) {
                type = CityContentTypeMood;
            }
            if ([model.type hasPrefix:@"appDynamicMessage_seek"] || [model.type hasPrefix:@"appDynamicMessage_goodAnswer"]) {
                type = CityContentTypeHelp;
            }
            
            MoodDetailController *vc = [[MoodDetailController alloc] initWithType:type moodId:model.sourceId isSelf:[[AccountManager memberId] isEqualToString:model.memberId]];
            PushVC(vc);
            return;
        }

        if ([model.type hasPrefix:@"appDynamicMessage_moodAnswerDetail"] || [model.type hasPrefix:@"appDynamicMessage_seekAnswerDetail"] || [model.type hasPrefix:@"appDynamicMessage_seekAnswerDetailLike"]) {
            CityContentType type = CityContentTypeMood;
            if ([model.type hasPrefix:@"appDynamicMessage_moodAnswerDetail"]) {
                type = CityContentTypeMood;
            }
            if ([model.type hasPrefix:@"appDynamicMessage_seekAnswerDetail"] || [model.type hasPrefix:@"appDynamicMessage_seekAnswerDetailLike"]) {
                type = CityContentTypeHelp;
            }
           
            CommentDetailController * vc = [[CommentDetailController alloc] initWithCommentId:model.sourceId type:type];
            PushVC(vc);
            return;
        }
        
    }
}

- (NSArray *)arrImage{
    return @[@"notifi_official", @"notifi_dynamic", @"notifi_group"];
}

- (NSArray *)arrTitle{
    return @[@"游兔官方", @"动态通知", @"群通知"];
}
@end
