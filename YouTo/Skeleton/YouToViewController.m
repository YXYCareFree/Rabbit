//
//  YouToViewController.m
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"

@interface YouToViewController ()

@end

@implementation YouToViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.btnBack setImage:LoadImageWithName(@"back_gray") forState:UIControlStateNormal];
    self.lblTitle.titleFont(Font_PingFang_Medium(18)).color(Color_3);
}

@end
