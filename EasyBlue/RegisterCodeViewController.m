//
//  RegisterCodeViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/16.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "RegisterCodeViewController.h"
#import "RegisterPassWordViewController.h"
#import "TelBindingSuccessViewController.h"
#import "FindPasswordViewController.h"

@interface RegisterCodeViewController ()
@property (strong, nonatomic) IBOutlet UITextField *telTextfiled;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *countDownButton;
@property (strong, nonatomic) IBOutlet UILabel *countDownLabel;
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) NSTimer *countDownTimer;
@end

@implementation RegisterCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initComponent];
}

- (void)initComponent{
    _count = 60;
    _telTextfiled.text = _telStr;
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 15;
    if (_registerCode == RegisterCodeRegister) {
        _countDownButton.hidden = YES;
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    }else{
        _countDownLabel.hidden = YES;
        [_countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
   
}

- (void)countDownAction{
    if (_count > 0) {
        _count -= 1;
        _countDownLabel.text = [NSString stringWithFormat:@"%ldS倒计时",_count];
    }else{
        [_countDownTimer invalidate];
        [_countDownButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        _countDownButton.hidden = NO;
        _countDownLabel.hidden = YES;
    }
}

- (IBAction)begainCountDownAction:(id)sender {
    _count = 60;
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    _countDownLabel.hidden = NO;
    _countDownLabel.text = @"60S倒计时";
    _countDownButton.hidden = YES;
}

- (IBAction)nextButton:(id)sender {
    if (_registerCode == RegisterCodeRegister) {
        
        RegisterPassWordViewController *registerPasswordVC = [[RegisterPassWordViewController alloc]init];
        registerPasswordVC.title = @"注册";
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
        backButton.title = @"";
        self.navigationItem.backBarButtonItem = backButton;
        [self.navigationController pushViewController:registerPasswordVC animated:YES];
        
    }else if(_registerCode == RegisterCodeBinding){
        
        TelBindingSuccessViewController *telBindingSuccessVC = [[TelBindingSuccessViewController alloc]init];
        telBindingSuccessVC.title = @"绑定成功";
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
        backButton.title = @"";
        self.navigationItem.backBarButtonItem = backButton;
        [self.navigationController pushViewController:telBindingSuccessVC animated:YES];
        
    }else{
        
        FindPasswordViewController *findPasswordVC = [[FindPasswordViewController alloc]init];
        findPasswordVC.title = @"找回密码";
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
        backButton.title = @"";
        self.navigationItem.backBarButtonItem = backButton;
        [self.navigationController pushViewController:findPasswordVC animated:YES];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
