//
//  MyLikeController.m
//  YouTo
//
//  Created by apple on 2018/12/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyLikeController.h"
#import "MyLikeInteractor.h"

@interface MyLikeController ()

@property (nonatomic, strong) MyLikeInteractor *interactor;

@end

@implementation MyLikeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    [self.interactor loadData];
}

- (void)setUI{
    self.lblTitle.title(@"我的喜欢");
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoodDetailHeaderCell" bundle:nil] forCellReuseIdentifier:@"MoodDetailHeaderCellID"];
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
}

- (MyLikeInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[MyLikeInteractor alloc] init];
        _interactor.vc = self;
    }
    return _interactor;
}
@end
