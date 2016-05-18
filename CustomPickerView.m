//
//  CustomScrollView.m
//  EasyBlue
//
//  Created by 李敏 on 16/3/14.
//  Copyright © 2016年 limin. All rights reserved.
//

#import "CustomPickerView.h"

@implementation CustomPickerView
{
    NSMutableArray *selectArray;
}
static CustomPickerView *instance = nil;
+ (id)instancePickerView{
    @synchronized(self) {
        
            instance = [[[NSBundle mainBundle]loadNibNamed:@"CustomPickerView" owner:nil options:nil] lastObject];
            instance.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 220);
        
    }
    
    return instance;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [_pickView reloadAllComponents];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
        return [_dataArray count];
 }

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return SCREEN_Width ;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_dataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (selectArray == nil) {
        [self initSelectArray];
    }
    selectArray[0] = @(row);
}

- (void)initSelectArray{
    selectArray = [NSMutableArray array];
}

- (IBAction)cancleAction:(id)sender {
    [UIView animateWithDuration:ANIMATION_CUSTOM_PICKVIEW_DURATION animations:^{
        self.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 220);
    }];
    if ([self.delegate respondsToSelector:@selector(canclePickerViewDelegateAction)]) {
        [self.delegate canclePickerViewDelegateAction];
    }
}

- (IBAction)finishAction:(id)sender {
    [UIView animateWithDuration:ANIMATION_CUSTOM_PICKVIEW_DURATION animations:^{
        self.frame = CGRectMake(0, SCREEN_Height, SCREEN_Width, 220);
    }];
    if ([self.delegate respondsToSelector:@selector(finishPickerViewDelegateAction:)]) {
        [self.delegate finishPickerViewDelegateAction:selectArray];
    }
}

- (void)presentPickerView{
    [UIView animateWithDuration:ANIMATION_CUSTOM_PICKVIEW_DURATION animations:^{
        self.frame = CGRectMake(0, SCREEN_Height - 220, SCREEN_Width, 220);
    }];
}
@end
