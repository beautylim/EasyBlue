//
//  AppDelegate.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "LoginViewController.h"
#import "BaseBarViewController.h"
#import "LocalDBHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:2];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BaseBarViewController *barVC = [[BaseBarViewController alloc]init];
    self.window.rootViewController = barVC;
    [self.window makeKeyAndVisible];
    
    //设置友盟
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithAppkey:APPKEY reportPolicy:BATCH channelId:nil];
    [UMSocialData setAppKey:APPKEY];
    
    //设置QQ
    [UMSocialQQHandler setQQWithAppId:QQ_APPID appKey:QQ_APPKEY url:UMTHIRD_URL];
    [UMSocialQQHandler setSupportWebView:YES];
    
    //设置微信
    
    //setting IQKeyboardManager
    IQKeyboardManager *keyManager = [IQKeyboardManager sharedManager];
    keyManager.enable = YES;
    keyManager.shouldResignOnTouchOutside = YES;
    keyManager.shouldToolbarUsesTextFieldTintColor = YES;
    keyManager.enableAutoToolbar = NO;
    
    //判断是否登录控制跳转界面
    #if 1
    NSString *isLogin = [Common UserDefaultGetObjectforKey:USER_TOKEN];
    if (isLogin.length == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
   #endif
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
