//
//  ListMemberTableViewCell.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FamilyMemberModel.h"
@interface ListMemberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *faceImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *currentAddress;
- (instancetype)cellWithTableView:(UITableView *)tableView inModel:(FamilyMemberModel *)model;
@end
