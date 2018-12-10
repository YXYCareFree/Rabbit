//
//  SelectCityInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectCityController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectCityInteractor : NSObject<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) SelectCityController *vc;

- (void)loadData;

- (void)selectCategory:(NSInteger)idx;

- (void)searchClicked;

@end

NS_ASSUME_NONNULL_END
