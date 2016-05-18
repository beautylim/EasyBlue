//
//  BaseBarViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "BaseBarViewController.h"
#import "FamilyMemberViewController.h"
#import "PersonInfoViewController.h"
#import "MemberDetailViewController.h"
@interface BaseBarViewController ()

@end

@implementation BaseBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (instancetype)init{
    self = [super init];
    
    //控制器的viewcontroller
    FamilyMemberViewController *familyMemberVC = [[FamilyMemberViewController alloc]init];
    PersonInfoViewController *personInfoVC = [[PersonInfoViewController alloc]init];
    //MemberDetailViewController *memberDetailVC = [[MemberDetailViewController alloc]init];
    
    //加上一个导航控制器
    UINavigationController *familyMemberNav = [[UINavigationController alloc]initWithRootViewController:familyMemberVC];
    //[familyMemberNav addChildViewController:memberDetailVC];
    
    UINavigationController *personInfoNav = [[UINavigationController alloc]initWithRootViewController:personInfoVC];
    
    
    //设置tabbar的按钮title
    familyMemberNav.title = TABBAR_ITEM1_TITLE;
    personInfoNav.title = TABBAR_ITEM2_TITLE;
    
    //设置tabbar底部的选中和为选中图片
//    UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"btn_%@_正常",titleArray[i]]];
//    UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"btn_%@_点击",titleArray[i]]];
//    if (IOS7) {
//        viewController.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
//    else {
//        [viewController.tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
//    }
    
    //设置导航控制器标题
    [familyMemberNav.navigationBar.topItem setTitle:@"家庭成员"];
    [personInfoNav.navigationBar.topItem setTitle:@"个人中心"];
    personInfoNav.tabBarItem.badgeValue = @"";
    
    //集合成数组
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:2];
    [array addObject:familyMemberNav];
    [array addObject:personInfoNav];
    
    //赋值
    self.viewControllers = array;
    return self;
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
