//
//  CustomDatePickerView.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/15.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "CustomDatePickerView.h"

@implementation CustomDatePickerView

static CustomDatePickerView *instance = nil;
+ (id)instanceDatePickerView{
    @synchronized(self) {
        instance = [[[NSBundle mainBundle] loadNibNamed:@"CustomDatePickerView" owner:nil options:nil] lastObject];
        instance.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 220);
    }
    return instance;
}

- (IBAction)finishDatePickerAction:(id)sender {
    [UIView animateWithDuration:ANIMATION_CUSTOM_PICKVIEW_DURATION animations:^{
        self.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 220);
    }];
    NSDate *selectDate = [_datePicker date];
    NSString *selectStr = [Common convertDateToString:DATEPICKERVIEW_FORMATER withDate:selectDate];
    if ([self.delegate respondsToSelector:@selector(finishDatePickerViewAction:)]) {
        [self.delegate finishDatePickerViewAction:selectStr];
    }
}
- (IBAction)cancleDatepickerAction:(id)sender {
    [UIView animateWithDuration:ANIMATION_CUSTOM_PICKVIEW_DURATION animations:^{
        self.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 220);
    }];
    if ([self.delegate respondsToSelector:@selector(cancleDatePickerViewAction)]) {
        [self.delegate cancleDatePickerViewAction];
    }
}

- (void)presentDatePickerView{
    [UIView animateWithDuration:ANIMATION_CUSTOM_PICKVIEW_DURATION animations:^{
        self.frame = CGRectMake(0, SCREEN_Height - 220, SCREEN_Width, 220);
    }];
}
@end
