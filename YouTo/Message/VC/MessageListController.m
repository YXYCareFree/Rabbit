//
//  MessageListController.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MessageListController.h"
#import "ChatController.h"
#import <RongIMLib/RongIMLib.h>

@interface MessageListController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MessageListController

- (void)viewDidLoad {
    [super viewDidLoad];

    switch ([self.displayConversationTypeArray.firstObject integerValue]) {
        case 1://单聊
            self.dataSource = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]];
            break;
        case 3://群组
            AddNotifiObserver(self, @"deleteGroup:", Delete_Group, nil);
//            self.dataSource = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]];
            break;
        default:
            break;
    }
    
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    [self.emptyConversationView removeFromSuperview];
//    YXYLabel *lbl = [[YXYLabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
//    lbl.title(@"空").color(UIColor.redColor).titleFont(Font_PingFang_Bold(15));
//    self.emptyConversationView = lbl;
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    ChatController *vc = [[ChatController alloc] initWithConversationType:model.conversationType targetId:model.targetId];
    vc.title = model.conversationTitle;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMessageNotification:(NSNotification *)notification{
    [super didReceiveMessageNotification:notification];
}

- (void)deleteGroup:(NSNotification *)notifi{
    NSString *groupId = notifi.object;
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_GROUP targetId:groupId];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}



@end
