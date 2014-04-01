//
//  DPDatePickerView.h
//  DatePicker
//
//  Created by Sharmili S on 31/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPDatePickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSArray *years;

-(NSArray *)nameOfMonths;
-(NSArray *)nameOfYears;

-(NSInteger)currentYear;
-(void) todatecheck;
-(void)setdate:(NSDate*)date
              :(BOOL) Animated
              :(BOOL) retain;
-(void) setLastdate: (NSInteger) n;
-(int) validity;
-(NSString *)seldate;

@end
