//
//  PublishController.h
//  YouTo
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "YXYSelectPhotoView.h"

typedef enum : NSUInteger {
    PublishControllerTypeHelp,
    PublishControllerTypeMood,
} PublishControllerType;

@interface PublishController : YouToViewController

@property (nonatomic, assign) PublishControllerType type;

@property (nonatomic, strong) YXYButton *btnPublish;

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) YXYLabel *lblPlaceHolder;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) YXYSelectPhotoView *photoView;

@property (nonatomic, strong) YXYButton *btnLocation;
@property (nonatomic, strong) YXYButton *btnAtCity;
@property (nonatomic, strong) YXYButton *btnSetting;

@end
