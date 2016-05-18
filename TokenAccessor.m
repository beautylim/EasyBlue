//
//  TokenAccessor.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "TokenAccessor.h"

@implementation TokenAccessor
{
    LocalDBHelper *dbHelper;
}

- (instancetype)init{
    if (self = [super init]) {
        dbHelper = [LocalDBHelper shareManager];
    }
    return self;
}

- (BOOL)insertToken:(TokenModel *)model{
    BOOL isSuccess = false;
    if ([dbHelper open]) {
        isSuccess = [dbHelper executeUpdate:INIT_TOKEN_DATA_SCRIPT(model.userId, model.accessToken, model.refreshToken, model.expires)];
        [dbHelper close];
    }
    return isSuccess;
}

- (TokenModel *)readTokenData:(FMResultSet *)resultSet{
    TokenModel *tokenModel;
    tokenModel.uuid = [[resultSet stringForColumn:TOKEN_MODEL_UUID] integerValue];
    tokenModel.userId = [[resultSet stringForColumn:TOKEN_MODEL_USERID] integerValue];
    tokenModel.accessToken = [resultSet stringForColumn:TOKEN_MODEL_ACCESSTOKEN];
    tokenModel.refreshToken = [resultSet stringForColumn:TOKEN_MODEL_REFRESHTOKEN];
    tokenModel.expires = [[resultSet stringForColumn:TOKEN_MODEL_EXPIRES] integerValue];
    return tokenModel;
}
@end
