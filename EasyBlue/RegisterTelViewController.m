//
//  RegisterTelViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/16.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "RegisterTelViewController.h"
#import "RegisterCodeViewController.h"

@interface RegisterTelViewController ()
@property (strong, nonatomic) IBOutlet UITextField *telTextfiled;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@end

@implementation RegisterTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initComponet];
}

- (void)initComponet{
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 15;
}

- (IBAction)nextAction:(id)sender {
    RegisterCodeViewController *registerCodeVC = [[RegisterCodeViewController alloc]init];
    registerCodeVC.title = @"注册";
    registerCodeVC.telStr = _telTextfiled.text;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:registerCodeVC animated:YES];
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
