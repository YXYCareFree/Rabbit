//
//  SelectCityController.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SelectCityController.h"
#import "CountryListView.h"
#import "SelectCityInteractor.h"

@interface SelectCityController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) CountryListView *listView;
@property (nonatomic, strong) SelectCityInteractor *interactor;

@end

@implementation SelectCityController

- (instancetype)initWithSelectCityBlock:(void (^)(NSString * _Nonnull, NSString * _Nonnull))block{
    if (self = [super init]) {
        self.SelectCityBlock = block;
        [self setUI];
        [self.interactor loadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setUI{
    self.lblTitle.title(@"切换城市");
    self.vNavBar.backgroundColor = WhiteColor;
    Self_View.backgroundColor = Color_E;
    
    [self.view addSubview:self.btnSearch];
    [self.btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.vNavBar.mas_bottom).offset(15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@33);
    }];
    
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.width.equalTo(@86);
        make.top.equalTo(self.btnSearch.mas_bottom).offset(15);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.listView.dataSource = @[@"推荐", @"中国"];
        });
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
        make.top.equalTo(self.btnSearch.mas_bottom).offset(15);
        make.left.equalTo(self.listView.mas_right);
    }];
    
    [self.view addSubview:self.recommendCollectionV];
    [self.recommendCollectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@0);
        make.top.equalTo(self.btnSearch.mas_bottom).offset(15);
        make.left.equalTo(self.listView.mas_right);
    }];
}

- (void (^)(NSString * _Nonnull, NSString * _Nonnull))SearchCityBlock{
    return ^(NSString *code, NSString *city){
        if (self.SelectCityBlock) {
            self.SelectCityBlock(code, city);
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
}

- (UIButton *)btnSearch{
    if (!_btnSearch) {
        UIButton *search = UIButton.new;
        search.backgroundColor = WhiteColor;
        [search setCornerRadius:5];
        [search addTarget:self.interactor action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];

        UIButton *seac = UIButton.new;
        [seac setImage:LoadImageWithName(@"search") forState:UIControlStateNormal];
        seac.adjustsImageWhenHighlighted = NO;
        [seac addTarget:self.interactor action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];
        [search addSubview:seac];
        [seac mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(search);
        }];
        _btnSearch = search;
    }
    return _btnSearch;
}

- (CountryListView *)listView{
    if (!_listView) {
        WEAKSELF;
        _listView = [[CountryListView alloc] init];
        _listView.ListSelectedBlock = ^(NSInteger idx) {
            [weakSelf.interactor selectCategory:idx];
        };
    }
    return _listView;
}

- (UICollectionView *)recommendCollectionV{
    if (!_recommendCollectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 15;
        layout.itemSize = CGSizeMake((kScreenWidth - 70 - 86) / 3, 25);
        layout.sectionInset = UIEdgeInsetsMake(15, 20, 15, 20);
        layout.headerReferenceSize = CGSizeMake(10, 40);
        _recommendCollectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _recommendCollectionV.backgroundColor = WhiteColor;
        [_recommendCollectionV registerNib:[UINib nibWithNibName:@"CityListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CityListCollectionViewCellID"];
        [_recommendCollectionV registerNib:[UINib nibWithNibName:@"CityHotCell" bundle:nil] forCellWithReuseIdentifier:@"CityHotCellID"];
        [_recommendCollectionV registerClass:[SelectCityHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SelectCityHeaderViewID"];
        _recommendCollectionV.delegate = self.interactor;
        _recommendCollectionV.dataSource = self.interactor;
//        layout.dele
    }
    return _recommendCollectionV;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 15;
        layout.itemSize = CGSizeMake((kScreenWidth - 70 - 86) / 3, 25);
        layout.sectionInset = UIEdgeInsetsMake(15, 20, 15, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = WhiteColor;
        [_collectionView registerNib:[UINib nibWithNibName:@"CityListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CityListCollectionViewCellID"];
        _collectionView.delegate = self.interactor;
        _collectionView.dataSource = self.interactor;
    }
    return _collectionView;
}

- (SelectCityInteractor *)interactor{
    if (!_interactor) {
        _interactor = SelectCityInteractor.new;
        _interactor.vc = self;
    }
    return _interactor;
}
@end
