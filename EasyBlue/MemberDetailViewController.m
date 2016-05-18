//
//  MemberDetailViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/11.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "MemberDetailViewController.h"
#import "MemberInfoTableViewCell.h"
#import "NameViewController.h"
#import "CustomPickerView.h"
#import "CustomDatePickerView.h"
#import "StepDataViewController.h"

@interface MemberDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NameDelegate,CustomPickerViewDelegate,DatePickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *faceImageBtn;
@property (strong, nonatomic) IBOutlet UITableView *infoTableView;
@property (strong, nonatomic)CustomPickerView *pickerView;
@property (strong, nonatomic)CustomDatePickerView *pickerDateView;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation MemberDetailViewController
{
    NSArray *_titleArray;
    __block UIImagePickerController *pickController;
    NSArray *genderArray;
    NSMutableArray *provinceArray;
    CustomPickerViewType pickerViewType;
    NameVCType nameVCtype;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initTitleArray];
    [self initPickViewController];
    [self initComponent];
    [self initTableView];
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

- (void)initPickViewController{
    pickController = [[UIImagePickerController alloc]init];
    pickController.delegate = self;
    pickController.allowsEditing = YES;
    pickController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

- (void)initNavigationBar{
    if (_infoType == InfoTypeAddMEmber) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishAddMemberAction)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
}

- (void)finishAddMemberAction{
    
}

- (void)initTitleArray{
    _titleArray = MEMBER_TITLE_ARRAY;
    genderArray = MEMBER_GENDER_ARRAY;
    NSString *provincePlistPath = [[NSBundle mainBundle] pathForResource:@"CodeProvince" ofType:@"plist"];
    NSMutableDictionary *provinceDic = [[NSMutableDictionary alloc] initWithContentsOfFile:provincePlistPath];
    provinceArray = [NSMutableArray array];
    for (int i = 0; i < provinceDic.count; i++) {
        [provinceArray addObject:[provinceDic objectForKey:[NSString stringWithFormat:@"%d",i+1]]];
    }
}

- (void)initComponent{
    _faceImageBtn.layer.masksToBounds = YES;
    _faceImageBtn.layer.cornerRadius = 30;
}

- (void)initTableView{
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    _infoTableView.scrollEnabled = NO;
}

- (void)nameDelegateAction:(NSString *)nameStr{
    if (nameVCtype == NameVCTypeNickName){
        MemberInfoTableViewCell *cell = [_infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeName inSection:0]];
        cell.value.text = nameStr;
    }else if(nameVCtype == NameVCTypeTel){
        MemberInfoTableViewCell *cell = [_infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeTel inSection:0]];
        cell.value.text = nameStr;
    }
}

- (IBAction)clickCamera:(id)sender {
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

- (void)actionPickController:(UIImagePickerControllerSourceType)sourceType{
    pickController.sourceType = sourceType;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
         [self presentViewController:pickController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_faceImageBtn setImage:[info valueForKey:UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    [pickController dismissViewControllerAnimated:YES completion:nil];
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
    MemberInfoTableViewCell *cell = [[MemberInfoTableViewCell alloc]cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger section = indexPath.section;
    if (section == 1) {
        cell.title.text = @"健康数据";
        cell.value.text = nil;
    }else{
        NSInteger row = indexPath.row;
        cell.title.text = _titleArray[row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == TitleTypeName) {
            nameVCtype = NameVCTypeNickName;
            MemberInfoTableViewCell *cell = [_infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeName inSection:0]];
            NameViewController *nameVC = [[NameViewController alloc]init];
            nameVC.delegate = self;
            nameVC.nameStr = cell.value.text;
            nameVC.nameType = NameVCTypeNickName;
            nameVC.title = @"设置称呼";
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
            backButton.title = @"";
            self.navigationItem.backBarButtonItem = backButton;
            [self.navigationController pushViewController:nameVC animated:YES];
        }
        if (row == TitleTypeGender) {
            pickerViewType = CustomPickerViewTypeGender;
            _pickerView.dataArray = genderArray;
            MemberInfoTableViewCell *cell = [_infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeGender inSection:0]];
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
            [_pickerView presentPickerView];
        }
        if (row == TitleTypeTel) {
            nameVCtype = NameVCTypeTel;
            MemberInfoTableViewCell *cell = [_infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeTel inSection:0]];
            NameViewController *telVC = [[NameViewController alloc]init];
            telVC.delegate = self;
            telVC.nameStr = cell.value.text;
            telVC.nameType = NameVCTypeTel;
            telVC.title = @"设置手机号码";
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc]init];
            backButton.title = @"";
            self.navigationItem.backBarButtonItem = backButton;
            [self.navigationController pushViewController:telVC animated:YES];
        }
        
    }else{
        StepDataViewController *stepVC = [[StepDataViewController alloc]init];
        stepVC.title = @"今日步数";
        [self.navigationController pushViewController:stepVC animated:YES];
    }
}

- (void)canclePickerViewDelegateAction{

}

- (void)finishPickerViewDelegateAction:(NSArray *)selectArray{
    if (pickerViewType == CustomPickerViewTypeGender) {
        MemberInfoTableViewCell *cell = [_infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeGender inSection:0]];
        NSString *genderDefault = [genderArray objectAtIndex:[selectArray[0] integerValue]];
        cell.value.text = genderDefault;
    }else if (pickerViewType == CustomPickerViewTypeProvince){
        MemberInfoTableViewCell *cell = [_infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeCurrentAddress inSection:0]];
        NSString *provinceDefault = [provinceArray objectAtIndex:[selectArray[0] integerValue]];
        cell.value.text = provinceDefault;
    }
   
}

- (void)finishDatePickerViewAction:(NSString *)datePickerResult{
    MemberInfoTableViewCell *cell = [_infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TitleTypeBornDate inSection:0]];
    cell.value.text = datePickerResult;
    NSDate *nowDate= [NSDate date];
    double nowTimeInterval = [nowDate timeIntervalSince1970];
    double bornTimeInterval = [Common convertStringToTimeInterval:DATEPICKERVIEW_FORMATER withStr:datePickerResult];
    double ageTimeInterval = nowTimeInterval - bornTimeInterval;
    NSInteger resultYear = ageTimeInterval / YEAR_SECONDS;
    _ageLabel.text = [NSString stringWithFormat:@"%ld 岁",resultYear];
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
