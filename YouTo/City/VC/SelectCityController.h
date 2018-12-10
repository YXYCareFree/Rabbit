//
//  SelectCityController.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "SelectCityHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectCityController : YouToViewController

- (instancetype)initWithSelectCityBlock:(void(^)(NSString *code, NSString *city))block;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionView *recommendCollectionV;

@property (nonatomic, copy) void(^SelectCityBlock)(NSString *code, NSString *city);
@property (nonatomic, copy) void(^SearchCityBlock)(NSString *code, NSString *city);

@end

NS_ASSUME_NONNULL_END
