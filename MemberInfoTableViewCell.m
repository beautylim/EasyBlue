//
//  MemberInfoTableViewCell.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/11.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "MemberInfoTableViewCell.h"

@implementation MemberInfoTableViewCell

- (instancetype)cellWithTableView:(UITableView *)tableView{
   static NSString *identifier = @"memberInfo";
    MemberInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MemberInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"MemberInfoTableViewCell" owner:self options:nil];
    cell = [arr firstObject];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
