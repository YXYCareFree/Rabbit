//
//  UserInfoController.m
//  YouTo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UserInfoController.h"
#import "UserInfoInteractor.h"
#import "AccountManager.h"

@interface UserInfoController ()

@property (nonatomic, strong) UserInfoInteractor *interactor;
@property (nonatomic, strong) UIView *btnAttention;
@property (nonatomic, strong) UIView *btnChat;

@end

@implementation UserInfoController

- (instancetype)initWithMemberId:(NSString *)memberId{
    if (self = [super init]) {
        self.memberId = memberId;
        self.isSelf = [[AccountManager memberId] isEqualToString:self.memberId];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    [self.interactor loadData];
}

- (void)setUI{
    self.lblTitle.title(@"用户信息").color(UIColor.whiteColor).titleFont(Font_PingFang_Medium(18));
    self.colorBack = UIColor.whiteColor;
    
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[UserInfoCell class] forCellReuseIdentifier:@"UserInfoCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserDynamicCell" bundle:nil] forCellReuseIdentifier:@"UserDynamicCellID"];
    
    if (!self.isSelf) {
        [Self_View addSubview:self.btnAttention];
        [Self_View addSubview:self.btnChat];
        [self.btnChat mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-34));
            make.bottom.equalTo(@(-HOME_INDICATOR_HEIGHT - 20));
            make.height.equalTo(@40);
            make.width.equalTo(@120);
        }];
        [self.btnAttention mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@34);
            make.bottom.equalTo(@(-HOME_INDICATOR_HEIGHT - 20));
            make.height.equalTo(@40);
            make.width.equalTo(@120);
        }];
    }else{
        YXYButton *btnEdit = [[YXYButton alloc] init];
        [btnEdit setImage:LoadImageWithName(@"mine_edit") forState:UIControlStateNormal];
        [btnEdit addTarget:self action:@selector(btnEditClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.vNavBar addSubview:btnEdit];
        [btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.centerY.equalTo(self.lblTitle);
            make.right.equalTo(@(-15));
        }];
    }
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(@0);
//        if (self.isSelf) {
//            make.bottom.equalTo(@0);
//        }else{
//            make.bottom.equalTo(self.btnAttention.mas_top);
//        }
    }];
}

- (void)btnEditClicked{
    PushVCWithClassName(@"EditUserInfoController");
}

- (UIView *)createBottomViewWithTarget:(id)target selector:(SEL)sel imagView:(UIImageView *)imgV label:(YXYLabel *)lbl{
    UIView *view = UIView.new;
    view.backgroundColor = Color_Main;
    [view setCornerRadius:20];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    [view addGestureRecognizer:tap];
    
    [view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerY.equalTo(view);
    }];
    
    lbl.titleFont(Font_PingFang_Medium(18)).color(WhiteColor);
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right).offset(5);
        make.centerY.equalTo(view);
    }];
    return view;
}

- (UserInfoInteractor *)interactor{
    if (!_interactor) {
        _interactor = [UserInfoInteractor new];
        _interactor.vc = self;
        _interactor.pageNum = @"1";
    }
    return _interactor;
}

- (UIView *)btnAttention{
    if (!_btnAttention) {
        self.imgVAttention = [[UIImageView alloc] initWithImage:LoadImageWithName(@"attention")];
        self.lblAttention = YXYLabel.new;
        self.lblAttention.title(@"关注");
        _btnAttention = [self createBottomViewWithTarget:self.interactor selector:@selector(atttionClicked) imagView:self.imgVAttention label:self.lblAttention];
    }
    return _btnAttention;
}

- (UIView *)btnChat{
    if (!_btnChat) {
        YXYLabel *lbl = YXYLabel.new;
        lbl.title(@"私聊");
        _btnChat = [self createBottomViewWithTarget:self.interactor selector:@selector(chatClicked) imagView:[[UIImageView alloc] initWithImage:LoadImageWithName(@"chat")] label:lbl];
    }
    return _btnChat;
}
@end
