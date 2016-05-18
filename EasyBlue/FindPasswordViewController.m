//
//  FindPasswordViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/16.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "LoginViewController.h"

@interface FindPasswordViewController ()
@property (strong, nonatomic) IBOutlet UITextField *firstPasswordTextfield;
@property (strong, nonatomic) IBOutlet UITextField *secondPasswordTextfield;
@property (strong, nonatomic) IBOutlet UIButton *changePasswordButton;

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initComponent];
}

- (void)initComponent{
    _changePasswordButton.layer.masksToBounds = YES;
    _changePasswordButton.layer.cornerRadius = 15;
    if (_findPasswordType == FindPasswordTypeChangeTel) {
        _firstPasswordTextfield.placeholder = @"设置新手机号码";
        _firstPasswordTextfield.keyboardType = UIKeyboardTypeNumberPad;
        _secondPasswordTextfield.keyboardType = UIKeyboardTypeNumberPad;
        _secondPasswordTextfield.placeholder = @"再次输入手机号码";
        [_changePasswordButton setTitle:@"修改手机号码" forState:UIControlStateNormal];
    }
}

- (IBAction)changePasswordButtonAction:(id)sender {
    if (_findPasswordType == FindPasswordTypeFinding) {
        UIViewController *temp;
        for (UIViewController *item in self.navigationController.viewControllers){
            if ([item isKindOfClass:[LoginViewController class]]) {
                temp = item;
            }
        }
        if (temp) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
    if (_findPasswordType == FindPasswordTypeChangePass) {
        
    }
    if (_findPasswordType == FindPasswordTypeChangeTel) {
        
    }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
