//
//  MoodDetailInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MoodDetailInteractor.h"
#import "CityCommonAdapter.h"
#import "MoodDetailModel.h"
#import "MoodDetailHeaderCell.h"
#import "CommentCell.h"
#import "InputField.h"
#import "YXYSelectView.h"
#import "CommentDetailController.h"
#import "ChatController.h"
#import "AccountManager.h"

#import "CommonDetailAdapter.h"
#import "HelpDetailAdapter.h"
#import "MoodDetailAdapter.h"

@interface MoodDetailInteractor ()

@property (nonatomic, strong) MoodDetailModel *model;
@property (nonatomic, strong) CommonDetailAdapter *adapter;
@property (nonatomic, strong) AnswerListModel *answerModel;
@property (nonatomic, assign) BOOL isReplyAnswer;

@end

@implementation MoodDetailInteractor

- (void)loadData{
    [self.adapter getDetailInfo:SelfVC.moodId completion:^(BOOL success, id response) {
        if (success) {
            self.model = response;
            [SelfVC.tableView reloadData];
        }
    }];
}

- (void)btnSettingClicked{
    NSArray *arr = @[@"plazaShow", @"onlyMyself", @"homeShow"];
    NSArray *titles = @[@"广场可见", @"仅自己可见", @"主页可见", @"删除心情"];
    switch (SelfVC.type) {
        case CityContentTypeHelp:titles = @[@"删除求助"]; break;
        case CityContentTypeMood: break;
        default:
            break;
    }
    [YXYSelectView initWithDataSource:titles title:@"动态设置" confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
        if (SelfVC.type == CityContentTypeHelp) {
            [self deleteDynamic];
        }else{
            if (idx == 3) {
                [self deleteDynamic];
            }else{
                [self.adapter updateMoodVist:self.model.ID visitType:arr[idx] completion:^(BOOL success, id response) {
                    if (success) {
                        [MBProgressHUD showText:@"修改成功"];
                    }
                }];
            }
        }
    }];
}

