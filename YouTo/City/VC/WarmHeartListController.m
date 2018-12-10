//
//  WarmHeartListController.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WarmHeartListController.h"
#import "WarmHeartListInteractor.h"

@interface WarmHeartListController ()

@property (nonatomic, strong) WarmHeartListInteractor *interactor;

@end

@implementation WarmHeartListController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setUI{
    self.vBackHidden = YES;
    [self.vNavBar removeFromSuperview];
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.refreshDelegate = self.interactor;
    [self.tableView registerNib:[UINib nibWithNibName:@"WarmHeartListCell" bundle:nil] forCellReuseIdentifier:@"WarmHeartListCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (WarmHeartListInteractor *)interactor{
    if (!_interactor) {
        _interactor = WarmHeartListInteractor.new;
        _interactor.vc = self;
        _interactor.pageNum = @"1";
    }
    return _interactor;
}
@end
