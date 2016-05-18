//
//  UserInfo.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/17.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
- (instancetype)initUserInfo:(NSInteger)uid gender:(NSInteger)gender age:(NSInteger)age height:(NSInteger)height weight:(NSInteger)weight alias:(NSString *)alias type:(NSInteger)type{
    self = [super init];
    _uid = uid;
    _gender = (Byte)gender;
    _age = (Byte)age;
    _height = (Byte) (height & 0xFF);
    _weight = (Byte)weight;
    _alias = alias;
    _type = (Byte)type;
    return self;

}
//            UserInfo *userInfo = [[UserInfo alloc]initUserInfo:20271234 gender:1 age:32 height:160 weight:40 alias:@"1哈哈" type:0];
//            NSString *address = @"88:0F:10:76:83:FC";

- (NSData *)getBytes:(NSString *)mBTAddress{
    
    NSData *bytes = [_alias dataUsingEncoding:NSUTF8StringEncoding];
    Byte *aliasBytes = (Byte *)[bytes bytes];
    NSMutableData *bf = [[NSMutableData alloc]init];
    Byte first[1];
    first[0] = (Byte)(_uid & 0xff);
    [bf appendBytes:first length:sizeof(first)];
    Byte second[1];
    second[0] = (Byte)(_uid >> 8 & 0xff);
    [bf appendBytes:second length:sizeof(second)];
    Byte third[1];
    third[0] = (Byte)(_uid >> 16 & 0xff);
    [bf appendBytes:third length:sizeof(third)];
    Byte fourth[1];
    fourth[0] = (Byte)(_uid >> 24 & 0xff);
    [bf appendBytes:fourth length:sizeof(fourth)];
    Byte fifth[1];
    fifth[0]= (Byte)(_gender);
    [bf appendBytes:fifth length:sizeof(fifth)];
    Byte sixth[1];
    sixth[0] = (Byte)(_age);
    [bf appendBytes:sixth length:sizeof(sixth)];
    Byte seventh[1];
    seventh[0] = (Byte)(_height);
    [bf appendBytes:seventh length:sizeof(seventh)];
    Byte eighth[1];
    eighth[0] = (Byte)(_weight);
    [bf appendBytes:eighth length:sizeof(eighth)];
    Byte ninth[1];
    ninth[0] = (Byte)(_type);
    [bf appendBytes:ninth length:sizeof(ninth)];
    Byte tenth[1];
    tenth[0] = (Byte)4;
    [bf appendBytes:tenth length:sizeof(tenth)];
    Byte eleventh[1];
    eleventh[0] = (Byte)0;
    [bf appendBytes:&eleventh length:sizeof(eleventh)];
    if (sizeof(aliasBytes) <= 8 ) {
        [bf appendBytes:aliasBytes length:sizeof(aliasBytes)];
        Byte newByte = (Byte)(8 - sizeof(aliasBytes));
        [bf appendBytes:&newByte length:sizeof(newByte)];
    }else {
        [bf appendBytes:aliasBytes length:8];
    }
    Byte crcSequence[19];
    Byte *bfBytes = (Byte *)[bf bytes];
    for (int i =0 ; i < sizeof(crcSequence); i++) {
        crcSequence[i] = bfBytes[i];
    }
    Byte crcb = (Byte)(([self getCRC8:crcSequence] ^ ([[mBTAddress substringFromIndex:(mBTAddress.length - 2)] integerValue] & 0xff))& 0xff);
    Byte crcdArray[1];
    crcdArray[0] = crcb;
    [bf appendBytes:crcdArray length:sizeof(crcdArray)];
    return bf;
}

- (int)getCRC8:(Byte[])seq{
    int len = 19;
    int i = 0;
    Byte crc = 0x00;
    
    while (len-- > 0) {
        Byte extract = seq[i++];
        for (Byte tempI = 8; tempI !=0; tempI--) {
            Byte sum = (Byte) ((crc & 0xff)^ (extract & 0xff));
            sum = (Byte) ((sum & 0xff) & 0x01);
            crc = (Byte) ((crc & 0xff) >> 1);
            if (sum != 0 ) {
                crc = (Byte) ((crc & 0xff)^ 0x8c);
            }
            extract = (Byte) ((extract & 0xff) >> 1);
        }
    }
    return (crc & 0xff);
}


@end
