//
//  PersonIfoViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "MemberInfoTableViewCell.h"
#import "LoginViewController.h"
#import "NameViewController.h"
#import "CustomPickerView.h"
#import "CustomDatePickerView.h"
#import "SettingViewController.h"

@interface PersonInfoViewController ()<UITableViewDataSource,UITableViewDelegate,NameDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CustomPickerViewDelegate,DatePickerViewDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *faceImage;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic)CustomPickerView *pickerView;
@property (strong, nonatomic)CustomDatePickerView *pickerDateView;
@property (copy, nonatomic) UIAlertController *alertController;
@property (copy, nonatomic) NSArray *titleArray;
@end

@implementation PersonInfoViewController
{
    IBOutlet UILabel *ageLabel;
    __block UIImagePickerController *pickController;
    NSArray *genderArray;
    NSMutableArray *provinceArray;
    CustomPickerViewType pickerViewType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleArray];
    [self initPickViewController];
    [self initTableView];
    [self initComponent];
    [self initAlert];
	
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _pickerView = [CustomPickerView instancePickerView];
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
    _pickerDateView = [CustomDatePickerView instanceDatePickerView];
    _pickerDateView.delegate = self;
    [self.view addSubview:_pickerDateView];
}

- (void)initTitleArray{
    _titleArray = PERSON_TITLE_ARRAY;
    genderArray = MEMBER_GENDER_ARRAY;
    NSString *provincePlistPath = [[NSBundle mainBundle] pathForResource:@"CodeProvince" ofType:@"plist"];
    NSMutableDictionary *provinceDic = [[NSMutableDictionary alloc] initWithContentsOfFile:provincePlistPath];
    provinceArray = [NSMutableArray array];
    for (int i = 0; i < provinceDic.count; i++) {
        [provinceArray addObject:[provinceDic objectForKey:[NSString stringWithFormat:@"%d",i+1]]];
    }
}

- (void)initPickViewController{
    pickController = [[UIImagePickerController alloc]init];
    pickController.delegate = self;
    pickController.allowsEditing = YES;
    pickController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

- (void)initAlert{
    _alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logOutAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [Common UserDefaultSetObject:@"" forKey:USER_TOKEN];
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:loginNav animated:YES completion:nil];

    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [_alertController addAction:cancleAction];
    [_alertController addAction:logOutAction];
}
- (void)initTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 5;
    _tableView.sectionHeaderHeight = 5;
    _tableView.scrollEnabled = NO;
}

- (void)initComponent{
    
    //将头像设置成圆形
    _faceImage.layer.masksToBounds = YES;
    _faceImage.layer.cornerRadius = 30;
    
    //加载头像
    NSString *iconStr = [Common UserDefaultGetObjectforKey:USER_URL];
    NSURL *iconURL = [NSURL URLWithString:iconStr];
    [_faceImage sd_setImageWithURL:iconURL placeholderImage:PLACE_HOLDER_IMAGE options:SDWebImageRefreshCached];
    _labelName.text = [Common UserDefaultGetObjectforKey:USER_NAME];
    UITapGestureRecognizer *clickFace = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickFaceAction)];
    [_faceImage addGestureRecognizer:clickFace];
    [_faceImage setUserInteractionEnabled:YES];
}

- (IBAction)cliclSettingButton:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    settingVC.hidesBottomBarWhenPushed = YES;
    settingVC.title = @"设置";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
    backButton.title = @"";
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:settingVC animated:YES];
}


- (void)clickFaceAction{
    UIAlertController *camerAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actionPickController:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"图库照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actionPickController:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actionPickController:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [camerAlert addAction:cameraAction];
    [camerAlert addAction:libraryAction];
    [camerAlert addAction:albumAction];
    [camerAlert addAction:cancleAction];
    [self presentViewController:camerAlert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_faceImage setImage:[info valueForKey:UIImagePickerControllerEditedImage]];
    [pickController dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionPickController:(UIImagePickerControllerSourceType)sourceType{
    pickController.sourceType = sourceType;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self presentViewController:pickController animated:YES completion:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _titleArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    MemberInfoTableViewCell *cell = [[MemberInfoTableViewCell alloc]cellWithTableView:tableView];
    cell.titleIcon.layer.masksToBounds = YES;
    cell.titleIcon.layer.cornerRadius = 13;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (section == 1) {
        cell.value.text = nil;
        cell.title.text = @"退出登录";
    }else{
        cell.title.text = _titleArray[row];
    }
        
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 1) {
        [self presentViewController:_alertController animated:YES completion:nil];
        
    }else{
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
        backButton.title = @"";
        self.navigationItem.backBarButtonItem = backButton;
        if (row == TitleTypeName) {
            MemberInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeName inSection:0]];
            NameViewController *nameVC = [[NameViewController alloc]init];
            nameVC.delegate = self;
            nameVC.nameStr = cell.value.text;
            nameVC.nameType = NameVCTypeNAme;
            nameVC.title = @"设置姓名";
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
            backButton.title = @"";
            self.navigationItem.backBarButtonItem = backButton;
            nameVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nameVC animated:YES];
        }
        if (row == TitleTypeGender) {
            pickerViewType = CustomPickerViewTypeGender;
            _pickerView.dataArray = genderArray;
            MemberInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeGender inSection:0]];
            for (int i=0; i<genderArray.count; i++) {
                if ([genderArray[i] isEqualToString:cell.value.text] ) {
                    [_pickerView.pickView selectRow:i inComponent:0 animated:YES];
                }
            }
            [_pickerView presentPickerView];
        }
        if (row == TitleTypeBornDate) {
            [_pickerDateView presentDatePickerView];
        }
        if (row == TitleTypeCurrentAddress) {
            pickerViewType = CustomPickerViewTypeProvince;
            _pickerView.dataArray = provinceArray;
            MemberInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeCurrentAddress inSection:0]];
            for (int i=0; i<genderArray.count; i++) {
                if ([provinceArray[i] isEqualToString:cell.value.text] ) {
                    [_pickerView.pickView selectRow:i inComponent:0 animated:YES];
                }
            }
            [_pickerView presentPickerView];
        }
    }
    
}

- (void)nameDelegateAction:(NSString*)nameStr{
    MemberInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.value.text = nameStr;
}


- (void)canclePickerViewDelegateAction{
    
}

- (void)finishPickerViewDelegateAction:(NSArray *)selectArray{
    if (pickerViewType == CustomPickerViewTypeGender) {
        MemberInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeGender inSection:0]];
        NSInteger index = [selectArray[0] integerValue];
        NSString *genderDefault = [genderArray objectAtIndex:index];
        cell.value.text = genderDefault;
    }else if (pickerViewType == CustomPickerViewTypeProvince){
        MemberInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeCurrentAddress inSection:0]];
        NSString *provinceDefault = [provinceArray objectAtIndex:[selectArray[0] integerValue]];
        cell.value.text = provinceDefault;
    }
    
}

- (void)finishDatePickerViewAction:(NSString *)datePickerResult{
    MemberInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeBornDate inSection:0]];
    cell.value.text = datePickerResult;
    NSDate *nowDate= [NSDate date];
    double nowTimeInterval = [nowDate timeIntervalSince1970];
    double bornTimeInterval = [Common convertStringToTimeInterval:DATEPICKERVIEW_FORMATER withStr:datePickerResult];
    double ageTimeInterval = nowTimeInterval - bornTimeInterval;
    NSInteger resultYear = ageTimeInterval / YEAR_SECONDS;
    ageLabel.text = [NSString stringWithFormat:@"%ld 岁",resultYear];
}

- (void)cancleDatePickerViewAction{
    
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
