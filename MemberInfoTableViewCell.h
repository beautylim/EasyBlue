//
//  MemberInfoTableViewCell.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/11.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *value;

- (instancetype)cellWithTableView:(UITableView *)tableView;
@end
