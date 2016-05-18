//
//  FamilyMemberAccessor.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "FamilyMemberAccessor.h"

@implementation FamilyMemberAccessor
{
    LocalDBHelper *dbHelper;
}

- (instancetype)init{
    if (self = [super init]) {
        dbHelper = [LocalDBHelper shareManager];
    }
    return self;
}

- (BOOL)insertFamilyMember:(FamilyMemberModel *)model{
    BOOL isSuccess = false;
    if ([dbHelper open]) {
        isSuccess = [dbHelper executeUpdate:INIT_FAMILY_MEMBER_INFO_DATA_SCRIPT(model.serverId, model.userId, model.name, model.portraitUrl, model.provinceId, model.gender, model.bornDate, model.tel, model.updateTime)];
        [dbHelper close];
    }
    return isSuccess;
}

@end
