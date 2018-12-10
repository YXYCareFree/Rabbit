//
//  HomeAnimationView.h
//  YouTo
//
//  Created by 杨肖宇 on 2018/12/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchUserModel.h"

@interface HomeAnimationView : UIView

- (instancetype)initWithFrame:(CGRect)frame centerImageUrl:(NSString *)imgUrl roundImageUrlGroup:(NSArray *)urlGroup;

@property (nonatomic, strong) NSArray<MatchUserModel *> *roundImgGroup;
@property (nonatomic, strong) NSString *centerImgUrl;


- (void)startScan;

- (void)stopScan;

- (void)startAnimation;

@end
