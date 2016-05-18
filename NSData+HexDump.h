//
//  NSData+HexDump.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/18.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HexDump)
- (NSString *)hexval;
- (NSString *)hexdump;
@end
