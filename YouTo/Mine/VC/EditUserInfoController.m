//
//  EditUserInfoController.m
//  YouTo
//
//  Created by apple on 2018/11/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "EditUserInfoController.h"
#import "EditUserInfoInteractor.h"

@interface EditUserInfoController ()

@property (nonatomic, strong) EditUserInfoInteractor *interactor;

@end

@implementation EditUserInfoController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    self.lblTitle.title(@"编辑资料");
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    [self.tableView registerNib:[UINib nibWithNibName:@"EditUserInfoCell" bundle:nil] forCellReuseIdentifier:@"EditUserInfoCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
}

- (EditUserInfoInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[EditUserInfoInteractor alloc] init];
    }
    return _interactor;
}
@end
