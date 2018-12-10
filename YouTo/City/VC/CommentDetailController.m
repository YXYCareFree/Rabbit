//
//  CommentDetailController.m
//  YouTo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CommentDetailController.h"
#import "CommentDetailInteractor.h"

@interface CommentDetailController ()

@property (nonatomic, strong) CommentDetailInteractor *interactor;

@end

@implementation CommentDetailController

- (instancetype)initWithCommentId:(NSString *)commentId type:(CityContentType)type{
    if (self = [super init]) {
        self.commentId = commentId;
        self.type = type;
        [self setUI];
        [self.interactor loadData];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setUI{
    self.lblTitle.title(@"评论详情");
    
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.vNavBar.mas_bottom);
    }];
    
    [self.view addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.right.equalTo(@0);
    }];
}

- (InputField *)inputField{
    if (!_inputField) {
        _inputField = [[InputField alloc] initWithType:InputFieldTypeComment delegate:self.interactor];
        _inputField.hidden = YES;
    }
    return _inputField;
}

- (CommentDetailInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[CommentDetailInteractor alloc] init];
        _interactor.vc = self;
        _interactor.pageNum = @"1";
    }
    return _interactor;
}

@end