- (void)deleteDynamic{
    [self.adapter deleteMood:self.model.ID completion:^(BOOL success, id response) {
        if (success) {
            [MBProgressHUD showText:@"删除成功"];
            [SelfVC.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)atttionClicked{
    if (self.model.isConcern) {
        [self.adapter cancelAttentionMemberId:self.model.memberId completion:^(BOOL success, id response) {
            if (success) {
                SelfVC.lblAttention.text = @"关注";
                SelfVC.imgVAttention.image = LoadImageWithName(@"attention");
                self.model.isConcern = NO;
            }
        }];
    }else{
        [self.adapter addAttentionMemberId:self.model.memberId completion:^(BOOL success, id response) {
            if (success) {
                SelfVC.lblAttention.text = @"取关";
                SelfVC.imgVAttention.image = LoadImageWithName(@"cancel_attention");
                self.model.isConcern = YES;
            }
        }];
    }
}

- (void)chatClicked{
    ChatController *vc = [[ChatController alloc] initWithConversationType:ConversationType_PRIVATE targetId:self.model.memberId];
    vc.title = self.model.nickName;
    PushVC(vc);
}
#pragma mark--InputFieldDelegate
- (void)sendText:(YYTextView *)textView text:(NSString *)text{
    if (text.length) {
        WEAKSELF;
        if (self.isReplyAnswer) {
            NSArray *arr = [text componentsSeparatedByString:@"："];
            [self.adapter addAnswerInfo:arr[1] infoId:self.answerModel.ID mentionId:nil completion:^(BOOL success, id response) {
                if (success) {
                    [MBProgressHUD showText:@"评论成功"];
                    [textView resignFirstResponder];
                    [weakSelf loadData];
                    weakSelf.vc.inputField.hidden = YES;
                    textView.text = @"";
                }
            }];

        }else{
            [self.adapter addReplyInfo:text infoId:self.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    [MBProgressHUD showText:@"评论成功"];
                    [textView resignFirstResponder];
                    [weakSelf loadData];
                    weakSelf.vc.inputField.hidden = YES;
                    textView.text = @"";
                }
            }];
        }
    }
}


#pragma mark--UITableViewDataSource UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) {
        return self.model.answerList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) {
        MoodDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoodDetailHeaderCellID" forIndexPath:indexPath];
        cell.type = SelfVC.type;
        cell.model = self.model;
        cell.CommentClickedBlock = ^{
            SelfVC.inputField.hidden = NO;
            self.isReplyAnswer = NO;
        };
        cell.DeleteClickedBlock = ^{
            [self.adapter deleteMood:self.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    if (SelfVC.DeleteBlock) {
                        SelfVC.DeleteBlock();
                    }
                    [MBProgressHUD showText:@"删除成功"];
                    [SelfVC.navigationController popViewControllerAnimated:YES];
                }
            }];
        };
        return cell;
    }
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCellID" forIndexPath:indexPath];
    cell.type = CommentCellTypeComment;
    cell.model = self.model.answerList[indexPath.row];
    cell.isSelf = [[AccountManager memberId] isEqualToString:self.model.memberId];
    __weak CommentCell *wCell = cell;
    cell.LongPressBlcok = ^{
        NSArray *arr = @[];
        if (SelfVC.type == CityContentTypeHelp || SelfVC.type == CityContentTypeNews) {
            arr = @[@"删除评论", @"设为精选回答"];
        }else{
            arr = @[@"删除评论"];
        }
        [YXYSelectView initWithDataSource:arr confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
            WEAKSELF;
            if (idx) {
                [self.adapter setGoodChoice:wCell.model.ID completion:^(BOOL success, id response) {
                    if (success) {
                        [MBProgressHUD showText:@"设置成功"];
                        [weakSelf loadData];
                    }
                }];
            }else{
                [self.adapter deleteReplyId:wCell.model.ID msgId:self.model.ID completion:^(BOOL success, id response) {
                    if (success) {
                        [MBProgressHUD showText:@"删除成功"];
                        [weakSelf loadData];
                    }
                }];
            }
        }];
    };
    
    cell.LikeBlcok = ^{
        if (wCell.model.isLike) {
            [self.adapter unlikeReplyId:wCell.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    wCell.model.isLike = NO;
                    [wCell.btnFavour setImage:LoadImageWithName(@"mine_zan_nor") forState:UIControlStateNormal];
                    int num = [wCell.model.likeNum intValue];
                    wCell.model.likeNum = [NSString stringWithFormat:@"%d", --num];
                    wCell.lblFavour.text = wCell.model.likeNum;
                }
            }];
        }else{
            [self.adapter likeReplyId:wCell.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    wCell.model.isLike = YES;
                    [wCell.btnFavour setImage:LoadImageWithName(@"mine_zan_sel") forState:UIControlStateNormal];
                    int num = [wCell.model.likeNum intValue];
                    wCell.model.likeNum = [NSString stringWithFormat:@"%d", ++num];
                    wCell.lblFavour.text = wCell.model.likeNum;
                }
            }];
        }
    };
    
    cell.JumpAnswerDetailBlcok = ^{
        CommentDetailController *vc = [[CommentDetailController alloc] initWithCommentId:wCell.model.ID type:SelfVC.type];
        PushVC(vc);
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return;

    SelfVC.inputField.hidden = NO;
    AnswerListModel *model = self.model.answerList[indexPath.row];
    SelfVC.inputField.textView.text = [NSString stringWithFormat:@"回复%@：", model.nickName];
    self.isReplyAnswer = YES;
    self.answerModel = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 46;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section) {
        UIView *view = [UIView new];
        UIView *split = UIView.new;
        split.backgroundColor = Color_E;
        [view addSubview:split];
        [split mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@10);
        }];
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = WhiteColor;
        [view addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(split.mas_bottom);
            make.left.right.bottom.equalTo(view);
        }];
        YXYLabel *lbl = YXYLabel.new;
        lbl.title([@"评论" stringByAppendingFormat:@" %@", self.model.commentNum?:@""]).titleFont(Font_PingFang_Medium(16)).color(ColorWithHex(@"282c34"));
        [bg addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@8);
            make.left.equalTo(@15);
        }];
        UIView *indicator = UIView.new;
        indicator.backgroundColor = Color_Main;
        [indicator setCornerRadius:2];
        [bg addSubview:indicator];
        [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.width.equalTo(@30);
            make.height.equalTo(@4);
            make.top.equalTo(lbl.mas_bottom).offset(2);
        }];
        return view;
    }
    return nil;
}

- (CommonDetailAdapter *)adapter{
    if (!_adapter) {
        if (SelfVC.type == CityContentTypeHelp || SelfVC.type == CityContentTypeNews) {
            _adapter = [[HelpDetailAdapter alloc] init];
        }
        if (SelfVC.type == CityContentTypeMood) {
            _adapter = [[MoodDetailAdapter alloc] init];
        }
    }
    return _adapter;
}

@end
