//
//  UserInfoAccessor.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "UserInfoAccessor.h"
#import "LocalDBHelper.h"

@implementation UserInfoAccessor
{
    LocalDBHelper *dbHelper;
}

- (instancetype)init{
    if (self = [super init]) {
        dbHelper = [LocalDBHelper shareManager];
    }
    return self;
}

- (BOOL)insertUserInfo:(UserInfoModel *)model{
    BOOL isSuccess = false;
    if ([dbHelper open]) {
        isSuccess = [dbHelper executeUpdate:INIT_USER_INFO_DATA_SCRIPT(model.serverId, model.name, model.gender, model.bornDate, model.portraitUrl, model.provinceId, model.tel, model.updateTime)];
        [dbHelper close];
    }
    return isSuccess;
}

- (UserInfoModel *)readUserInfo:(FMResultSet *)resultSet{
    UserInfoModel *userInfoModel;
    userInfoModel.uuid = [[resultSet stringForColumn:USERINFO_MODEL_UUID] integerValue];
    userInfoModel.serverId = [[resultSet stringForColumn:USERINFO_MODEL_SERVERID] integerValue];
    userInfoModel.name = [resultSet stringForColumn:USERINFO_MODEL_NAME];
    userInfoModel.gender = [[resultSet stringForColumn:USERINFO_MODEL_GENDER] integerValue];
    userInfoModel.bornDate = [[resultSet stringForColumn:USERINFO_MODEL_BORNDATE] integerValue];
    userInfoModel.portraitUrl = [resultSet stringForColumn:USERINFO_MODEL_PORTRAITURL];
    userInfoModel.provinceId = [[resultSet stringForColumn:USERINFO_MODEL_PROVINCEID] integerValue];
    userInfoModel.tel = [resultSet stringForColumn:USERINFO_MODEL_TEL];
    userInfoModel.updateTime = [[resultSet stringForColumn:USERINFO_MODEL_UPDATETIME] integerValue];
    return userInfoModel;
}

@end
