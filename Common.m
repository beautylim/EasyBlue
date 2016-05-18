//
//  Common.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "Common.h"

@implementation Common
+ (void)UserDefaultSetObject:(NSString *)value forKey:(NSString *)key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:key];
}

+ (NSString *)UserDefaultGetObjectforKey:(NSString *)key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault valueForKey:key];
}

+ (NSString *)convertDateToString:(NSString *)format withDate:(NSDate *)dateValue{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:dateValue];
}

+ (double)convertStringToTimeInterval:(NSString *)format withStr:(NSString *)strValue{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    NSDate *convertDate = [dateFormat dateFromString:strValue];
    return [convertDate timeIntervalSince1970];
}
@end
