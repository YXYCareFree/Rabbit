//
//  InputField.h
//  YouTo
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTextView.h"

@protocol InputFieldDelegate <NSObject>

@optional

- (void)sendText:(YYTextView *)textView text:(NSString *)text;

- (void)sendVoice;

- (void)sendPhoto;

@end

typedef NS_ENUM(NSUInteger, InputFieldType) {
    InputFieldTypeComment,
    InputFieldTypeChat,
};
NS_ASSUME_NONNULL_BEGIN

@interface InputField : UIView

- (instancetype)initWithType:(InputFieldType)type baseView:(UIView *)view delegate:(id)delegate;

- (instancetype)initWithType:(InputFieldType)type delegate:(id)delegate;

@property (nonatomic, assign) InputFieldType type;

@property (nonatomic, strong) YYTextView *textView;

@property (nonatomic, weak) id<InputFieldDelegate> delegate;

/**
 键盘不能遮盖的View
 */
@property (nonatomic, weak) UIView *baseView;

@end

NS_ASSUME_NONNULL_END
