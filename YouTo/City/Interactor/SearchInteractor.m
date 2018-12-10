//
//  SearchInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SearchInteractor.h"
#import "CityListCollectionViewCell.h"
#import "SearchResultCell.h"
#import "SelectCityAdapter.h"
#import "SearchCityModel.h"

@implementation SearchInteractor


- (void)searchClicked{
    NSString *str = SelfVC.textField.text;
    if (str && str.length) {
        [self search:str];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length) {
        [self search:textField.text];
    }
    return YES;
}

- (void)search:(NSString *)keywords{
    [SelectCityAdapter searchKeywords:keywords completion:^(BOOL success, id response) {
        if (success) {
            self.searchResultData = response;
            [self.vc.view bringSubviewToFront:self.vc.tableView];
            [SelfVC.tableView reloadData];
            SelfVC.tableView.hidden = NO;
            
            [self saveHistory:keywords];
        }
    }];
}

- (void)saveHistory:(NSString *)keywords{
    NSArray *arr = [UserDefaults objectForKey:@"CitySearchHistory"];
    if (arr) {
        NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
        if ([marr containsObject:keywords]) {
            return;
        }
        [marr insertObject:keywords atIndex:0];
        if (marr.count == 6) {
            [marr removeObjectAtIndex:4];
        }
        [UserDefaults setObject:marr forKey:@"CitySearchHistory"];
    }else{
        [UserDefaults setObject:@[keywords] forKey:@"CitySearchHistory"];
    }
    if (self.dataSource.count == 5) [self.dataSource removeObjectAtIndex:0];
    [self.dataSource insertObject:keywords atIndex:0];
    [self.vc.collectionView reloadData];
}
#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResultData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCellID" forIndexPath:indexPath];
    SearchCityModel *model = self.searchResultData[indexPath.row];
    cell.lblCity.text = model.cityName;
    cell.lblDetail.text = model.showInfo;
    [cell.imgV sd_setImageWithURL:URLWithStr(model.showHeadImg)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchCityModel *model = self.searchResultData[indexPath.row];
    [SelfVC dismissViewControllerAnimated:YES completion:^{
        SelfVC.SelectCityBlock(model.adCode, model.cityName);
    }];
}
#pragma mark UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CityListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CityListCollectionViewCellID" forIndexPath:indexPath];
    cell.lblTitle.text = self.dataSource[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SelfVC.textField.text = self.dataSource[indexPath.item];
    [self searchClicked];
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:[UserDefaults objectForKey:@"CitySearchHistory"]?:@[]];
    }
    return _dataSource;
}
@end
