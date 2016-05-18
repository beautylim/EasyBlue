//
//  HealthDataModel.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HEALTHDATA_MODEL_UUID @"uuid"
#define HEALTHDATA_MODEL_SERVERID @"serverId"
#define HEALTHDATA_MODEL_USERID @"userId"
#define HEALTHDATA_MODEL_SHALLOWSLEEPTIME @"shallowSleepTime"
#define HEALTHDATA_MODEL_WALKTIME @"walkTime"
#define HEALTHDATA_MODEL_DEEPSLEEPTIME @"deepSleepTime"
#define HEALTHDATA_MODEL_RUNTIME @"runTime"
#define HEALTHDATA_MODEL_WALKDISTANCE @"walkDistance"
#define HEALTHDATA_MODEL_RUNDISTANCE @"runDistance"
#define HEALTHDATA_MODEL_CALORIE @"calorie"
#define HEALTHDATA_MODEL_SLEEPENDTIME @"sleepEndTime"
#define HEALTHDATA_MODEL_SLEEPSTARTTIME @"sleepStartTime"
#define HEALTHDATA_MODEL_RUNCALORIE @"runCalorie"
#define HEALTHDATA_MODEL_WAKETIME @"wakeTime"
#define HEALTHDATA_MODEL_STEP @"step"
#define HEALTHDATA_MODEL_UPLOADTIME @"uploadTime"
@interface HealthDataModel : NSObject
@property (assign, nonatomic) NSInteger uuid;
@property (assign, nonatomic) NSInteger serverId;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger shallowSleepTime;
@property (assign, nonatomic) NSInteger walkTime;
@property (assign, nonatomic) NSInteger deepSleepTime;
@property (assign, nonatomic) NSInteger runTime;
@property (assign, nonatomic) NSInteger walkDistance;
@property (assign, nonatomic) NSInteger runDistance;
@property (assign, nonatomic) NSInteger calorie;
@property (assign, nonatomic) NSInteger sleepEndTime;
@property (assign, nonatomic) NSInteger sleepStartTime;
@property (assign, nonatomic) NSInteger runCalorie;
@property (assign, nonatomic) NSInteger wakeTime;
@property (assign, nonatomic) NSInteger step;
@property (assign, nonatomic) NSInteger uploadTime;
@end
