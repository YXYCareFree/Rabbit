//
//  MHPhotoBrowserController.h
//  图片浏览器
//
//  Created by 宋鲲鹏 on 16/4/12.
//  Copyright © 2016年 hcl. All rights reserved.
//

#import "MHPhotoBrowserController.h"
#import "MHPhotosBrowserView.h"

#define NavBarHeight 44
@interface MHPhotoBrowserController ()<MHPhotosBrowseDelegate>
@property (nonatomic,strong)MHPhotosBrowserView *photo_photosBrowser;
@end
@implementation MHPhotoBrowserController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.photo_photosBrowser];
}

- (MHPhotosBrowserView *)photo_photosBrowser
{
    if (!_photo_photosBrowser) {
        _photo_photosBrowser = [[MHPhotosBrowserView alloc] initWithFrame:CGRectMake(0,44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44) Photos:self.imgArray];
        _photo_photosBrowser.delegate = self;
        _photo_photosBrowser.currentImgIndex = self.currentImgIndex;
       [_photo_photosBrowser reloadPhotoBrowseWithPhotoArray:self.imgArray];
        
    }
    return _photo_photosBrowser;
}


- (void)photosBrowse:(MHPhotosBrowserView *)photosBrowse asingleTapSelectItemAtIndex:(NSInteger)index {
    NSLog(@"单击");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)currentStringAboutIndex:(NSString *)currenStr currentIndex:(NSInteger)index {
    NSLog(@"滑动到第几  == %zd",index);
    self.title =  currenStr;
}

@end
