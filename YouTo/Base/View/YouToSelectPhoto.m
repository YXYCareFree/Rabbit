//
//  YouToSelectPhoto.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToSelectPhoto.h"
#import "YXYSelectPhoto.h"
#import "YXYSelectView.h"

@interface YouToSelectPhoto ()<UIImagePickerControllerDelegate>

@end
@implementation YouToSelectPhoto

+ (void)selectPhoto:(void (^)(NSString * _Nonnull))completion{
    [YXYSelectView initWithDataSource:@[@"从相册选择", @"拍照"] confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
        UIImagePickerControllerSourceType sourceType;
        if (idx == 0) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else{
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        [YXYSelectPhoto initWith:sourceType fromVC:CurrentVC completion:^(NSString * _Nonnull urlStr) {
            if (completion) {
                completion(urlStr);
            }
        }];
    }];

}
@end
