//
//  TelBindingSuccessViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/16.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "TelBindingSuccessViewController.h"

@interface TelBindingSuccessViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTetfield;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (strong, nonatomic) IBOutlet UIButton *makeSureButton;

@end

@implementation TelBindingSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initComponent];
}

- (void)initComponent{
    _makeSureButton.layer.masksToBounds = YES;
    _makeSureButton.layer.cornerRadius = 15;
}

- (IBAction)makeSureButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
