//
//  MyLikeInteractor.m
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyLikeInteractor.h"
#import "MoodDetailHeaderCell.h"
#import "MyLikeAdapter.h"
#import "AccountManager.h"
#import "MoodDetailController.h"

@implementation MyLikeInteractor

- (void)loadData{
    [MyLikeAdapter getMyLike:^(BOOL success, id response) {
        if (success) {
            self.dataSource = [NSMutableArray arrayWithArray:response];
            [SelfVC.tableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoodDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoodDetailHeaderCellID" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MoodDetailModel *model = self.dataSource[indexPath.row];
    
    CityContentType type = CityContentTypeMood;
    if (model.type) {
        type = CityContentTypeHelp;
    }else{
        type = CityContentTypeMood;
    }
    UserModel *user = [AccountManager getUserInfo];
    MoodDetailController *vc = [[MoodDetailController alloc] initWithType:type moodId:model.ID isSelf:[user.memberId isEqualToString:model.memberId]];
    PushVC(vc);
}

@end
