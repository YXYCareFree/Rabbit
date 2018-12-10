//
//  CityCommonInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityCommonInteractor.h"
#import "RankingCell.h"
#import "MoodDetailHeaderCell.h"
#import "CityCommonAdapter.h"
#import "MoodDetailController.h"
#import "AccountManager.h"

@interface CityCommonInteractor ()

@property (nonatomic, strong) NSArray *dataSourceWarmHeart;

@end

@implementation CityCommonInteractor

- (void)loadData{
    NSString *temp = self.pageNum;
    self.pageNum = [NSString stringWithFormat:@"%ld", self.orignalPageNum];
    [self loadData:^(BOOL success, id  _Nonnull obj) {
        if (success) {
            self.dataSource = [NSMutableArray arrayWithArray:obj];
            [SelfVC.tableView reloadData];
        }else{
            self.pageNum = temp;
        }
    } isRefresh:YES];
}

- (void)loadData:(void (^)(BOOL, id _Nonnull))completion isRefresh:(BOOL)refresh{
    if (SelfVC.type == CityContentTypeHelp) {
        [CityCommonAdapter getCityHelpDataPageNum:self.pageNum completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }
    if (SelfVC.type == CityContentTypeMood) {
        [CityCommonAdapter getCitySquareDataPageNum:self.pageNum completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }
    
    if (SelfVC.type == CityContentTypeNews) {
        [CityCommonAdapter getCityNewsDataPageNum:self.pageNum completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }
    
    if (SelfVC.type == CityContentTypeTypeStrategy) {
        [CityCommonAdapter getCityStrategyDataPageNum:self.pageNum completion:^(BOOL success, id response) {
            if (completion) {
                completion(success, response);
            }
        }];
    }
}

#pragma mark UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MoodDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoodDetailHeaderCellID" forIndexPath:indexPath];
    cell.type = SelfVC.type;
    cell.model = self.dataSource[indexPath.section];
    cell.btnDelete.hidden = YES;
    cell.LikeClickedBlock = ^{
    };
    cell.CommentClickedBlock = ^{
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MoodDetailModel *model = self.dataSource[indexPath.section];

    CityContentType type = CityContentTypeMood;
    if (SelfVC.type == CityContentTypeMood) {
        type = CityContentTypeMood;
    }
    if (SelfVC.type == CityContentTypeHelp) {
        type = CityContentTypeHelp;
    }
    if (SelfVC.type == CityContentTypeNews) {
        type = CityContentTypeHelp;
    }
    UserModel *user = [AccountManager getUserInfo];
    MoodDetailController *vc = [[MoodDetailController alloc] initWithType:type moodId:model.ID isSelf:[user.memberId isEqualToString:model.memberId]];
    vc.DeleteBlock = ^{
        [self.dataSource removeObjectAtIndex:indexPath.section];
        [tableView reloadData];
    };
    PushVC(vc);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= 0) {
        SelfVC.tableView.scrollEnabled = NO;
    }
}

#pragma mark SDCycleScrollViewDelegate
- (UINib *)customCollectionViewCellNibForCycleScrollView:(SDCycleScrollView *)view{
    return [UINib nibWithNibName:@"BannerCollectionViewCell" bundle:nil];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

@end
