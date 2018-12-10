//
//  YXYSelectPhoto.m
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYSelectPhoto.h"
#import "UploadAliManager.h"

static YXYSelectPhoto *photo;

@interface YXYSelectPhoto ()<UIImagePickerControllerDelegate>

@property (nonatomic, copy) void(^PhotoUrlBlock)(NSString *urlStr);

@end

@implementation YXYSelectPhoto

+ (void)initWith:(UIImagePickerControllerSourceType)sourceType fromVC:(UIViewController *)vc completion:(void(^)(NSString *url))completion{
    photo = YXYSelectPhoto.new;
    photo.PhotoUrlBlock = completion;
    UIImagePickerController * pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.delegate = photo;
    pickerVC.navigationBar.tintColor = Color_Main;
    pickerVC.sourceType = sourceType;
    [vc presentViewController:pickerVC animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    __block UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.2);
    MBProgressHUD *hud = [MBProgressHUD showLoadingWithText:@"正在上传图片..."];

    [UploadAliManager uploadImageWithData:data progress:^(NSString * _Nonnull progress) {
        
    } completion:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            NSLog(@"imageUrl==%@", imageUrl);
            hud.label.text = @"上传成功";
            if (photo.PhotoUrlBlock) {
                photo.PhotoUrlBlock(imageUrl);
            }
            [hud hideAnimated:YES afterDelay:.5];
        }else{
            hud.label.text = @"上传失败";
            [hud hideAnimated:YES afterDelay:.5];
        }
        photo = nil;
    }];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
