//
//  MoodDetailController.m
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MoodDetailController.h"
#import "MoodDetailInteractor.h"

@interface MoodDetailController ()

@property (nonatomic, strong) MoodDetailInteractor *interactor;

@property (nonatomic, strong) UIView *btnAttention;
@property (nonatomic, strong) UIView *btnChat;

@end

@implementation MoodDetailController

- (instancetype)initWithType:(CityContentType)type moodId:(NSString *)moodId isSelf:(BOOL)isSelf{
    if (self = [super init]) {
        self.type = type;
        self.moodId = moodId;
        self.isSelf = isSelf;
        [self setUI];
        [self.interactor loadData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setUI{
    [self.view addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.right.equalTo(@0);
    }];
    
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoodDetailHeaderCell" bundle:nil] forCellReuseIdentifier:@"MoodDetailHeaderCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.inputField.mas_top);
    }];
    
    if (self.isSelf){
        YXYButton *btn = YXYButton.new;
        btn.bgImgae(LoadImageWithName(@"mood_setting"), UIControlStateNormal);
        [btn addTarget:self.interactor action:@selector(btnSettingClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.vNavBar addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lblTitle);
            make.right.equalTo(@(-15));
        }];
    }else{
    
//        [Self_View addSubview:self.btnAttention];
//        [Self_View addSubview:self.btnChat];
//        [self.btnChat mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@(-34));
//            make.bottom.equalTo(@(-HOME_INDICATOR_HEIGHT - 20));
//            make.height.equalTo(@40);
//            make.width.equalTo(@120);
//        }];
//        [self.btnAttention mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@34);
//            make.bottom.equalTo(@(-HOME_INDICATOR_HEIGHT - 20));
//            make.height.equalTo(@40);
//            make.width.equalTo(@120);
//        }];
//        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.vNavBar.mas_bottom);
//            make.left.right.equalTo(@0);
//            make.bottom.equalTo(self.btnAttention.mas_top);
//        }];
    }
}

- (void)setType:(CityContentType)type{
    _type = type;
    if (type == CityContentTypeHelp) {
        self.lblTitle.title(@"求助详情");
    }else if (type == CityContentTypeMood){
        self.lblTitle.title(@"心情详情");
    }else{
        self.lblTitle.title(@"资讯详情");
    }
}

- (UIView *)createBottomViewWithTarget:(id)target selector:(SEL)sel imagView:(UIImageView *)imgV label:(YXYLabel *)lbl{
    UIView *view = UIView.new;
    view.backgroundColor = Color_Main;
    [view setCornerRadius:20];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    [view addGestureRecognizer:tap];
    
    [view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerY.equalTo(view);
    }];
    
    lbl.titleFont(Font_PingFang_Medium(18)).color(WhiteColor);
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right).offset(5);
        make.centerY.equalTo(view);
    }];
    return view;
}

- (UIView *)btnAttention{
    if (!_btnAttention) {
        self.imgVAttention = [[UIImageView alloc] initWithImage:LoadImageWithName(@"attention")];
        self.lblAttention = YXYLabel.new;
        self.lblAttention.title(@"关注");
        _btnAttention = [self createBottomViewWithTarget:self.interactor selector:@selector(atttionClicked) imagView:self.imgVAttention label:self.lblAttention];
    }
    return _btnAttention;
}

- (UIView *)btnChat{
    if (!_btnChat) {
        YXYLabel *lbl = YXYLabel.new;
        lbl.title(@"私聊");
        _btnChat = [self createBottomViewWithTarget:self.interactor selector:@selector(chatClicked) imagView:[[UIImageView alloc] initWithImage:LoadImageWithName(@"chat")] label:lbl];
    }
    return _btnChat;
}

- (InputField *)inputField{
    if (!_inputField) {
        _inputField = [[InputField alloc] initWithType:InputFieldTypeComment delegate:self.interactor];
//        _inputField.hidden = YES;
    }
    return _inputField;
}

- (MoodDetailInteractor *)interactor{
    if (!_interactor) {
        _interactor = MoodDetailInteractor.new;
        _interactor.vc = self;
    }
    return _interactor;
}
@end
