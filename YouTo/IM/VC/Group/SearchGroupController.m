//
//  SearchGroupController.m
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SearchGroupController.h"
#import "GroupAdapter.h"
#import "ApplyJoinGroupController.h"
#import "GroupInfoController.h"

@interface SearchGroupController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation SearchGroupController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    self.lblTitle.text = @"查找群";
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom).offset(15);
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@30);
    }];
    
    YXYButton *btn = [[YXYButton alloc] init];
    btn.title(@"查找", UIControlStateNormal).titleFont(Font(14)).color(Color_Main, UIControlStateNormal);
    [btn addTarget:self action:@selector(searchGroupClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.vNavBar addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle);
        make.right.equalTo(@(-15));
    }];
}

- (void)searchGroupClicked{
    if (self.textField.text.length) {
        [GroupAdapter getGroupInfo:self.textField.text completion:^(BOOL success, id response) {
            if (success) {
                GroupInfoController *vc = [[GroupInfoController alloc] initWithGroupId:self.textField.text type:GroupInfoControllerTypeSearch model:response];
                PushVC(vc);
            }
        }];
    }
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入群号";
    }
    return _textField;
}
@end
