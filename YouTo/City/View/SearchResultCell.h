//
//  SearchResultCell.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

NS_ASSUME_NONNULL_END
