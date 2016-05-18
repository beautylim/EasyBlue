//
//  InitilLocalData.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#ifndef InitilLocalData_h
#define InitilLocalData_h

#define INIT_USER_INFO_DATA_SCRIPT(serverId,name,gender,bornDate,portraitUrl,provinceId,tel,updateTime) [NSString stringWithFormat:@"INSERT INTO UserInfo (serverId,name,gender,bornDate,portraitUrl,provinceId,tel,updateTime) VALUES (%ld,'%@',%ld,%ld,'%@',%ld,'%@',%ld) ",serverId,name,gender,bornDate,portraitUrl,provinceId,tel,updateTime]

#define INIT_TOKEN_DATA_SCRIPT(userId,accessToken,refreshToken,expires) [NSString stringWithFormat:@"INSERT INTO UserInfo (userId,accessToken,refreshToken,expires) VALUES (%ld,'%@','%@',%ld) ",userId,accessToken,refreshToken,expires]

#define INIT_FAMILY_MEMBER_INFO_DATA_SCRIPT(serverId,userId,name,portraitUrl,provinceId,gender,bornDate,tel,updateTime) [NSString stringWithFormat:@"INSERT INTO UserInfo (serverId,userId,name,portraitUrl,provinceId,gender,bornDate,tel,updateTime) VALUES (%ld,%ld,'%@','%@',%ld,%ld,%ld,'%@',%ld) ",serverId,userId,name,portraitUrl,provinceId,gender,bornDate,tel,updateTime]

#define INIT_HEALTH_DATA_DATA_SCRIPT(serverId,userId,shallowSleepTime,walkTime,deepSleepTime,runTime,walkDistance,runDistance,calorie,sleepEndTime,sleepStartTime,runCalorie,wakeTime,step,uploadTime) [NSString stringWithFormat:@"INSERT INTO UserInfo (serverId,userId,shallowSleepTime,walkTime,deepSleepTime,runTime,walkDistance,runDistance,calorie,sleepEndTime,sleepStartTime,runCalorie,wakeTime,step,uploadTime) VALUES (%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld) ",serverId,userId,shallowSleepTime,walkTime,deepSleepTime,runTime,walkDistance,runDistance,calorie,sleepEndTime,sleepStartTime,runCalorie,wakeTime,step,uploadTime]



#endif /* InitilLocalData_h */
