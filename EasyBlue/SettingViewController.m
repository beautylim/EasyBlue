//
//  SettingViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/16.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "SettingViewController.h"
#import "MemberInfoTableViewCell.h"
#import "FindPasswordViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSArray *titleArray;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleArray];
    [self initTableView];
}

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) style:UITableViewStyleGrouped];
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)initTitleArray{
    _titleArray = [NSArray arrayWithObjects:@"重置手机号",@"重置密码", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    MemberInfoTableViewCell *cell = [[MemberInfoTableViewCell alloc]cellWithTableView:_tableView];
    cell.title.text = _titleArray[row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row == 0) {
    
        FindPasswordViewController *findPasswordVC = [[FindPasswordViewController alloc]init];
        findPasswordVC.title = @"重置手机号码";
        findPasswordVC.findPasswordType = FindPasswordTypeChangeTel;
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
        backButton.title = @"";
        self.navigationItem.backBarButtonItem = backButton;
        [self.navigationController pushViewController:findPasswordVC animated:YES];
    
    }else if(row == 1){
    
        FindPasswordViewController *findPasswordVC = [[FindPasswordViewController alloc]init];
        findPasswordVC.title = @"重置密码";
        findPasswordVC.findPasswordType = FindPasswordTypeChangePass;
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
