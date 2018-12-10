//
//  SearchInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchInteractor : NSObject<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *searchResultData;

@property (nonatomic, weak) SearchController *vc;


- (void)searchClicked;

@end

NS_ASSUME_NONNULL_END
