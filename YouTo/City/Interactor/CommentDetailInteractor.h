//
//  CommentDetailInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "CommentDetailController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentDetailInteractor : YXYBaseInteractor<InputFieldDelegate>

@property (nonatomic, weak) CommentDetailController *vc;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
