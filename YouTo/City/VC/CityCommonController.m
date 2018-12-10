//
//  CityCommonController.m
//  YouTo
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityCommonController.h"
#import "CityCommonInteractor.h"

@interface CityCommonController ()

@property (nonatomic, strong) CityCommonInteractor *interactor;
@property (nonatomic, strong) UIView *bannerHeaderView;

@end

@implementation CityCommonController

- (void)dealloc{
    RemoveNotifiObserver(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.vBackHidden = YES;
    [self.vNavBar removeFromSuperview];
    AddNotifiObserver(self, @"changeCityNotifi", ChangeCity, nil);
    AddNotifiObserver(self, @"changeCityScrollNotifi:", CityScroll, nil);
}

- (void)changeCityNotifi{
    [self.interactor loadData];
}

- (void)changeCityScrollNotifi:(NSNotification *)notifi{
    self.tableView.scrollEnabled = [notifi.object boolValue];
}

- (void)setType:(CityContentType)type{
    _type = type;
    if (type == CityContentTypeMood || type == CityContentTypeNews) {
        self.tableView.tableHeaderView = self.bannerHeaderView;
    }
    
    if (type == CityContentTypeHelp) {
        [self.tableView registerNib:[UINib nibWithNibName:@"RankingCell" bundle:nil] forCellReuseIdentifier:@"RankingCellID"];
    }
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.tableView.estimatedRowHeight = 200;
    self.refreshDelegate = self.interactor;
    self.tableView.mj_header = nil;
    [self.tableView registerNib:[UINib nibWithNibName:@"MoodDetailHeaderCell" bundle:nil] forCellReuseIdentifier:@"MoodDetailHeaderCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [self.interactor loadData];
}

- (SDCycleScrollView *)bannerView{
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self.interactor placeholderImage:nil];
    }
    return _bannerView;
}

- (UIView *)bannerHeaderView{
    if (!_bannerHeaderView) {
        _bannerHeaderView = UIView.new;
        [_bannerHeaderView addSubview:self.bannerView];
        [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return _bannerHeaderView;
}

- (CityCommonInteractor *)interactor{
    if (!_interactor) {
        _interactor = CityCommonInteractor.new;
        _interactor.vc = self;
        _interactor.pageNum = @"1";
        _interactor.orignalPageNum = 1;
        _interactor.pn = 1;
    }
    return _interactor;
}
@end
