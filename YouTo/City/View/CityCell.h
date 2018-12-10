//
//  CityCell.h
//  YouTo
//
//  Created by apple on 2018/12/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseTableViewCell.h"
#import "CityController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityCell : YXYBaseTableViewCell<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CityContentType)type;

@property (nonatomic, assign) CityContentType type;

@property (nonatomic, strong) CityController *vc;

@property (nonatomic, copy) void(^ChangeCityContentBlock)(CityContentType type);

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

NS_ASSUME_NONNULL_END
