//
//  LocalDBHelper.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "LocalDBHelper.h"
#define LOCAL_DATABASE_NAME         @"EasyBlue.db"
#define LOCAL_DATABASE_VERSION      1.0
#define DROP_TABLES_SCRIPT           @""

@implementation LocalDBHelper
{
    FMDatabase *fmDataBase;
    FMDatabaseQueue *fmDataBaseQueue;
}

+(instancetype)shareManager
{
    static LocalDBHelper *share;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        share = [[LocalDBHelper alloc] init];
    });
    return share;
}

-(instancetype)init
{
    if (self = [super init]) {
        NSString *dbPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbFileName =[dbPath stringByAppendingPathComponent:LOCAL_DATABASE_NAME];
        NSLog(@"local DB path is %@",dbFileName);
        fmDataBase = [FMDatabase databaseWithPath:dbFileName];
        fmDataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbFileName];
        [self createtable];
    }
    return self;
}

-(BOOL)open
{
    return [fmDataBase open];
}

-(void)closeWithQueue
{
    [fmDataBaseQueue close];
}

-(BOOL)close
{
    return [fmDataBase close];
}

-(int)intForQuery:(NSString *)sql
{
    return [fmDataBase intForQuery:sql];
}

-(void)intForQueryWithQueue:(NSString *)sql completed:(void(^)(int))completed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
            completed([db intForQuery:sql]);
        }];
    });
}

-(void)intForQueryWithQueue:(NSString *)sql isTransaction:(BOOL)isTransaction completed:(void(^)(int))completed
{
    if (isTransaction) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                completed([db intForQuery:sql]);
            }];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
                completed([db intForQuery:sql]);
            }];
        });
    }
}

-(BOOL)executeUpdate:(NSString *)sql
{
    return [fmDataBase executeUpdate:sql];;
}

-(void)executeUpdateWithQueue:(NSString *)sql completed:(void(^)(BOOL))completed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
            completed([db executeUpdate:sql]);
        }];
    });
}

-(void)executeUpdateWithQueue:(NSString *)sql isTransaction:(BOOL)isTransaction completed:(void(^)(BOOL))completed
{
    if (isTransaction) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                completed([db executeUpdate:sql]);
            }];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
                completed([db executeUpdate:sql]);
            }];
        });
    }
}

-(BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    return [fmDataBase executeUpdate:sql withArgumentsInArray:arguments];
}

-(void)executeUpdateWithQueue:(NSString *)sql withArgumentsInArray:(NSArray *)arguments completed:(void(^)(BOOL))completed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
            completed([db executeUpdate:sql withArgumentsInArray:arguments]);
        }];
    });
}

-(void)executeUpdateWithQueue:(NSString *)sql withArgumentsInArray:(NSArray *)arguments isTransaction:(BOOL)isTransaction completed:(void(^)(BOOL))completed
{
    if (isTransaction) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                completed([db executeUpdate:sql withArgumentsInArray:arguments]);
            }];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
                completed([db executeUpdate:sql withArgumentsInArray:arguments]);
            }];
        });
    }
}

- (BOOL)executeUpdate:(NSString*)sql withParameterDictionary:(NSDictionary *)arguments
{
    return [fmDataBase executeUpdate:sql withParameterDictionary:arguments];
}

-(void)executeUpdateWithQueue:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments completed:(void(^)(BOOL))completed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
            completed([db executeUpdate:sql withParameterDictionary:arguments]);
        }];
    });
}

-(void)executeUpdateWithQueue:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments isTransaction:(BOOL)isTransaction completed:(void(^)(BOOL))completed
{
    if (isTransaction) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                completed([db executeUpdate:sql withParameterDictionary:arguments]);
            }];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
                completed([db executeUpdate:sql withParameterDictionary:arguments]);
            }];
        });
    }
}

-(FMResultSet *)executeQuery:(NSString *)sql
{
    return [fmDataBase executeQuery:sql];
}

-(void)executeQueryWithQueue:(NSString *)sql completed:(void(^)(FMResultSet *))completed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
            completed([db executeQuery:sql]);
        }];
    });
}

-(void)executeQueryWithQueue:(NSString *)sql isTransaction:(BOOL)isTransaction completed:(void(^)(FMResultSet *))completed
{
    if (isTransaction) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                completed([db executeQuery:sql]);
            }];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
                completed([db executeQuery:sql]);
            }];
        });
    }
}

-(FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    return [fmDataBase executeQuery:sql withArgumentsInArray:arguments];
}

-(void)executeQueryWithQueue:(NSString *)sql withArgumentsInArray:(NSArray *)arguments completed:(void(^)(FMResultSet *))completed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
            completed([db executeQuery:sql withArgumentsInArray:arguments]);
        }];
    });
}

-(void)executeQueryWithQueue:(NSString *)sql withArgumentsInArray:(NSArray *)arguments isTransaction:(BOOL)isTransaction completed:(void(^)(FMResultSet *))completed
{
    if (isTransaction) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                completed([db executeQuery:sql withArgumentsInArray:arguments]);
            }];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
                completed([db executeQuery:sql withArgumentsInArray:arguments]);
            }];
        });
    }
}

- (FMResultSet *)executeQuery:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments
{
    return [fmDataBase executeQuery:sql withParameterDictionary:arguments];
}

-(void)executeQueryWithQueue:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments completed:(void(^)(FMResultSet *))completed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
            completed([db executeQuery:sql withParameterDictionary:arguments]);
        }];
    });
}

-(void)executeQueryWithQueue:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments isTransaction:(BOOL)isTransaction completed:(void(^)(FMResultSet *))completed
{
    if (isTransaction) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                completed([db executeQuery:sql withParameterDictionary:arguments]);
            }];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fmDataBaseQueue inDatabase:^(FMDatabase *db) {
                completed([db executeQuery:sql withParameterDictionary:arguments]);
            }];
        });
    }
}

-(void)createtable
{
    if ([fmDataBase open]) {
        //设置版本
        [fmDataBase setUserVersion:LOCAL_DATABASE_VERSION];
        if (/* DISABLES CODE */ (1)==2) {
            //drop table
            //            [fmDataBase executeUpdate:DROP_USERINFO_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_TOKEN_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_SURVEY_COUNT_STANDARD_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_MEMBER_DEVICE_INFO_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_FAMILY_MEMBER_INFO_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_DEVICE_INFO_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_BGDATA_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_BPDATA_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_ALARM_DATA_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_INTERGRAL_DETAIL_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_MEDICINE_ROCORD_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_MESSAGE_DATA_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_SOFTVERSION_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_TOTAL_INTEGRAL_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_MEMBER_INTEGRAL_TABLE_SCRIPT];
            //            [fmDataBase executeUpdate:DROP_COOKBOOK_DATA_TABLE_SCRIPT];
        }
        
        //create table
        [fmDataBase executeUpdate:CREATE_USERINFO_TABLE_SCRIPT];
        [fmDataBase executeUpdate:CREATE_TOKEN_TABLE_SCRIPT];
        [fmDataBase executeUpdate:CREATE_HEALTH_DATA_TABLE_SCRIPT];
        [fmDataBase executeUpdate:CREATE_FAMILY_MEMBER_INFO_TABLE_SCRIPT];
        [fmDataBase close];
    }
}

@end
