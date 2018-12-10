//
//  SearchController.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchController : YouToViewController

- (instancetype)initWithKeywords:(NSString *)keywords;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) void(^SelectCityBlock)(NSString *code, NSString *city);


- (void)search;

@end

NS_ASSUME_NONNULL_END
