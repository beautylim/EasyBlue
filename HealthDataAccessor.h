//
//  HealthDataAccessor.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthDataModel.h"
#import "LocalDBHelper.h"

@interface HealthDataAccessor : NSObject
- (BOOL)insertHealthData:(HealthDataModel *)model;
@end
