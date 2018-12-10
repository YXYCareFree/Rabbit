//
//  CommentDetailInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CommentDetailInteractor.h"
#import "YXYSelectView.h"

#import "HelpDetailAdapter.h"
#import "MoodDetailAdapter.h"

@interface CommentDetailInteractor ()

@property (nonatomic, strong) CommonDetailAdapter *adapter;
@property (nonatomic, strong) AnswerListModel *model;
@property (nonatomic, strong) MoodAnswerDetailListModel *answerModel;
@property (nonatomic, assign) BOOL isReplyAnswer;

@end

@implementation CommentDetailInteractor

- (void)loadData{
    [self.adapter findMoreReply:SelfVC.commentId pageNum:self.pageNum completion:^(BOOL success, id response) {
        if (success) {
            self.model = response;
            [SelfVC.tableView reloadData];
        }
    }];
}

#pragma mark--InputFieldDelegate
- (void)sendText:(YYTextView *)textView text:(NSString *)text{
    if (text.length) {
        WEAKSELF;
        NSString *mentionId;
        if (self.isReplyAnswer) {
            mentionId = self.answerModel.ID;
        }
        [self.adapter addAnswerInfo:text infoId:self.model.ID mentionId:mentionId completion:^(BOOL success, id response) {
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

#pragma mark--UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.model.moodAnswerDetailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCellID" forIndexPath:indexPath];
    __weak CommentCell *wCell = cell;

    if (indexPath.section) {
        cell.type = CommentCellTypeComment;
        cell.answerDetailModel = self.model.moodAnswerDetailList[indexPath.row];
//        cell.lblDetail.text = cell.answerDetailModel.info;
        NSArray *arr = [cell.answerDetailModel.info componentsSeparatedByString:@"："];
        if (arr.count == 2) {
            NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：", arr[0]] attributes:@{NSFontAttributeName: Font_PingFang_Medium(15), NSForegroundColorAttributeName: Color_Main}];
            NSAttributedString *str = [[NSAttributedString alloc] initWithString:arr[1] attributes:@{NSFontAttributeName: Font_PingFang_Medium(15), NSForegroundColorAttributeName: Color_3}];
            [mstr appendAttributedString:str];
            cell.lblDetail.attributedText = mstr;
        }
        cell.LikeBlcok = ^{
            MoodAnswerDetailListModel *detailModel = wCell.answerDetailModel;
            if (detailModel.isLike) {
                [self.adapter unlikeAnswerId:detailModel.ID completion:^(BOOL success, id response) {
                    if (success) {
                        detailModel.isLike = NO;
                        [wCell.btnFavour setImage:LoadImageWithName(@"mine_zan_nor") forState:UIControlStateNormal];
                        int num = [detailModel.likeNum intValue];
                        detailModel.likeNum = [NSString stringWithFormat:@"%d", --num];
                        wCell.lblFavour.text = detailModel.likeNum;
                    }
                }];
            }else{
                [self.adapter likeAnswerId:detailModel.ID completion:^(BOOL success, id response) {
                    if (success) {
                        detailModel.isLike = YES;
                        [wCell.btnFavour setImage:LoadImageWithName(@"mine_zan_sel") forState:UIControlStateNormal];
                        int num = [detailModel.likeNum intValue];
                        detailModel.likeNum = [NSString stringWithFormat:@"%d", ++num];
                        wCell.lblFavour.text = detailModel.likeNum;
                    }
                }];
            }
        };
    }else{
        cell.type = CommentCellTypeDetail;
        cell.model = self.model;
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
    }
    cell.LongPressBlcok = ^{
        NSArray *arr = @[@"删除评论"];;
        [YXYSelectView initWithDataSource:arr confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
            WEAKSELF;
            [self.adapter deleteReplyId:wCell.answerDetailModel.ID msgId:self.model.ID completion:^(BOOL success, id response) {
                if (success) {
                    [MBProgressHUD showText:@"删除成功"];
                    [weakSelf loadData];
                }
            }];
        }];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelfVC.inputField.hidden = NO;
    if (indexPath.section) {
        self.isReplyAnswer = YES;
        self.answerModel = self.model.moodAnswerDetailList[indexPath.row];
        SelfVC.inputField.textView.text = [NSString stringWithFormat:@"回复%@：", self.answerModel.nickName];
    }else{
        self.isReplyAnswer = NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section) return 0;
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section) return nil;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = Color_E;
    return view;
}

- (CommonDetailAdapter *)adapter{
    if (!_adapter) {
        if (SelfVC.type == CityContentTypeMood) {
            _adapter = [[MoodDetailAdapter alloc] init];
        }else{
            _adapter = [[HelpDetailAdapter alloc] init];
        }
    }
    return _adapter;
}

@end
