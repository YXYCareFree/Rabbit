//
//  UIViewController+Helper.m
//  YouTo
//
//  Created by apple on 2018/12/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIViewController+Helper.h"
#import <objc/runtime.h>

@implementation UIViewController (Helper)

+(void)load{
    Method systemMethod = class_getInstanceMethod(self, @selector(presentViewController:animated:completion:));
    Method my_Method = class_getInstanceMethod(self, @selector(yxy_presentViewController:animated:completion:));
    method_exchangeImplementations(systemMethod, my_Method);
    
    Method dismiss = class_getInstanceMethod(self, @selector(dismissViewControllerAnimated:completion:));
    Method yxy_dismiss = class_getInstanceMethod(self, @selector(yxy_dismissViewControllerAnimated:completion:));
    method_exchangeImplementations(dismiss, yxy_dismiss);
}

- (void)yxy_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [self yxy_presentViewController:viewControllerToPresent animated:flag completion:completion];
    if ([viewControllerToPresent isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewControllerToPresent;
        if ([nav.topViewController isKindOfClass:NSClassFromString(@"RCLocationPickerViewController")] || [nav.topViewController isKindOfClass:NSClassFromString(@"UIImagePickerController")] || [nav.topViewController isKindOfClass:NSClassFromString(@"RCLocationViewController")]) {
            [[UINavigationBar appearance] setTintColor:Color_Main];
            [[UINavigationBar appearance] setBarTintColor:Color_Main];
        }else{
            [[UINavigationBar appearance] setTintColor:WhiteColor];
            [[UINavigationBar appearance] setBarTintColor:WhiteColor];
        }
    }
}

- (void)yxy_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self yxy_dismissViewControllerAnimated:flag completion:completion];;
    [[UINavigationBar appearance] setTintColor:WhiteColor];
    [[UINavigationBar appearance] setBarTintColor:WhiteColor];
}

@end
