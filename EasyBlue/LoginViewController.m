//
//  LoginViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "LoginViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "RegisterTelViewController.h"
#import "RegisterCodeViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButtin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initComponent];
}

- (void)initNavigation{
    [self.navigationController.navigationBar.topItem setTitle:LOGIN_TITLE];
    
}

- (void)initComponent{
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 15;
    _registerButtin.layer.borderColor = [GREEN_COLOR CGColor];
    _registerButtin.layer.borderWidth = 1;
    _registerButtin.layer.masksToBounds = YES;
    _registerButtin.layer.cornerRadius = 15;
}

- (IBAction)clickQQBtn:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [Common UserDefaultSetObject:snsAccount.userName forKey:USER_NAME];
            [Common UserDefaultSetObject:snsAccount.accessToken forKey:USER_TOKEN];
            [Common UserDefaultSetObject:snsAccount.iconURL forKey:USER_URL];
            RegisterCodeViewController *registerCodeVC = [[RegisterCodeViewController alloc]init];
            registerCodeVC.registerCode = RegisterCodeBinding;
            registerCodeVC.title = @"绑定手机";
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
            backButton.title = @"";
            self.navigationItem.backBarButtonItem = backButton;
            [self.navigationController pushViewController:registerCodeVC animated:YES];
        }
    });
}

- (IBAction)registerAction:(id)sender {
    RegisterTelViewController *registerVC = [[RegisterTelViewController alloc]init];
    registerVC.title = @"注册";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)clickForgetPassword:(id)sender {
    RegisterCodeViewController *registerCodeVC = [[RegisterCodeViewController alloc]init];
    registerCodeVC.registerCode = RegisterCodeFindPassword;
    registerCodeVC.title = @"找回密码";
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
