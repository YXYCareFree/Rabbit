//
//  UIImageView+ProgressView.m
//
//  Created by Kevin Renskers on 07-06-13.
//  Copyright (c) 2013 Kevin Renskers. All rights reserved.
//

#import "UIImageView+ProgressView.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"

#define TAG_PROGRESS_VIEW 149462

@implementation UIImageView (ProgressView)

- (void)addProgressView:(MBProgressHUD *)progressView {
    MBProgressHUD *existingProgressView = (MBProgressHUD *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (!existingProgressView) {
        if (!progressView) {
            progressView = [MBProgressHUD showHUDAddedTo:self animated:YES];
            progressView.tag =TAG_PROGRESS_VIEW;
            progressView.mode=MBProgressHUDModeDeterminate;
        }

//        progressView.tag = TAG_PROGRESS_VIEW;
//        progressView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//
//        float width = progressView.frame.size.width;
//        float height = progressView.frame.size.height;
//        float x = (self.frame.size.width / 2.0) - width/2;
//        float y = (self.frame.size.height / 2.0) - height/2;
//        progressView.frame = CGRectMake(x, y, width, height);

       // [self addSubview:progressView];
//        [progressView showAnimated:YES];
    }
}

- (void)updateProgress:(CGFloat)progress {
    MBProgressHUD *progressView = (MBProgressHUD *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (progressView) {
        progressView.progress = progress;
    }
}

- (void)removeProgressView {
    MBProgressHUD *progressView = (MBProgressHUD *)[self viewWithTag:TAG_PROGRESS_VIEW];
    if (progressView) {
        [progressView removeFromSuperview];
    }
}

- (void)sd_setImageWithURL:(NSURL *)url usingProgressView:(MBProgressHUD *)progressView {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingProgressView:(MBProgressHUD *)progressView {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingProgressView:(MBProgressHUD *)progressView{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDExternalCompletionBlock)completedBlock usingProgressView:(MBProgressHUD *)progressView {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock usingProgressView:(MBProgressHUD *)progressView {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDExternalCompletionBlock)completedBlock usingProgressView:(MBProgressHUD *)progressView {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock usingProgressView:progressView];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock usingProgressView:(MBProgressHUD *)progressView {
    [self addProgressView:progressView];
    
    __weak typeof(self) weakSelf = self;

    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat progress = ((CGFloat)receivedSize / (CGFloat)expectedSize);
        dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf updateProgress:progress];
        });

        if (progressBlock) {
            progressBlock(receivedSize, expectedSize,targetURL);
        }
    }
    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf removeProgressView];
        if (completedBlock) {
            completedBlock(image, error, cacheType, imageURL);
        }
    }];
}

@end
