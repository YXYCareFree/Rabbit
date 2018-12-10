//
//  PopView.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PopView.h"
#import "PopCell.h"

@interface PopView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *imageDataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *vBase;
@property (nonatomic, copy) void(^PopViewClickedBlock)(NSInteger idx);

@end

@implementation PopView

+ (void)popWithDataSource:(NSArray *)dataSource imageDataSource:(NSArray *)imageDataSource baseView:(UIView *)baseView completion:(void (^)(NSInteger))completion{
    PopView *view = [[PopView alloc] init];
    view.dataSource = dataSource;
    view.imageDataSource = imageDataSource;
    view.vBase = baseView;
    view.PopViewClickedBlock = completion;
    [view setUI];
    [KEY_WINDOW addSubview:view];
}

- (void)setUI{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.frame = [UIScreen mainScreen].bounds;
    [KEY_WINDOW addSubview:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    CGRect frame = [self.vBase convertRect:self.vBase.bounds toView:[UIApplication sharedApplication].delegate.window];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"PopCell" bundle:nil] forCellReuseIdentifier:@"YXYPopCellID"];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-(kScreenWidth - frame.origin.x)));
        make.top.equalTo(@(frame.size.height + frame.origin.y + 5));
        make.width.equalTo(@105);
        make.height.equalTo(@(49 * self.dataSource.count));
    }];
}

- (void)dismiss{
    [self removeFromSuperview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YXYPopCellID" forIndexPath:indexPath];
    cell.imgV.image = LoadImageWithName(self.imageDataSource[indexPath.row]);
    cell.lblTitle.text = self.dataSource[indexPath.row];
    if (indexPath.row == self.dataSource.count - 1) {
        cell.vSplit.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.PopViewClickedBlock) {
        [self dismiss];
        self.PopViewClickedBlock(indexPath.row);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;
    }
    return YES;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = WhiteColor;
        [_tableView setCornerRadius:5];
    }
    return _tableView;
}
@end
