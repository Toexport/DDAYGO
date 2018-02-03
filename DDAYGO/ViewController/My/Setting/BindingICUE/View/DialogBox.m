//
//  DialogBox.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "DialogBox.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
@implementation DialogBox

+ (DialogBox *)getInstance  //定义一个类方法进行访问(便利构造)
{
    static DialogBox *audioOption=nil;
    static dispatch_once_t oncet;
    dispatch_once(&oncet,^{
        audioOption = [[NSBundle mainBundle] loadNibNamed:@"DialogBox" owner:self options:nil].lastObject;
        audioOption.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    });
    if ([UIApplication sharedApplication].keyWindow) {
        [[UIApplication sharedApplication].keyWindow addSubview:audioOption];
    }
    return  audioOption;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.BGView.userInteractionEnabled = YES;
    self.hidden = YES;
    
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //监听键盘隐藏
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                       selector:@selector(keybaordhide:)
                                                           name:UIKeyboardWillHideNotification object:nil];
}

//当观察到键盘发生变化的通知后,就调用的方法
- (void)keyBoardFrameChange:(NSNotification *)userInfo{
    //    1.1获取变化的值
    NSDictionary *keyBoardDict = userInfo.userInfo;
    CGRect endKeyBoardFrame = [keyBoardDict[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //这里减去的是你需要调整的view的高度,如果view是全屏幕的可以用此方法
    CGFloat ty = endKeyBoardFrame.origin.y - [UIScreen mainScreen].bounds.size.height + 180;
    //   1.2修改transform属性,让视图变化
    //   1.3让修改有动画,获取动画的时间
    CGFloat duration = [keyBoardDict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.dialogView.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
}

// 隐藏键盘
- (void)keybaordhide:(NSNotification *)userInfo{
    NSDictionary *keyBoardDict = userInfo.userInfo;
    CGRect endKeyBoardFrame = [keyBoardDict[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //这里减去的是你需要调整的view的高度,如果view是全屏幕的可以用此方法
    CGFloat typp = endKeyBoardFrame.origin.y - [UIScreen mainScreen].bounds.size.height;
    //   1.2修改transform属性,让视图变化
    //   1.3让修改有动画,获取动画的时间
    CGFloat duration = [keyBoardDict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.dialogView.transform = CGAffineTransformMakeTranslation(0, typp);
    }];
}
// 取消
- (IBAction)cancelAction:(id)sender {
    [self.textfield endEditing:YES];
    ZPLog(@"qqqq");
    [self dismiss];
}
//確定
- (IBAction)ensureAction:(id)sender {
    [self.textfield endEditing:YES];
    if (self.textfield.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"輸入不能為空"];
    }else {
        if (self.finishBlock) {
            self.finishBlock(_textfield.text);
        }
        [self dismiss];
    }
    
}

- (void)showDialogBoxWithOperation:(DDAOperation)operation FinishBlock:(FinishBlock)finishBlock {
    
    self.finishBlock = finishBlock;
    
    switch (operation) {
        case DDAModifyNickname:
        {
            self.icucView.hidden = YES;
        }
            break;
        case DDABuildingICUC:
        {
            self.icucView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    
    [self show];
}

- (void)show {
    self.hidden = NO;
    self.BGView.alpha = 0;
    self.dialogView.alpha = 0;
    [UIView animateWithDuration:.3f animations:^{
        self.BGView.alpha = 0.5;
        self.dialogView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3f animations:^{
            self.BGView.alpha = 0;
            self.dialogView.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    });
}
//  键盘弹起
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.textfield endEditing:YES];
    
}


@end
