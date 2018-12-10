//
//  AttentionListController.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AttentionListController.h"
#import "AttentionListInteractor.h"

@interface AttentionListController ()

@property (nonatomic, strong) AttentionListInteractor *interactor;

@end

@implementation AttentionListController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setType:(AttentionListControllerType)type{
    _type = type;
    [self setUI];
}

- (void)setUI{
    self.vBackHidden = YES;
    [self.vNavBar removeFromSuperview];
//    self.refreshDelegate = self.interactor;
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    [self.tableView registerNib:[UINib nibWithNibName:@"AttentionListCell" bundle:nil] forCellReuseIdentifier:@"AttentionListCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.interactor loadData];
}

- (AttentionListInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[AttentionListInteractor alloc] init];
        _interactor.vc = self;
        _interactor.pageNum = @"1";
    }
    return _interactor;
}
@end
