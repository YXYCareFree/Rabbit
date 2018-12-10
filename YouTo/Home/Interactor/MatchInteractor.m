//
//  MatchInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MatchInteractor.h"
#import "MatchAdapter.h"
#import "YXYSelectView.h"
#import "UserInfoController.h"
#import "AccountManager.h"
#import "GroupInfoController.h"

@interface MatchInteractor ()

@property (nonatomic, assign) NSInteger type;//0:展示用户信息， 1：展示群组信息
@property (nonatomic, strong) NSString *filterProperty;

@property (nonatomic, strong) NSMutableArray *userDataSource;
@property (nonatomic, strong) NSMutableArray *groupDataSource;
@property (nonatomic, assign) NSInteger firstLoadGroup;

@end

@implementation MatchInteractor

- (instancetype)init{
    if (self = [super init]) {
        self.type = 0;
        self.firstLoadGroup = 0;
        self.filterProperty = @"";
    }
    return self;
}

- (void)btnUserClicked:(YXYButton *)btn{
    self.type = 0;
    SelfVC.btnFilter.hidden = NO;
    SelfVC.btnGroup.titleFont(Font(14));
    btn.titleFont(Font_PingFang_Bold(18));
    [SelfVC.tableView reloadData];
    
    [SelfVC.vIndicate mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).offset(2);
        make.width.equalTo(@24);
        make.height.equalTo(@4);
        make.bottom.equalTo(@(-2));
    }];
}

- (void)btnGroupClicked:(YXYButton *)btn{
    if (self.firstLoadGroup == 0) {
        [SelfVC.tableView.mj_header beginRefreshing];
    }
    self.firstLoadGroup++;
    self.type = 1;
    SelfVC.btnFilter.hidden = YES;
    SelfVC.btnUser.titleFont(Font(14));
    btn.titleFont(Font_PingFang_Bold(18));
    [SelfVC.tableView reloadData];

    [SelfVC.vIndicate mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).offset(2);
        make.width.equalTo(@24);
        make.height.equalTo(@4);
        make.bottom.equalTo(@(-2));
    }];
}

- (void)btnFilterClicked{
    NSArray *arr = @[@"", @"boy", @"girl", @"离我最近", @"birthAddress"];
    [YXYSelectView initWithDataSource:@[@"全部", @"只看男", @"只看女", @"离我最近", @"同出生地"] confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
        self.filterProperty = arr[idx];
        [self.userDataSource removeAllObjects];
        [SelfVC pullDownRefresh];
    }];
}

- (void)match:(void(^)(BOOL success, id obj))completion{
    if (self.type == 0) {
        [MatchAdapter matchUserPageNum:self.pageNum filterProperty:self.filterProperty orderProperty:@"" completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }else{
        [MatchAdapter matchGroupPageNum:self.pageNum completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }
}

#pragma mark YXYBaseViewControlerRefreshDelegate
- (void)YXYVC_PullDownRefreshCompletion:(void (^)(BOOL))block{
    [self match:^(BOOL success, id obj) {
        if (success) {
            if (self.type == 0) {
                self.userDataSource = [NSMutableArray arrayWithArray:obj];
            }else{
                self.groupDataSource = [NSMutableArray arrayWithArray:obj];
            }
        }
        if (block) {
            block(success);
        }
    }];
}

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void (^)(BOOL))block{
    [self match:^(BOOL success, id obj) {
        if (success) {
            if (![obj isKindOfClass:[NSArray class]] || !((NSArray *)obj).count) {
                if (block) {
                    block(success);
                }
                return ;
            }
            if (self.type == 0) {
                [self.userDataSource addObjectsFromArray:obj];
            }else{
                [self.groupDataSource addObjectsFromArray:obj];
            }
        }
        if (block) {
            block(success);
        }
    }];
}
#pragma mark UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.type) {
        return self.groupDataSource.count;
    }
    return self.userDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        MatchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MatchUserCellID" forIndexPath:indexPath];
        cell.model = self.userDataSource[indexPath.section];
        return cell;
    }else{
        MatchGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MatchGroupCellID" forIndexPath:indexPath];
        cell.model = self.groupDataSource[indexPath.section];
        return cell;
    }

    return UITableViewCell.new;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type) {
        GroupInfoController *vc = [[GroupInfoController alloc] initWithGroupId:nil type:GroupInfoControllerTypeSearch model: self.groupDataSource[indexPath.section]];
        PushVC(vc);
    }else{
        MatchUserModel *model = self.userDataSource[indexPath.section];
        UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:model.memberId];
        vc.userInfoModel = model;
        PushVC(vc)
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.type) {
        return 15;
    }
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        return 171;
    }
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return UIView.new;
}

- (NSMutableArray *)userDataSource{
    if (!_userDataSource) {
        _userDataSource = [NSMutableArray new];
    }
    return _userDataSource;
}

- (NSMutableArray *)groupDataSource{
    if (!_groupDataSource) {
        _groupDataSource = NSMutableArray.new;
    }
    return _groupDataSource;
}
@end
