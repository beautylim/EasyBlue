//
//  LocalDBHelper.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLScript.h"
#import <FMDB.h>

@interface LocalDBHelper : NSObject

/**
 *  @author Calvin, 16-02-04 15:02:47
 *
 *  操作本地DB的单例对象,请使用此对象
 *
 *  @return <#return value description#>
 */
+(instancetype)shareManager;

/**
 *  @author Calvin, 16-02-04 15:02:25
 *
 *  此处方法为非线程安全方法 ，简单DB操作可使用
 *
 *  @param sql <#sql description#>
 *
 *  @return <#return value description#>
 */
- (int)intForQuery:(NSString *)sql;
- (BOOL)executeUpdate:(NSString*)sql;
- (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments;
- (BOOL)executeUpdate:(NSString*)sql withParameterDictionary:(NSDictionary *)arguments;
- (FMResultSet *)executeQuery:(NSString*)sql;
- (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;
- (FMResultSet *)executeQuery:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments;
-(BOOL)open;
-(BOOL)close;

/**
 *  @author Calvin, 16-02-04 15:02:00
 *
 *  此处方法为线程安全方法，如若在多线程中操作DB 必须使用此处方法
 *
 *  @param sql       <#sql description#>
 *  @param completed <#completed description#>
 */
- (void)intForQueryWithQueue:(NSString *)sql completed:(void(^)(int))completed;
- (void)executeUpdateWithQueue:(NSString*)sql completed:(void(^)(BOOL))completed;
- (void)executeUpdateWithQueue:(NSString*)sql withArgumentsInArray:(NSArray *)arguments completed:(void(^)(BOOL))completed;
- (void)executeUpdateWithQueue:(NSString*)sql withParameterDictionary:(NSDictionary *)arguments completed:(void(^)(BOOL))completed;
- (void)executeQueryWithQueue:(NSString*)sql completed:(void(^)(FMResultSet *))completed;
- (void)executeQueryWithQueue:(NSString *)sql withArgumentsInArray:(NSArray *)arguments completed:(void(^)(FMResultSet *))completed;
- (void)executeQueryWithQueue:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments completed:(void(^)(FMResultSet *))completed;

/**
 *  @author Calvin, 16-02-04 15:02:23
 *
 *  此处方法为带事物的线程安全方法，如若多表操作 建议使用事物 可保证数据的完整性
 *
 *  @param sql           <#sql description#>
 *  @param isTransaction <#isTransaction description#>
 *  @param completed     <#completed description#>
 */
- (void)intForQueryWithQueue:(NSString *)sql isTransaction:(BOOL)isTransaction completed:(void(^)(int))completed;
- (void)executeUpdateWithQueue:(NSString*)sql isTransaction:(BOOL)isTransaction completed:(void(^)(BOOL))completed;
- (void)executeUpdateWithQueue:(NSString*)sql withArgumentsInArray:(NSArray *)arguments isTransaction:(BOOL)isTransaction completed:(void(^)(BOOL))completed;
- (void)executeUpdateWithQueue:(NSString*)sql withParameterDictionary:(NSDictionary *)arguments isTransaction:(BOOL)isTransaction completed:(void(^)(BOOL))completed;
- (void)executeQueryWithQueue:(NSString*)sql isTransaction:(BOOL)isTransaction completed:(void(^)(FMResultSet *))completed;
- (void)executeQueryWithQueue:(NSString *)sql withArgumentsInArray:(NSArray *)arguments isTransaction:(BOOL)isTransaction completed:(void(^)(FMResultSet *))completed;
- (void)executeQueryWithQueue:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments isTransaction:(BOOL)isTransaction completed:(void(^)(FMResultSet *))completed;

-(void)closeWithQueue;
@end
