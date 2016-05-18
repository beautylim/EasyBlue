//
//  FamilyMemberAccessor.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalDBHelper.h"
#import "FamilyMemberModel.h"

@interface FamilyMemberAccessor : NSObject

- (BOOL)insertFamilyMember:(FamilyMemberModel *)model;
@end
