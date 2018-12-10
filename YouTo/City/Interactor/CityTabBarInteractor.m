//
//  CityTabBarInteractor.m
//  YouTo
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityTabBarInteractor.h"
#import "CityTabBarController.h"

#import "CityCommonAdapter.h"

#import "CityCell.h"

@interface CityTabBarInteractor ()

@property (nonatomic, assign) CGFloat lastOffsetY;//tableView上次的偏移量
@property (nonatomic, assign) BOOL slideUp;

@property (nonatomic, assign) CityContentType type;
@property (nonatomic, strong) NSArray *arrMood;
@property (nonatomic, strong) NSArray *arrHelp;
@property (nonatomic, strong) NSArray *arrNews;
@property (nonatomic, strong) NSArray *arrStrategy;

@end

@implementation CityTabBarInteractor

- (void)loadData:(void (^)(BOOL, id _Nonnull))completion isRefresh:(BOOL)refresh{

    [CityCommonAdapter getCityAbstract:^(BOOL success, id response) {
        completion(success, nil);
        if (success) {
            SelfVC.headerView.model = response;
        }
    }];
    NSLog(@"%@", refresh?@"刷新了":@"加载更多");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CityCell *cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CityCellID" type:self.type];
    cell.ChangeCityContentBlock = ^(CityContentType type) {
        self.type = type;
    };
    cell.dataSource = self.dataSource;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenHeight - TAB_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scr_offsetY = scrollView.contentOffset.y;//上滑为正数
    CGFloat offsetY = self.lastOffsetY - scr_offsetY;//偏移量
    
    self.slideUp = offsetY < 0;
    self.lastOffsetY = scr_offsetY;
    SelfVC.vNavBar.alpha = scr_offsetY / (167 + STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT);
    NSLog(@"%f", scr_offsetY / (167 + STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT));
    if (scr_offsetY / (167 + STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT) >= 1) {
        SelfVC.vNavBar.alpha = 1.0;
        NSLog(@"1.0");
        Notifi(CityScroll, @(YES), nil);
    }
}

@end
