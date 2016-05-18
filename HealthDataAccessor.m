//
//  HealthDataAccessor.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "HealthDataAccessor.h"

@implementation HealthDataAccessor
{
    LocalDBHelper *dbHelper;
}

- (instancetype)init{
    if (self = [super init]) {
        dbHelper = [LocalDBHelper shareManager];
    }
    return self;
}

- (BOOL)insertHealthData:(HealthDataModel *)model{
    BOOL isSuccess = false;
    if ([dbHelper open]) {
        isSuccess = [dbHelper executeUpdate:INIT_HEALTH_DATA_DATA_SCRIPT(model.serverId, model.userId, model.shallowSleepTime ,model.walkTime,model.deepSleepTime ,model.runTime,model.walkDistance ,model.runDistance,model.calorie,model.sleepEndTime,model.sleepStartTime,model.runCalorie,model.wakeTime,model.step ,model.uploadTime)];
        [dbHelper close];
    }
    return isSuccess;
}

- (HealthDataModel *)readHealthData:(FMResultSet *)resultSet{
    HealthDataModel *healthDataModel;
    healthDataModel.uuid = [[resultSet stringForColumn:HEALTHDATA_MODEL_UUID] integerValue];
    healthDataModel.serverId = [[resultSet stringForColumn:HEALTHDATA_MODEL_SERVERID] integerValue];
    healthDataModel.userId = [[resultSet stringForColumn:HEALTHDATA_MODEL_USERID] integerValue];
    healthDataModel.shallowSleepTime = [[resultSet stringForColumn:HEALTHDATA_MODEL_SHALLOWSLEEPTIME] integerValue];
    healthDataModel.walkTime = [[resultSet stringForColumn:HEALTHDATA_MODEL_WALKTIME] integerValue];
    healthDataModel.wakeTime = [[resultSet stringForColumn:HEALTHDATA_MODEL_WAKETIME] integerValue];
    healthDataModel.deepSleepTime = [[resultSet stringForColumn:HEALTHDATA_MODEL_DEEPSLEEPTIME] integerValue];
    healthDataModel.runTime = [[resultSet stringForColumn:HEALTHDATA_MODEL_RUNTIME] integerValue];
    healthDataModel.walkDistance = [[resultSet stringForColumn:HEALTHDATA_MODEL_WALKDISTANCE] integerValue];
    healthDataModel.runDistance = [[resultSet stringForColumn:HEALTHDATA_MODEL_RUNDISTANCE] integerValue];
    healthDataModel.calorie = [[resultSet stringForColumn:HEALTHDATA_MODEL_CALORIE] integerValue];
    healthDataModel.sleepEndTime = [[resultSet stringForColumn:HEALTHDATA_MODEL_SLEEPENDTIME] integerValue];
    healthDataModel.sleepStartTime = [[resultSet stringForColumn:HEALTHDATA_MODEL_SLEEPSTARTTIME] integerValue];
    healthDataModel.runCalorie = [[resultSet stringForColumn:HEALTHDATA_MODEL_RUNCALORIE] integerValue];
    healthDataModel.step = [[resultSet stringForColumn:HEALTHDATA_MODEL_STEP] integerValue];
    healthDataModel.uploadTime = [[resultSet stringForColumn:HEALTHDATA_MODEL_UPLOADTIME] integerValue];
    return healthDataModel;
}

@end
