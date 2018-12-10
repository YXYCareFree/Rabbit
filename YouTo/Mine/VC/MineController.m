//
//  MineController.m
//  YouTo
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MineController.h"
#import "MineInteractor.h"

@interface MineController ()


@property (nonatomic, strong) MineInteractor *interactor;

@end

@implementation MineController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI{
    self.vBackHidden = YES;
    self.vNavBar.hidden = YES;
    self.tableView.bounces = NO;
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    [self.tableView registerNib:[UINib nibWithNibName:@"MineHeaderCell" bundle:nil] forCellReuseIdentifier:@"MineHeaderCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:@"MineCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (MineInteractor *)interactor{
    if (!_interactor) {
        _interactor = MineInteractor.new;
    }
    return _interactor;
}

@end
