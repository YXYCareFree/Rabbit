//
//  MatchController.m
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MatchController.h"
#import "YXYGCDTimer.h"
#import "MatchInteractor.h"

@interface MatchController ()

@property (nonatomic, strong) YXYGCDTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) YXYLabel *lblSearch;
@property (nonatomic, strong) UIImageView *imgVBg;
@property (nonatomic, strong) YXYButton *btnCancel;

@property (nonatomic, strong) MatchInteractor *interactor;
@property (nonatomic, assign) BOOL requestSucc;
@property (nonatomic, assign) BOOL isSkip;

@end

@implementation MatchController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setMatchingUI];
}

- (void)setMatchingUI{
    self.vBackHidden = YES;

    UIImageView *imgVBg = [UIImageView new];
    imgVBg.image = LoadImageWithName(@"home_match_bg");
    [Self_View addSubview:imgVBg];
    [imgVBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Self_View);
    }];
    self.imgVBg = imgVBg;
    
    YXYButton *btnCancel = YXYButton.new;
    [btnCancel setCornerRadius:22];
    self.btnCancel = btnCancel;
    btnCancel.title(@"取消匹配", UIControlStateNormal).titleFont(Font_PingFang_Medium(15)).color(UIColor.whiteColor, UIControlStateNormal);
    btnCancel.layer.borderWidth = 1;
    btnCancel.layer.borderColor = ColorWithHex(@"#54dada").CGColor;
    [btnCancel addTarget:self action:@selector(cancelMatchClicked) forControlEvents:UIControlEventTouchUpInside];
    [Self_View addSubview:btnCancel];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(Self_View);
        make.height.equalTo(@44);
        make.width.equalTo(@140);
        make.bottom.equalTo(@(-TAB_BAR_HEIGHT - 30));
    }];
    
    YXYLabel *lbl = YXYLabel.new;
    self.lblSearch = lbl;
    lbl.titleFont(Font(16)).color(UIColor.whiteColor).title(@"原来你也在这里.");
    [Self_View addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(Self_View);
        make.top.equalTo(@(NAVIGATION_BAR_HEIGHT + 20));
    }];
    
    self.timer = [YXYGCDTimer initWithSelector:@selector(animationSearch) target:self timeInterval:0.8];
    self.refreshDelegate = self.interactor;

    
    [self.refreshDelegate YXYVC_PullDownRefreshCompletion:^(BOOL success) {
        self.requestSucc = YES;
        if (self.isSkip && self.requestSucc) {
            [self setMatchedUI];
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isSkip = YES;
        if (self.isSkip && self.requestSucc) {
            [self setMatchedUI];
        }
    });
}

- (void)animationSearch{
    self.count++;
    NSString *str = @"";
    for (int i = 0; i < self.count; i++) {
        str = [str stringByAppendingString:@"."];
    }
    self.lblSearch.title([@"原来你也在这里" stringByAppendingString:str]);
   
    if (self.count > 4)  self.count = 0;
}

- (void)setMatchedUI{
    self.vBackHidden = NO;
    self.lblTitle.title(@"灵魂匹配");
    [self.imgVBg removeFromSuperview];
    [self.lblSearch removeFromSuperview];
    [self.btnCancel removeFromSuperview];
    
    UIView *vHead = [self createHeadView];
    [Self_View addSubview:vHead];
    [vHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom).offset(15);
        make.left.right.equalTo(Self_View);
        make.height.equalTo(@30);
    }];
    
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.tableView.estimatedRowHeight = 300;
    self.tableView.sectionHeaderHeight = 12;
    [self.tableView registerNib:[UINib nibWithNibName:@"MatchUserCell" bundle:nil] forCellReuseIdentifier:@"MatchUserCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MatchGroupCell" bundle:nil] forCellReuseIdentifier:@"MatchGroupCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vHead.mas_bottom);
        make.left.right.bottom.equalTo(Self_View);
    }];
}

- (UIView *)createHeadView{
    UIView *v = UIView.new;
    
    YXYButton *btnUser = [self btnCategory];
    btnUser.title(@"用户", UIControlStateNormal).titleFont(Font_PingFang_Bold(18));
    [btnUser addTarget:self.interactor action:@selector(btnUserClicked:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btnUser];
    self.btnUser = btnUser;
    [btnUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v);
        make.left.equalTo(@15);
    }];
    
    self.vIndicate = UIView.new;
    self.vIndicate.backgroundColor = Color_Main;
    [self.vIndicate setCornerRadius:2];
    [v addSubview:self.vIndicate];
    [self.vIndicate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnUser);
        make.top.equalTo(btnUser.mas_bottom).offset(2);
        make.width.equalTo(@24);
        make.height.equalTo(@4);
        make.bottom.equalTo(@(-2));
    }];
    
    YXYButton *btnGroup = [self btnCategory];
    btnGroup.title(@"群组", UIControlStateNormal).titleFont(Font(14));
    [btnGroup addTarget:self.interactor action:@selector(btnGroupClicked:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btnGroup];
    self.btnGroup = btnGroup;
    [btnGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(v);
        make.left.equalTo(btnUser.mas_right).offset(30);
    }];
    
    self.btnFilter = YXYButton.new;
    self.btnFilter.setImgae(LoadImageWithName(@"match_filter"), UIControlStateNormal);
    [self.btnFilter addTarget:self.interactor action:@selector(btnFilterClicked) forControlEvents:UIControlEventTouchUpInside];
    self.btnFilter.adjustsImageWhenHighlighted = NO;
    [v addSubview:self.btnFilter];
    [self.btnFilter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.centerY.equalTo(v);
        make.top.bottom.equalTo(v);
        make.width.equalTo(@44);
    }];
    return v;
}

- (YXYButton *)btnCategory{
    YXYButton *btn = YXYButton.new;
    btn.titleFont(Font_PingFang_Bold(18)).color(Color_3, UIControlStateNormal);
    return btn;
}

- (void)cancelMatchClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (MatchInteractor *)interactor{
    if (!_interactor) {
        _interactor = MatchInteractor.new;
        _interactor.vc = self;
        _interactor.pageNum = @"1";
    }
    return _interactor;
}
@end
