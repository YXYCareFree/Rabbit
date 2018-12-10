//
//  BlackListController.m
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BlackListController.h"
#import "BlackListCell.h"
#import "AccountManager.h"

@interface BlackListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BlackListController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    [self loadData];
}

- (void)setUI{
    self.lblTitle.title(@"黑名单");
    
//    self.refreshDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BlackListCell" bundle:nil] forCellReuseIdentifier:@"BlackListCellID"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.bottom.equalTo(Self_View);
    }];
}

- (void)loadData{
    [AccountManager getBlackListPageNum:@"1" completion:^(BOOL success, id response) {
        if (success) {
            self.dataSource = [NSMutableArray arrayWithArray:response];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BlackListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlackListCellID" forIndexPath:indexPath];
    UserModel *model = self.dataSource[indexPath.row];
    [cell.imgVIcon sd_setImageWithURL:URLWithStr(model.headImg) placeholderImage:PlaceHolderImage];
    cell.lblName.text = model.nickName;
    cell.lblDetail.text = [NSString stringWithFormat:@"现居地 %@  出生地 %@", model.currentLiveAddress, model.birthAddress];
    if ([model.sex isEqualToString:@"男"]) {
        cell.imgVSex.image = LoadImageWithName(@"man");
    }else{
        cell.imgVSex.image = LoadImageWithName(@"woman");
    }
    cell.CancelBlackListBlock = ^{
        [AccountManager removeBlackList:model.memberId completion:^(BOOL success, id response) {
            if (success) {
                [MBProgressHUD showText:@"移除成功"];
                [self loadData];
            }
        }];
    };
    return cell;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = NSMutableArray.new;
    }
    return _dataSource;
}

@end
