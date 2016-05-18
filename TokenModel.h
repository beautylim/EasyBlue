//
//  TokenModel.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TOKEN_MODEL_UUID @"uuid"
#define TOKEN_MODEL_USERID @"userId"
#define TOKEN_MODEL_ACCESSTOKEN @"accessToken"
#define TOKEN_MODEL_REFRESHTOKEN @"refreshToken"
#define TOKEN_MODEL_EXPIRES @"expires"

@interface TokenModel : NSObject
@property (assign, nonatomic) NSInteger uuid;
@property (assign, nonatomic) NSInteger userId;
@property (copy, nonatomic) NSString *accessToken;
@property (copy, nonatomic) NSString *refreshToken;
@property (assign, nonatomic) long expires;
@end
