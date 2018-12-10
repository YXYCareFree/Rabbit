//
//  GroupListController.m
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupListController.h"
#import "GroupListInteractor.h"

@interface GroupListController ()

@property (nonatomic, strong) GroupListInteractor *interactor;

@end

@implementation GroupListController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.interactor loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    self.lblTitle.title(@"群成员列表");
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupListCell" bundle:nil] forCellReuseIdentifier:@"GroupListCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.bottom.equalTo(Self_View);
    }];
}

- (GroupListInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[GroupListInteractor alloc] init];
        _interactor.vc = self;
    }
    return _interactor;
}

@end
