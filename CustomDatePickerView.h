//
//  CustomDatePickerView.h
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomDatePickerView;
@protocol DatePickerViewDelegate <NSObject>

- (void)cancleDatePickerViewAction;
- (void)finishDatePickerViewAction:(NSString *)datePickerResult;
@end
@interface CustomDatePickerView : UIView
@property (weak, nonatomic) id<DatePickerViewDelegate>delegate;
@property (assign, nonatomic) IBOutlet UIDatePicker *datePicker;
+ (id)instanceDatePickerView;
- (void)presentDatePickerView;
@end
