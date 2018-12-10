//
//  ChatController.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ChatController.h"
#import "SettingChatUserInfoController.h"
#import "AccountManager.h"
#import "GroupSettingController.h"
#import "UserInfoController.h"

@interface ChatController ()

@property (nonatomic, strong) NSString *memberId;

@end

@implementation ChatController

- (id)initWithConversationType:(RCConversationType)conversationType targetId:(NSString *)targetId{
    if (self = [super initWithConversationType:conversationType targetId:targetId]) {
        self.memberId = targetId;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    if (self.conversationType == ConversationType_PRIVATE) {
        [AccountManager getRemarkName:self.memberId completion:^(BOOL success, id response) {
            if (success) {
                self.title = [response valueForKey:@"remark"];
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    
    YXYButton *btn = [[YXYButton alloc] init];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:LoadImageWithName(@"back_gray") forState:UIControlStateNormal];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
    YXYButton *set = [[YXYButton alloc] init];
    [set addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    [set setImage:LoadImageWithName(@"mood_setting") forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:set];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)set{
    if (self.conversationType == ConversationType_PRIVATE) {
        SettingChatUserInfoController *vc = [[SettingChatUserInfoController alloc] initWithMemberId:self.memberId remarkName:self.title];
        PushVC(vc);
    }else{
        GroupSettingController *vc = [[GroupSettingController alloc] init];
        vc.groupId = self.targetId;
        PushVC(vc);
    }
}

- (void)didTapCellPortrait:(NSString *)userId{
    UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:userId];
    PushVC(vc);
}

//- (void)presentLocationViewController:(RCLocationMessage *)locationMessageContent{
//    
//}
//

@end
