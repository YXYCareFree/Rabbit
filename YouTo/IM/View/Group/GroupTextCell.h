//
//  GroupTextCell.h
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GroupTextCellType) {
    GroupTextCellTypeIntroduce,
    GroupTextCellTypeTag,
    GroupTextCellTypeLocation,
};
NS_ASSUME_NONNULL_BEGIN

@interface GroupTextCell : UITableViewCell

@property (nonatomic, strong) YXYLabel *lblTitle;
@property (nonatomic, strong) YXYLabel *lblDetail;

@property (nonatomic, strong) YXYLabel *lblType1;
@property (nonatomic, strong) YXYLabel *lblType2;
@property (nonatomic, strong) YXYLabel *lblType3;

@property (nonatomic, assign) GroupTextCellType type;

@property (nonatomic, strong) NSArray *arrTag;

@end

NS_ASSUME_NONNULL_END
