//
//  UserInfo.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/17.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) Byte gender;
@property (assign, nonatomic) Byte age;
@property (assign, nonatomic) Byte height;
@property (assign, nonatomic) Byte weight;
@property (copy, nonatomic) NSString *alias;
@property (assign, nonatomic) Byte type;

- (instancetype)initUserInfo:(NSInteger) uid
                      gender:(NSInteger)gender
                         age:(NSInteger)age
                      height:(NSInteger)height
                      weight:(NSInteger)weight
                       alias:(NSString *)alias
                        type:(NSInteger)type;

- (NSData *) getBytes:(NSString *)mBTAddress;
@end
