//
//  SelectCityView.m
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SelectCityView.h"

@interface SelectCityView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) NSArray *firstComponent;
@property (nonatomic, strong) NSArray *secondComponent;
@property (nonatomic, strong) NSArray *thirdComponent;

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *code;

@property (nonatomic, assign) NSInteger secondIdx;
@property (nonatomic, assign) NSInteger thirdIdx;

@end

@implementation SelectCityView

+ (void)showSelectViewWithDataSource:(NSArray *)dataSource completion:(void(^)(NSString *city, NSString *code))completion{
    [KEY_WINDOW endEditing:YES];
    for (UIView *view in KEY_WINDOW.subviews) {
        if ([view isKindOfClass:[SelectCityView class]]) {
            return;
        }
    }
    SelectCityView *view = [SelectCityView new];
    view.dataSource = dataSource;
    view.SelectCityBlock = completion;
    [view initData];
    [view setUI];
    [KEY_WINDOW addSubview:view];
}

- (void)initData{
    self.secondIdx = self.thirdIdx = 0;
    self.firstComponent = self.dataSource;
    self.secondComponent = [self.firstComponent[0] valueForKey:@"provinces"];
    self.city = [[self.secondComponent firstObject] valueForKey:@"areaName"];
    self.code = [[self.secondComponent firstObject] valueForKey:@"areaId"];
    if ([self.secondComponent[0] valueForKey:@"cities"]) {
        self.thirdComponent = [self.secondComponent[0] valueForKey:@"cities"];
        self.city = [[self.thirdComponent firstObject] valueForKey:@"areaName"];
        self.code = [[self.thirdComponent firstObject] valueForKey:@"areaId"];
    }
}

- (void)setUI{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.frame = [UIScreen mainScreen].bounds;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200)];
    contentView.backgroundColor = [UIColor whiteColor];
    self.vContent = contentView;
    [self addSubview:contentView];
    
    UIPickerView * pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 160)];
    pickView.delegate = self;
    pickView.dataSource = self;
    [contentView addSubview:pickView];
    
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, 50, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:Color_Main forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    
    UIButton * confrmBtn = [[UIButton alloc] init];
    [confrmBtn setTitleColor:Color_Main forState:UIControlStateNormal];
    [confrmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confrmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:confrmBtn];
    [confrmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.top.equalTo(@0);
    }];
    
    [UIView animateWithDuration:.3 animations:^{
        contentView.frame = CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200);
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
    if (component == 0) return self.firstComponent.count;
  
    if (component == 1){
        if (self.secondComponent.count > 0) {
            if (self.secondIdx >= self.secondComponent.count) {
                self.city = [[self.secondComponent lastObject] valueForKey:@"areaName"];
                self.code = [[self.secondComponent lastObject] valueForKey:@"areaId"];
            }else{
                self.city = [self.secondComponent[self.secondIdx] valueForKey:@"areaName"];
                self.code = [self.secondComponent[self.secondIdx] valueForKey:@"areaId"];
            }
        }

        return self.secondComponent.count;
    }
    
    if (component == 2){
        if (self.thirdComponent.count > 0) {
            if (self.thirdIdx >= self.thirdComponent.count) {
                self.city = [[self.thirdComponent lastObject] valueForKey:@"areaName"];
                self.code = [[self.thirdComponent lastObject] valueForKey:@"areaId"];
            }else{
                self.city = [self.thirdComponent[self.thirdIdx] valueForKey:@"areaName"];
                self.code = [self.thirdComponent[self.thirdIdx] valueForKey:@"areaId"];
            }
        }

        return self.thirdComponent.count;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str;
    if (component == 0) {
        str = [self.firstComponent[row] valueForKey:@"areaName"];
    }
    if (component == 1) {
        str = [self.secondComponent[row] valueForKey:@"areaName"];
    }
    if (component == 2) {
        str = [self.thirdComponent[row] valueForKey:@"areaName"];
    }
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        if ([self.firstComponent[row] valueForKey:@"cities"]) {
            self.secondComponent = [self.firstComponent[row] valueForKey:@"cities"];
            self.thirdComponent = [self.secondComponent[0] valueForKey:@"counties"];
        }else{
            self.city = [self.firstComponent[row] valueForKey:@"areaName"];
            self.code = [self.firstComponent[row] valueForKey:@"areaId"];
//            self.secondComponent = @[];
//            self.thirdComponent = @[];
        }
    }
    if (component == 1) {
        self.secondIdx = row;
        if ([self.secondComponent[row] valueForKey:@"cities"]) {
            self.thirdComponent = [self.secondComponent[row] valueForKey:@"cities"];
        }else{
            self.city = [self.secondComponent[row] valueForKey:@"areaName"];
            self.code = [self.secondComponent[row] valueForKey:@"areaId"];
//            self.thirdComponent = @[];
        }
    }
    if (component == 2) {
        self.thirdIdx = row;
        self.city = [self.thirdComponent[row] valueForKey:@"areaName"];
        self.code = [self.thirdComponent[row] valueForKey:@"areaId"];
    }
    [pickerView reloadAllComponents];
}

- (void)cancel{
    [self dismiss];
}

- (void)confirm{
    if (self.SelectCityBlock && self.city) {
        self.SelectCityBlock(self.city, self.code);
    }
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        self.vContent.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
