//
//  InputField.m
//  YouTo
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "InputField.h"

@interface InputField ()<YYTextViewDelegate>

@property (nonatomic, assign) BOOL keyboardShow;
@property (nonatomic, assign) CGRect originalFrame;

@end

@implementation InputField

- (void)dealloc{
    RemoveNotifiObserver(self);
}

- (instancetype)initWithType:(InputFieldType)type delegate:(nonnull id)delegate{
    if (self = [super init]) {
        self.type = type;
        self.delegate = delegate;
        [self setUI];
        [self addNotifi];
    }
    return self;
}

- (instancetype)initWithType:(InputFieldType)type baseView:(UIView *)view delegate:(nonnull id)delegate{
    if (self = [super init]) {
        self.type = type;
        self.delegate = delegate;
        [self setUI];
        [self addNotifi];
    }
    return self;
}

- (void)setUI{
    self.backgroundColor = WhiteColor;
//    self.frame = CGRectMake(0, 0, kScreenWidth, self.type == InputFieldTypeComment ? 58 : 108);
    self.layer.shadowColor = Color_E.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, -3);
    self.layer.shadowOpacity = 0.3;
    
    YXYButton *btn = [[YXYButton alloc]init];
    btn.bgImgae(LoadImageWithName(@"msg_send"), UIControlStateNormal);
    [btn addTarget:self action:@selector(sendTextClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@24);
        make.right.equalTo(@(-15));
    }];
    
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_left).offset(-15);
        make.top.equalTo(@12);
        make.left.equalTo(@15);
        make.height.equalTo(@34);
        if (self.type == InputFieldTypeComment) {
            make.bottom.equalTo(@(-12));
        }
    }];
    
    if (self.type == InputFieldTypeChat) {
        NSArray *arr = @[@"msg_voiceInput", @"msg_photo"];
        NSMutableArray *marr = [NSMutableArray new];
        for (NSInteger i = 0; i < arr.count; i++) {
            YXYButton *btn = [[YXYButton alloc] init];
            btn.tag = Tag_InputField + i;
            [btn setImage:LoadImageWithName(arr[i]) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            UIButton *temp = [marr lastObject];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (temp) {
                    make.left.equalTo(temp.mas_right).offset(30);
                    make.centerY.equalTo(temp);
                }else{
                    make.left.equalTo(@15);
                }
                make.top.equalTo(self.textView.mas_bottom).offset(17);
                if (i == arr.count - 1) {
                    make.bottom.equalTo(@(-17));
                }
            }];
            [marr addObject:btn];
        }
    }
}

- (void)btnClicked:(YXYButton *)btn{
    switch (btn.tag - Tag_InputField) {
        case 0:
            if (self.delegate && [self.delegate respondsToSelector:@selector(sendVoice)]) {
                [self.delegate sendVoice];
            }
            break;
        case 1:
            if (self.delegate && [self.delegate respondsToSelector:@selector(sendPhoto)]) {
                [self.delegate sendPhoto];
            }
            break;
        default:
            break;
    }
}

- (void)sendTextClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendText:text:)]) {
        [self.delegate sendText:self.textView text:self.textView.text];
    }
}

- (void)addNotifi{
    AddNotifiObserver(self, @"keyboardWillShow:", UIKeyboardWillShowNotification, nil);
    AddNotifiObserver(self, @"keyboardWillHide:", UIKeyboardWillHideNotification, nil);
}

- (void)keyboardWillShow:(NSNotification *)notifi{
    if (self.keyboardShow) {
        return;
    }
    self.originalFrame = self.frame;
    //取出键盘最终的frame
    CGRect rect = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%f, %@, %@", self.yxy_h, NSStringFromCGRect(rect), NSStringFromCGRect([UIScreen mainScreen].bounds));

    //取出键盘弹出需要花费的时间
    double duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    __block BOOL show = self.keyboardShow;
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(self.frame.origin.x, rect.origin.y - self.yxy_h, self.frame.size.width, self.frame.size.height);
        
    }];
    self.keyboardShow = YES;

//    if (self.baseView) {
//        CGRect frame = [self.baseView convertRect:self.baseView.bounds toView:KEY_WINDOW];
//        CGFloat y = rect.origin.y - frame.origin.y - frame.size.height - 5;
//        if (y < 0) {
//            self.changeFrame = YES;
//            [UIView animateWithDuration:duration animations:^{
//                self.vc.view.frame = CGRectMake(0, y, CurrentVC.view.bounds.size.width, CurrentVC.view.bounds.size.height);
//            }];
//        }
//    }else{
//        CGRect frame = [self convertRect:self.bounds toView:KEY_WINDOW];
//        CGFloat y = rect.origin.y - frame.origin.y - frame.size.height - 5;
//        if (y < 0) {
//            self.changeFrame = YES;
//            [UIView animateWithDuration:duration animations:^{
//                self.vc.view.frame = CGRectMake(0, y, CurrentVC.view.bounds.size.width, CurrentVC.view.bounds.size.height);
//            }];
//        }
//    }
}

- (void)keyboardWillHide:(NSNotification *)notifi{
    if (!self.keyboardShow) return;
//    CGRect rect = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //取出键盘弹出需要花费的时间
    double duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.keyboardShow = NO;
        self.frame = self.originalFrame;
    }];
    [self.textView resignFirstResponder];
//    if (self.changeFrame) {
//        [UIView animateWithDuration:duration animations:^{
//            self.vc.view.frame = CGRectMake(0, 0, CurrentVC.view.bounds.size.width, CurrentVC.view.bounds.size.height);
//        }];
//        self.changeFrame = NO;
//    }
    
}

- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sendText:text:)]) {
            [self.delegate sendText:self.textView text:textView.text];
        }
        return NO;
    }
    return YES;
}

- (YYTextView *)textView{
    if (!_textView) {
        _textView = [[YYTextView alloc] init];
        _textView.layer.borderWidth = 1;
        [_textView setCornerRadius:5];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.font = Font_PingFang_Medium(14);
        _textView.delegate = self;
        _textView.layer.borderColor = ColorWithHex(@"e5e5e5").CGColor;
    }
    return _textView;
}

@end
