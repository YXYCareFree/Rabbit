//
//  SettingChatUserInfoController.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SettingChatUserInfoController.h"
#import "SettingChatUserInfoInteractor.h"

@interface SettingChatUserInfoController ()

@property (nonatomic, strong) SettingChatUserInfoInteractor *interactor;

@end

@implementation SettingChatUserInfoController

- (instancetype)initWithMemberId:(NSString *)memberId remarkName:(NSString *)remarkName{
    if (self = [super init]) {
        self.lblTitle.title(remarkName);
        self.memberId = memberId;
        [self setUI];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.interactor getRemarkName:^(NSString * _Nonnull remarkName) {
        self.lblTitle.text = remarkName;
    }];
    [self.interactor loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:@"MineCellID"];
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
}

- (SettingChatUserInfoInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[SettingChatUserInfoInteractor alloc] init];
        _interactor.vc = self;
    }
    return _interactor;
}
@end
