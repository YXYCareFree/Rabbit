//
//  NotifiController.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NotifiController.h"
#import "NotifiInteractor.h"

@interface NotifiController ()

@property (nonatomic, strong) NotifiInteractor *interactor;

@end

@implementation NotifiController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.interactor loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setType:(NotifiControllerType)type{
    _type = type;
    NSString *str = @"通知";
    switch (type) {
        case NotifiControllerTypeAll: str = @"通知";
            break;
        case NotifiControllerTypeGroup: str = @"群通知";
            
            break;
        case NotifiControllerTypeDynamic: str = @"动态通知";
            
            break;
        default:
            break;
    }
    
    self.lblTitle.text = str;
}

- (void)setUI{
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (NotifiInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[NotifiInteractor alloc] init];
        _interactor.vc = self;
    }
    return _interactor;
}

@end
