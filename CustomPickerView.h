//
//  CustomScrollView.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/14.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomPickerView;
@protocol CustomPickerViewDelegate <NSObject>
- (void)canclePickerViewDelegateAction;
- (void)finishPickerViewDelegateAction:(NSArray *)selectArray;
@end
@interface CustomPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *pickView;

@property (copy, nonatomic)NSArray *dataArray;
@property (assign, nonatomic)id<CustomPickerViewDelegate> delegate;
- (void)presentPickerView;
+ (id)instancePickerView;
@end
