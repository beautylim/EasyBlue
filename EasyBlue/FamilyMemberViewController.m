//
//  FamilyMemberViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "FamilyMemberViewController.h"
#import "ListMemberTableViewCell.h"
#import "MemberDetailViewController.h"

@interface FamilyMemberViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *listTableView;
@property (strong, nonatomic) UIBarButtonItem *rightItem;
@property (strong, nonatomic) UIBarButtonItem *leftItem;
@end

@implementation FamilyMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initTableView];
}

- (void)initNavigationBar{
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editTableView)];
    _leftItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addTableView)];
    self.navigationItem.rightBarButtonItem = _rightItem;
    self.navigationItem.leftBarButtonItem = _leftItem;
}

- (void)editTableView{
    if ([_rightItem.title isEqualToString:@"编辑"]) {
        [_listTableView setEditing:YES animated:YES];
        _rightItem.title = @"完成";
    }else{
        [_listTableView setEditing:NO animated:YES];
        _rightItem.title = @"编辑";
    }
}

- (void)addTableView{
    
    //进入添加画面
    MemberDetailViewController *memberDetailVC = [[MemberDetailViewController alloc]init];
    memberDetailVC.title = @"添加家庭成员";
    
    //隐藏tabbar
    memberDetailVC.hidesBottomBarWhenPushed = YES;
    
    
    //隐藏返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:memberDetailVC animated:YES];
}

- (void)initTableView{
    _listTableView = [[UITableView alloc]init];
    [self.view addSubview:_listTableView];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.right.bottom.equalTo(self.view).with.offset(0);
    }];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListMemberTableViewCell *cell = [[ListMemberTableViewCell alloc]cellWithTableView:tableView inModel:nil];
	cell.faceImage.layer.masksToBounds = YES;
	cell.faceImage.layer.cornerRadius = 25;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
	return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MemberDetailViewController *memberVC = [[MemberDetailViewController alloc]init];
    memberVC.title = @"详细信息";
    memberVC.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    memberVC.infoType = InfoTypeDetail;
    [self.navigationController pushViewController:memberVC animated:YES];
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
