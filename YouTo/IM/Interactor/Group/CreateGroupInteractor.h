//
//  CreateGroupInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateGroupController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateGroupInteractor : NSObject<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, weak) CreateGroupController *vc;


- (void)btnPhotoClicked;

- (void)nextClicked;

@end

NS_ASSUME_NONNULL_END
