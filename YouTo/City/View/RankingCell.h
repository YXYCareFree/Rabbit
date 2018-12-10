//
//  RankingCell.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WarmHeartListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RankingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnFirst;
@property (weak, nonatomic) IBOutlet UIButton *btnSecond;
@property (weak, nonatomic) IBOutlet UIButton *btnThird;

@property (nonatomic, copy) void(^RankingBlock)(NSInteger rank);
@property (nonatomic, strong) NSArray<WarmHeartListModel *> *dataSource;

@end

NS_ASSUME_NONNULL_END
