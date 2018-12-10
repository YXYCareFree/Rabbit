//
//  WarmHeartListInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WarmHeartListInteractor.h"
#import "WarmHeartListCell.h"
#import "WarmHeartListController.h"
#import "CityCommonAdapter.h"
#import "WarmHeartListModel.h"

@interface WarmHeartListInteractor ()

@end

@implementation WarmHeartListInteractor

- (void)loadData:(void (^)(BOOL, id _Nonnull))completion isRefresh:(BOOL)refresh{
    if (self.vc.type == WarmHeartListControllerTypeAllCountry) {
        [CityCommonAdapter getWarmHeartList:self.pageNum adcode:@"0086" completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }
    if (self.vc.type == WarmHeartListControllerTypeCity) {
        [CityCommonAdapter getWarmHeartList:self.pageNum adcode:GetAdcode completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }
    if (self.vc.type == WarmHeartListControllerTypeForegin) {
        [CityCommonAdapter getWarmHeartList:self.pageNum adcode:@"0086" completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WarmHeartListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WarmHeartListCellID" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSString *imageName;
    if (row == 0) {
        imageName = @"first";
    }
    if (row == 1) {
        imageName = @"second";
    }
    if (row == 2) {
        imageName = @"third";
    }
    [cell.imgVRank setImage:nil forState:UIControlStateNormal];
    [cell.imgVRank setTitle:@"" forState:UIControlStateNormal];

    if (imageName) {
        [cell.imgVRank setImage:LoadImageWithName(imageName) forState:UIControlStateNormal];
    }else{
        [cell.imgVRank setTitle:[NSString stringWithFormat:@"%ld", ++row] forState:UIControlStateNormal];
        [cell.imgVRank setTitleColor:Color_6 forState:UIControlStateNormal];
        cell.imgVRank.titleLabel.font = Font_PingFang_Bold(16);
    }
    cell.model = self.dataSource[indexPath.row];
    __weak WarmHeartListCell *weakCell = cell;
    cell.WarmHeartListCellBlock = ^{
        if (weakCell.model.isConcern) {
            [CityCommonAdapter unattention:weakCell.model.memberId completion:^(BOOL success, id response) {
                if (success) {
                    weakCell.model.isConcern = NO;
                    [tableView reloadData];
                }
            }];
        }else{
            [CityCommonAdapter attention:weakCell.model.memberId completion:^(BOOL success, id response) {
                if (success) {
                    weakCell.model.isConcern = YES;
                    [tableView reloadData];
                }
            }];
        }
    };
    return cell;
}

@end
