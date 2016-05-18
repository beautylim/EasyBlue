//
//  UserInfoModel.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USERINFO_MODEL_UUID @"uuid"
#define USERINFO_MODEL_SERVERID @"serverId"
#define USERINFO_MODEL_NAME @"name"
#define USERINFO_MODEL_GENDER @"gender"
#define USERINFO_MODEL_BORNDATE @"bornDate"
#define USERINFO_MODEL_PORTRAITURL @"portraitUrl"
#define USERINFO_MODEL_PROVINCEID @"provinceId"
#define USERINFO_MODEL_TEL @"tel"
#define USERINFO_MODEL_UPDATETIME @"updateTime"

@interface UserInfoModel : NSObject
@property (assign, nonatomic) NSInteger uuid;
@property (assign, nonatomic) NSInteger serverId;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger gender;
@property (assign, nonatomic) long bornDate;
@property (copy, nonatomic) NSString *portraitUrl;
@property (assign, nonatomic) NSInteger provinceId;
@property (copy, nonatomic)NSString *tel;
@property (assign, nonatomic) long updateTime;
@end
