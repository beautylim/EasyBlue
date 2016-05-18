//
//  FamilyMemberModel.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FAMILY_MEMBER_MODEL_UUID @"uuid"
#define FAMILY_MEMBER_MODEL_SERVERID @"serverId"
#define FAMILY_MEMBER_MODEL_USERID @"userId"
#define FAMILY_MEMBER_MODEL_NAME @"name"
#define FAMILY_MEMBER_MODEL_PORTRAITURL @"portraitUrl"
#define FAMILY_MEMBER_MODEL_PROVINCEID @"provinceId"
#define FAMILY_MEMBER_MODEL_GENDER @"gender"
#define FAMILY_MEMBER_MODEL_BORNDATE @"bornDate"
#define FAMILY_MEMBER_MODEL_TEL @"tel"
#define FAMILY_MEMBER_MODEL_UPDATETIME @"updateTime"

@interface FamilyMemberModel : NSObject
@property (assign, nonatomic) NSInteger uuid;
@property (assign, nonatomic) NSInteger serverId;
@property (assign, nonatomic) NSInteger userId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *portraitUrl;
@property (assign, nonatomic) NSInteger provinceId;
@property (assign, nonatomic) NSInteger gender;
@property (assign, nonatomic) long bornDate;
@property (copy, nonatomic) NSString *tel;
@property (assign, nonatomic) long updateTime;
@end
