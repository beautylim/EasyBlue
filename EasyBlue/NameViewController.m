//
//  NameViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/14.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextfiled;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *finishButtonTopAlign;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UITextField *messgaeCodeTextfield;
@property (strong, nonatomic) IBOutlet UIButton *reSendCodeButton;
@property (strong, nonatomic) IBOutlet UILabel *countDownLabel;
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTextfiled];
    [self initComponent];
}

- (void)initTextfiled{
    if (![_nameStr isEqualToString:@"未设置"]) {
        _nameTextfiled.text = _nameStr;
    }
}

- (void)initComponent{
   [self initKeyBoard];
    _finishButton.layer.masksToBounds = YES;
    _finishButton.layer.cornerRadius = 15;
}

- (void)initKeyBoard{
    if (_nameType == NameVCTypeTel) {
        _nameTextfiled.placeholder = @"设置手机号码";
        _nameTextfiled.keyboardType = UIKeyboardTypeNumberPad;
        [_finishButton setTitle:@"设置手机号码" forState:UIControlStateNormal];
        _bottomView.hidden = NO;
        _countDownLabel.hidden = YES;
    }
    if (_nameType == NameVCTypeNickName) {
        _finishButtonTopAlign.constant = 94;
        _nameTextfiled.placeholder = @"设置称呼";
        [_finishButton setTitle:@"设置称呼" forState:UIControlStateNormal];
    }
    if (_nameType == NameVCTypeNAme) {
        _finishButtonTopAlign.constant = 94;
    }
}

- (void)countDownAction{
    if (_count > 0) {
        _count -=1;
        _countDownLabel.text = [NSString stringWithFormat:@"%ldS倒计时",_count];
    }else{
        [_reSendCodeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        _reSendCodeButton.hidden = NO;
        _countDownLabel.hidden = YES;
    }
    
}

- (IBAction)finishButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(nameDelegateAction:)]) {
        [self.delegate nameDelegateAction:_nameTextfiled.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)reSendCodeAction:(id)sender {
     _count = 60;
     _countDownLabel.text = [NSString stringWithFormat:@"%ldS倒计时",_count];
     _countDownLabel.hidden = NO;
     _reSendCodeButton.hidden = YES;
     _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
