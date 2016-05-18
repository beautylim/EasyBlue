//
//  Common.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/10.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject
+ (void)UserDefaultSetObject:(NSString *)value forKey:(NSString *)key;
+ (NSString *)UserDefaultGetObjectforKey:(NSString *)key;
+ (NSString *)convertDateToString:(NSString *)format withDate:(NSDate *)dateValue;
+ (double)convertStringToTimeInterval:(NSString *)format withStr:(NSString *)strValue;
@end
