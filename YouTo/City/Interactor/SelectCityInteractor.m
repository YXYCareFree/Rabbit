//
//  SelectCityInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SelectCityInteractor.h"
#import "CityListCollectionViewCell.h"
#import "SearchController.h"
#import "SelectCityAdapter.h"
#import "LocationManager.h"
#import "SelectCityModel.h"
#import "NSObject+YYModel.h"
#import "CityHotCell.h"
#import "SearchController.h"

@interface SelectCityInteractor ()

@property (nonatomic, assign) NSInteger type;//0-推荐  1-中国
@property (nonatomic, strong) NSArray *arrAllCity;
@property (nonatomic, strong) NSArray *arrHotCity;
@property (nonatomic, strong) NSArray *arrHistory;

@end

@implementation SelectCityInteractor

- (void)loadData{
    [SelectCityAdapter getCityData:^(BOOL success, id response) {
        if (success) {
            self.arrAllCity = [NSArray yy_modelArrayWithClass:[SelectCityModel class] json:[response objectForKey:@"allCity"]];
            self.arrHotCity = [NSArray yy_modelArrayWithClass:[HotCityModel class] json:[response objectForKey:@"hotCity"]];
//            self.arrHistory = [response valueForKey:@"searchCity"];
            [SelfVC.collectionView reloadData];
            [SelfVC.recommendCollectionV reloadData];
        }
    }];
}

- (void)searchClicked{
    SearchController *vc = [[SearchController alloc] init];
    vc.SelectCityBlock = ^(NSString * _Nonnull code, NSString * _Nonnull city) {
        SelfVC.SelectCityBlock(code, city);
        [SelfVC.navigationController popViewControllerAnimated:YES];
    };
    [SelfVC presentViewController:vc animated:YES completion:nil];
}

- (void)selectCategory:(NSInteger)idx{
    self.type = idx;
    
    if (self.type) {
        [SelfVC.view bringSubviewToFront:SelfVC.collectionView];

    }else{
        [SelfVC.view bringSubviewToFront:SelfVC.recommendCollectionV];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == SelfVC.collectionView) {
        return 1;
    }
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == SelfVC.collectionView) {
        return self.arrAllCity.count;
    }
    switch (section) {
        case 0: return 1; break;
        case 1:{
            if (self.arrHistory.count > 3) {
                return 3;
            }else{
                return self.arrHistory.count;
            }
        } break;
        case 2:{
            return self.arrHotCity.count;
        } break;

        default:
            break;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == SelfVC.collectionView) {
        CityListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CityListCollectionViewCellID" forIndexPath:indexPath];
        SelectCityModel *model = self.arrAllCity[indexPath.item];
        cell.lblTitle.text = model.cityName;
        return cell;
    }
    
    if (indexPath.section == 0) {
        CityListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CityListCollectionViewCellID" forIndexPath:indexPath];
        [LocationManager getCurrentLocation:^(NSString *latitude, NSString *longitude, NSString *adCode, NSString *cityCode, NSString *city) {
            if (city && city.length) {
                cell.lblTitle.text = city;
            }else{
                cell.lblTitle.text = @"暂无信息";
            }
        }];
        return cell;
    }
    
    if (indexPath.section == 1) {
        CityListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CityListCollectionViewCellID" forIndexPath:indexPath];
        cell.lblTitle.text = self.arrHistory[indexPath.item];
        return cell;
    }

    if (indexPath.section == 2) {
        CityHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CityHotCellID" forIndexPath:indexPath];
        HotCityModel *model = self.arrHotCity[indexPath.item];
        [cell.imgV sd_setImageWithURL:URLWithStr(model.headImg) placeholderImage:nil];
        cell.lblTitle.text = model.cityName;
        return cell;
    }
    
    return UICollectionViewCell.new;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == SelfVC.collectionView) {
        SelectCityModel *model = self.arrAllCity[indexPath.item];
        if (SelfVC.SelectCityBlock) {
            SelfVC.SelectCityBlock(model.adcode, model.cityName);
            [SelfVC.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    NSInteger section = indexPath.section;
    if (section == 2) {
        HotCityModel *model = self.arrHotCity[indexPath.item];
        if (SelfVC.SelectCityBlock) {
            SelfVC.SelectCityBlock(model.adcode, model.cityName);
            [SelfVC.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    if (section == 0) {
        [LocationManager getCurrentLocation:^(NSString *latitude, NSString *longitude, NSString *adCode, NSString *cityCode, NSString *city) {
            if (city && city.length) {
                [UserDefaults setObject:city forKey:City];
                [UserDefaults setObject:adCode forKey:Adcode];
                Notifi(ChangeCity, nil, nil);
            }
        }];
    }
    if (section == 1) {
        SearchController *vc = [[SearchController alloc] initWithKeywords:self.arrHistory[indexPath.item]];
        vc.SelectCityBlock = SelfVC.SearchCityBlock;
        [SelfVC presentViewController:vc animated:YES completion:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == SelfVC.collectionView) {
       return CGSizeMake((kScreenWidth - 70 - 86) / 3, 25);
    }
    if (indexPath.section == 2) {
        return CGSizeMake((kScreenWidth - 70 - 86) / 3, 80);
    }
    return CGSizeMake((kScreenWidth - 70 - 86) / 3, 25);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == SelfVC.collectionView) {
        return nil;
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SelectCityHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SelectCityHeaderViewID" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            view.lblTitle.titleFont(Font_PingFang_Medium(14)).color(Color_6).title(@"GPS定位");
            [LocationManager getCurrentLocation:^(NSString *latitude, NSString *longitude, NSString *adCode, NSString *cityCode, NSString *city) {
                if (city && city.length) {
                    view.btnCity.title(city, UIControlStateNormal).color(Color_6, UIControlStateNormal).titleFont(Font(13)).backgroundColor = Color_E;
                    [view.btnCity setCornerRadius:5];
                    view.btnCity.hidden = NO;
                }
            }];
        }else if(indexPath.section == 1){
            view.lblTitle.titleFont(Font_PingFang_Medium(16)).color(Color_3).title(@"最近浏览");
            view.btnCity.hidden = YES;
        }else{
            view.btnCity.hidden = YES;
            view.lblTitle.titleFont(Font_PingFang_Medium(16)).color(Color_3).title(@"热门城市");
        }
        return view;
    }
    return nil;
}



- (NSArray *)arrAllCity{
    if (!_arrAllCity) {
        _arrAllCity = @[];
    }
    return _arrAllCity;
}

- (NSArray *)arrHotCity{
    if (!_arrHotCity) {
        _arrHotCity = @[];
    }
    return _arrHotCity;
}

- (NSArray *)arrHistory{
    return [UserDefaults objectForKey:@"CitySearchHistory"]?:@[];
}
@end
