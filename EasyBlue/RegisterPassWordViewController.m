//
//  RegisterPassWordViewController.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/16.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "RegisterPassWordViewController.h"

@interface RegisterPassWordViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *faceImageButton;
@property (strong, nonatomic) IBOutlet UITextField *nameTextfiled;
@property (strong, nonatomic) IBOutlet UITextField *passworldTextfiled;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@end

@implementation RegisterPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickViewController];
    [self initComponent];
}

- (void)initPickViewController{
    _imagePickerVC = [[UIImagePickerController alloc]init];
    _imagePickerVC.delegate = self;
    _imagePickerVC.allowsEditing = YES;
    _imagePickerVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

- (void)initComponent{
    _faceImageButton.layer.masksToBounds = YES;
    _registerButton.layer.masksToBounds = YES;
    _faceImageButton.layer.cornerRadius = 30;
    _registerButton.layer.cornerRadius = 15;
    
}

- (IBAction)clickFaceImageButton:(id)sender {
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
    _imagePickerVC.sourceType = sourceType;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self presentViewController:_imagePickerVC animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_faceImageButton setImage:[info valueForKey:UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    [_imagePickerVC dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegisterButton:(id)sender {
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
