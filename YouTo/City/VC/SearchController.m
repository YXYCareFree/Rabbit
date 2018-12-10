//
//  SearchController.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SearchController.h"
#import "SearchInteractor.h"

static NSString *CitySearchHistory = @"CitySearchHistory";

@interface SearchController ()

@property (nonatomic, strong) SearchInteractor *interactor;

@end

@implementation SearchController

- (instancetype)initWithKeywords:(NSString *)keywords{
    if (self = [super init]) {
        [self setUI];
        self.textField.text = keywords;
        [self.interactor searchClicked];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    if (_interactor) return;
    
    self.vBackHidden = YES;
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.tableView.hidden = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil] forCellReuseIdentifier:@"SearchResultCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.vNavBar.mas_bottom);
    }];
    
    [self setSearchHistoryUI];
    
    YXYButton *btnCancel = YXYButton.new;
    btnCancel.titleFont(Font(14)).title(@"取消", UIControlStateNormal).color(Color_3, UIControlStateNormal);
    [btnCancel addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.vNavBar addSubview:btnCancel];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vNavBar);
        make.right.equalTo(@(-15));
        make.width.equalTo(@50);
        make.height.equalTo(@44);
    }];
    
    UIView *search = UIView.new;
    [search setCornerRadius:5];
    search.backgroundColor = Color_E;
    [self.vNavBar addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnCancel);
        make.left.equalTo(@(15));
        make.right.equalTo(btnCancel.mas_left).offset(-15);
        make.height.equalTo(@35);
    }];
    UIButton *seac = UIButton.new;
    [seac setImage:LoadImageWithName(@"search") forState:UIControlStateNormal];
    seac.adjustsImageWhenHighlighted = NO;
    [seac addTarget:self.interactor action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];
    [search addSubview:seac];
    [seac mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(search);
        make.width.equalTo(@20);
    }];
    UITextField *textField = UITextField.new;
    self.textField = textField;
    textField.delegate = self.interactor;
    textField.returnKeyType = UIReturnKeySearch;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索你感兴趣的目的地" attributes:@{NSFontAttributeName: Font(15), NSForegroundColorAttributeName: ColorWithHex(@"999999")}];
    [search addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(seac.mas_right).offset(2);
        make.top.bottom.right.equalTo(@0);
    }];
}

- (void)search{
    [self.interactor searchClicked];
}

- (void)setSearchHistoryUI{

    YXYButton *btnDeleteHistory = YXYButton.new;
    btnDeleteHistory.bgImgae(LoadImageWithName(@"delete"), UIControlStateNormal);
    [btnDeleteHistory addTarget:self action:@selector(deleteHisttoryClicked) forControlEvents:UIControlEventTouchUpInside];
    [Self_View addSubview:btnDeleteHistory];
    [btnDeleteHistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom).equalTo(@20);
        make.right.equalTo(@(-15));
    }];
    YXYLabel *lbl = YXYLabel.new;
    lbl.title(@"历史记录").color(Color_3).titleFont(Font(14));
    [Self_View addSubview:lbl];
    lbl.backgroundColor = WhiteColor;
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(btnDeleteHistory);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbl.mas_bottom).offset(12);
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.bottom.equalTo(@0);
    }];
}

- (void)deleteHisttoryClicked{
    [self.interactor.dataSource removeAllObjects];
    [self.collectionView reloadData];
    [UserDefaults setObject:@[] forKey:CitySearchHistory];
}

- (void)cancelClicked{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 12;
        layout.itemSize = CGSizeMake((kScreenWidth - 70) / 5, 30);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = WhiteColor;
        [_collectionView registerNib:[UINib nibWithNibName:@"CityListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CityListCollectionViewCellID"];
        _collectionView.delegate = self.interactor;
        _collectionView.dataSource = self.interactor;
        _collectionView.backgroundColor = WhiteColor;
    }
    return _collectionView;
}

- (SearchInteractor *)interactor{
    if (!_interactor) {
        _interactor = SearchInteractor.new;
        _interactor.vc = self;
    }
    return _interactor;
}
@end
