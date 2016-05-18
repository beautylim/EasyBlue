//
//  ListMemberTableViewCell.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "ListMemberTableViewCell.h"

@implementation ListMemberTableViewCell

- (instancetype)cellWithTableView:(UITableView *)tableView inModel:(FamilyMemberModel *)model{
    static NSString *identifier = @"listMember";
    ListMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
		cell = [[ListMemberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
	NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ListMemberTableViewCell" owner:self options:nil];
	cell = [array firstObject];
	
#if 0
    
#endif
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
