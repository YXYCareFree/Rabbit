//
//  YXYSelectPhotoView.m
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYSelectPhotoView.h"

#define PhotoWidth  (kScreenWidth - 50) / 3
#define PhotoHeight  PhotoWidth * 3 / 4

@interface YXYSelectPhotoView ()

@property (nonatomic, strong) YXYButton *btnAddPhoto;

@end

@implementation YXYSelectPhotoView

@synthesize dataSource = _dataSource;

- (instancetype)init{
    if (self = [super init]) {
        [self setDefaultUI];
    }
    return self;
}

- (void)setDefaultUI{
    self.maxPhotoNum = 6;
    [self addSubview:self.btnAddPhoto];
    [self.btnAddPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(PhotoWidth));
        make.height.equalTo(@(PhotoWidth * 3 / 4));
        make.left.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;

    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[SelectedImgeView class]]) {
            [subView removeFromSuperview];
        }
    }
    if (dataSource.count == self.maxPhotoNum) [self.btnAddPhoto removeFromSuperview];
    if (dataSource.count == 0) [self setDefaultUI];
        
    __weak YXYSelectPhotoView *weakSelf = self;
    for (NSInteger i = 0; i < dataSource.count; i++) {
        SelectedImgeView *imageV = [[SelectedImgeView alloc] init];
        [imageV.btnDelete setImage:LoadImageWithName(@"delete_image") forState:UIControlStateNormal];
        [imageV.imageView sd_setImageWithURL:[NSURL URLWithString:dataSource[i]]];
        imageV.DeleteBlock = ^{
            [weakSelf.dataSource removeObjectAtIndex:i];
            weakSelf.dataSource = weakSelf.dataSource;
        };
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@((PhotoWidth + 10) * (i % 3)));
            make.height.equalTo(@(PhotoHeight));
            make.width.equalTo(@(PhotoWidth));
            make.top.equalTo(@((PhotoHeight + 10) * (i / 3)));
            if (i == self.maxPhotoNum - 1) {
                make.bottom.equalTo(@0);
            }
        }];
        if (i == (self.dataSource.count - 1) && i < (self.maxPhotoNum - 1)) {
            [self addSubview:self.btnAddPhoto];
            [self.btnAddPhoto mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@((PhotoWidth + 10) * ((i + 1) % 3)));
                make.height.equalTo(@(PhotoHeight));
                make.top.equalTo(@((PhotoHeight + 10) * ((i + 1) / 3)));
                make.width.equalTo(@(PhotoWidth));
                make.bottom.equalTo(@0);
            }];
        }
    }
}

- (void)addPhotoClicked{
    if (self.AddPhotoBlock) {
        self.AddPhotoBlock();
    }
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (YXYButton *)btnAddPhoto{
    if (!_btnAddPhoto) {
        _btnAddPhoto = YXYButton.new;
        _btnAddPhoto.backgroundColor = Color_E;
        [_btnAddPhoto setCornerRadius:5];
        [_btnAddPhoto addTarget:self action:@selector(addPhotoClicked) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imgV = [[UIImageView alloc] initWithImage:LoadImageWithName(@"camera")];
        [_btnAddPhoto addSubview:imgV];
        YXYLabel *lbl = YXYLabel.new;
        lbl.title(@"添加照片").color(ColorWithHex(@"999999")).titleFont(Font_PingFang_Medium(11));
        [_btnAddPhoto addSubview:lbl];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_btnAddPhoto);
            make.centerY.equalTo(self->_btnAddPhoto).offset(-5);
        }];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_btnAddPhoto);
            make.top.equalTo(imgV.mas_bottom).offset(2);
        }];
    }
    return _btnAddPhoto;
}

@end



@implementation SelectedImgeView

- (instancetype)init{
    if (self = [super init]) {

        [self addSubview:self.imageView];
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.imageView setCornerRadius:5];
        
        [self addSubview:self.btnDelete];
        [self.btnDelete mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(-5));
            make.left.equalTo(@(-5));
        }];
    }
    return self;
}

- (YXYButton *)btnDelete{
    if (!_btnDelete) {
        _btnDelete = YXYButton.new;
        [_btnDelete addTarget:self action:@selector(btnDeleteClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDelete;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (void)btnDeleteClicked{
    [self removeFromSuperview];
    if (self.DeleteBlock) {
        self.DeleteBlock();
    }
}

@end
