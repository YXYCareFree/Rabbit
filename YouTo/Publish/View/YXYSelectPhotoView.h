//
//  YXYSelectPhotoView.h
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXYSelectPhotoView : UIView

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger maxPhotoNum;
@property (nonatomic, copy) void(^AddPhotoBlock)(void);

@end



@interface SelectedImgeView : UIView

@property (nonatomic, strong) YXYButton *btnDelete;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) void(^DeleteBlock)(void);

@end

NS_ASSUME_NONNULL_END
