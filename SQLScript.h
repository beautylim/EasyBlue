//
//  SQLScript.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#ifndef SQLScript_h
#define SQLScript_h

//table UserInfo
#define CREATE_USERINFO_TABLE_SCRIPT    @"CREATE TABLE IF NOT EXISTS UserInfo (uuid integer PRIMARY KEY AUTOINCREMENT, serverId integer, name text, gender integer, bornDate long, portraitUrl text, provinceId integer, tel text, updatetime long)"

//Token
#define CREATE_TOKEN_TABLE_SCRIPT   @"CREATE TABLE IF NOT EXISTS Token(uuid integer primary key autoincrement, userId integer, accessToken text, refreshToken text, expires long)"

//table FamilyMemberInfo
#define CREATE_FAMILY_MEMBER_INFO_TABLE_SCRIPT   @"CREATE TABLE IF NOT EXISTS FamilyMemberInfo(uuid integer PRIMARY KEY AUTOINCREMENT,serverId integer,userId integer, name text ,portraitUrl text ,provinceId integer ,gender integer, bornDate long,tel text, updateTime long)"

//table HealthData
#define CREATE_HEALTH_DATA_TABLE_SCRIPT    @"CREATE TABLE IF NOT EXISTS HealthData (uuid integer PRIMARY KEY AUTOINCREMENT,serverId integer ,userId integer ,shallowSleepTime integer, walkTime integer, deepSleepTime integer, runTime integer, walkDistance integer, runDistance integer, calorie integer,sleepEndTime long,sleepStartTime long,runCalorie integer, wakeTime long, step integer, uploadTime long)"

#endif /* SQLScript_h */
