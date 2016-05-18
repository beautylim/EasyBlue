//
//  UserInfoAccessor.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserInfoAccessor : NSObject

- (BOOL)insertUserInfo:(UserInfoModel *)model;

@end
