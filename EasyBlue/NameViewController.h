//
//  NameViewController.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/14.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NameViewController;
@protocol NameDelegate <NSObject>
- (void)nameDelegateAction:(NSString*)nameStr;
@end
@interface NameViewController : UIViewController
@property (assign,nonatomic)id<NameDelegate>delegate;
@property (copy,nonatomic)NSString *nameStr;
@property (assign, nonatomic)NameVCType nameType;
@end
