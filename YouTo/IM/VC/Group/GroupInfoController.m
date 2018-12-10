//
//  GroupInfoController.m
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupInfoController.h"
#import "GroupInfoInteractor.h"
#import "MaskView.h"

@interface GroupInfoController ()

@property (nonatomic, strong) GroupInfoInteractor *interactor;

@end

@implementation GroupInfoController

- (instancetype)initWithGroupId:(NSString *)groupId type:(GroupInfoControllerType)type model:(GroupInfoModel *)model{
    if (self = [super init]) {
        [self setUI];

        self.groupId = groupId;
        self.model = model;
        self.type = type;
        
        [self.interactor loadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setModel:(GroupInfoModel *)model{
    if (!model) return;
    
    _model = model;
    self.sdcView.imageURLStringsGroup = @[self.model.faceUrl];
    self.lblGroupTitle.text = model.name;
    self.lblGroupNum.text = [NSString stringWithFormat:@"(%@)", model.groupId];
}

- (void)setType:(GroupInfoControllerType)type{
    _type = type;
    if (type == GroupInfoControllerTypeSearch) {
        [Self_View addSubview:self.btnJoin];
        [self.btnJoin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-HOME_INDICATOR_HEIGHT - 20));
            make.centerX.equalTo(Self_View);
            make.height.equalTo(@44);
            make.width.equalTo(@160);
        }];
    }
}

- (void)setUI{
    self.colorBack = UIColor.whiteColor;
    self.lblTitle.text = @"群主页";
    self.lblTitle.color(WhiteColor);
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupMemberCell" bundle:nil] forCellReuseIdentifier:@"GroupMemberCellID"];
    [self.tableView registerClass:[GroupTextCell class] forCellReuseIdentifier:@"GroupTextCellID"];
    self.tableView.tableHeaderView = [self createtableHeaderView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Self_View);
    }];
}

- (UIView *)createtableHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 205)];
    [view addSubview:self.sdcView];
    [self.sdcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    MaskView *mask = [[MaskView alloc] initWithFrame:view.bounds];
    [view addSubview:mask];
//    [self.sdcView addSubview:mask];
    
    [view addSubview:self.lblGroupTitle];
    [self.lblGroupTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.bottom.equalTo(@(-17));
    }];
    
    [view addSubview:self.lblGroupNum];
    [self.lblGroupNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblGroupTitle.mas_right).offset(2);
        make.bottom.equalTo(@(-17));
    }];
    
    return view;
}

- (SDCycleScrollView *)sdcView{
    if (!_sdcView) {
        _sdcView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self.interactor placeholderImage:nil];
        _sdcView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _sdcView;
}

- (GroupInfoInteractor *)interactor{
    if (!_interactor) {
        _interactor = GroupInfoInteractor.new;
        _interactor.vc = self;
    }
    return _interactor;
}

- (YXYLabel *)lblGroupTitle{
    if (!_lblGroupTitle) {
        _lblGroupTitle = YXYLabel.new;
        _lblGroupTitle.color(UIColor.whiteColor).titleFont(Font_PingFang_Medium(20));
    }
    return _lblGroupTitle;
}

- (YXYLabel *)lblGroupNum{
    if (!_lblGroupNum) {
        _lblGroupNum = YXYLabel.new;
        _lblGroupNum.color(UIColor.whiteColor).titleFont(Font(12));
    }
    return _lblGroupNum;
}

- (YXYButton *)btnJoin{
    if (!_btnJoin) {
        _btnJoin = YXYButton.new;
        _btnJoin.backgroundColor = Color_Main;
        [_btnJoin setCornerRadius:22];
        _btnJoin.titleFont(Font_PingFang_Medium(18)).color(WhiteColor, UIControlStateNormal).title(@"申请加群", UIControlStateNormal);
        [_btnJoin addTarget:self.interactor action:@selector(btnJoinClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnJoin;
}
@end
