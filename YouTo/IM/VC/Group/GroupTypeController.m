//
//  GroupTypeController.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupTypeController.h"
#import "GroupTypeCell.h"
#import "ChatController.h"

@interface GroupTypeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YXYLabel *lblCount;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) YXYButton *btnCreate;

@end

@implementation GroupTypeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    self.lblTitle.text = @"群类型";
    self.typeArr = [[NSMutableArray alloc] init];
    self.dataSource = @[@"购物", @"摄影", @"穷游", @"自由行", @"跟团游", @"美食", @"民宿", @"境外游"];
    YXYLabel *lbl = [[YXYLabel alloc] init];
    lbl.color(Color_9).titleFont(Font(12)).title(@"请选择下群类型，让大家更好的了解你的群...");
    [self.view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.equalTo(@20);
    }];
    
    [self.view addSubview:self.lblCount];
    [self.lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-25));
        make.centerY.equalTo(lbl);
    }];
    
    YXYButton *btnCreate = [[YXYButton alloc] init];
    btnCreate.enabled = NO;
    btnCreate.title(@"立即创建", UIControlStateNormal).backgroundColor = Color_C;
    [btnCreate setCornerRadius:20];
    [btnCreate addTarget:self action:@selector(btnCreateClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreate];
    self.btnCreate = btnCreate;
    [btnCreate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@40);
        make.width.equalTo(@145);
        make.bottom.equalTo(@(-20 - HOME_INDICATOR_HEIGHT));
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupTypeCell" bundle:nil] forCellReuseIdentifier:@"GroupTypeCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbl.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(btnCreate.mas_top).offset(-10);
    }];
}

- (void)btnCreateClicked{
    YXYRequest *request = YXYRequest.new;
    request.apiName = @"/app/member/memberGroup/createGroup";
    request.params = @{@"groupType": [self.typeArr componentsJoinedByString:@","],
                       @"addressAdcode": self.cityCode,
                       @"faceUrl": self.imgUrlStr,
                       @"name": self.groupName,
                       @"info": self.groupIntroduce
                       };
    request.success = ^(id obj) {
        [MBProgressHUD showText:@"创建成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    request.failure = ^(NSString *msg, NSError *error) {

    };
    [RequestClient startRequest:request];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupTypeCellID" forIndexPath:indexPath];
    cell.lblTitle.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    GroupTypeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.typeArr.count == 3 && cell.vTip.hidden) {
        [MBProgressHUD showText:@"最多选择三个"];
        return;
    }
    
    cell.vTip.hidden = !cell.vTip.hidden;

    if (!cell.vTip.hidden) {
        if (![self.typeArr containsObject:self.dataSource[indexPath.row]]) {
            [self.typeArr addObject:self.dataSource[indexPath.row]];
        }
    }else{
        if ([self.typeArr containsObject:self.dataSource[indexPath.row]]) {
            [self.typeArr removeObject:self.dataSource[indexPath.row]];
        }
    }
    

    self.btnCreate.enabled = self.typeArr.count;
    if (self.typeArr.count) {
        self.btnCreate.backgroundColor = Color_Main;
    }else{
        self.btnCreate.backgroundColor = Color_C;
    }
    self.lblCount.text = [NSString stringWithFormat:@"%ld/3", self.typeArr.count];
}

- (YXYLabel *)lblCount{
    if (!_lblCount) {
        _lblCount = [[YXYLabel alloc] init];
        _lblCount.title(@"0/3").titleFont(Font(12)).color(ColorWithHex(@"b2b2b2"));
    }
    return _lblCount;
}
@end
