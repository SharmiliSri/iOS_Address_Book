//
//  DPDatePickerVew.m
//  DatePicker
//
//  Created by Sharmili S on 31/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import "DPDatePickerView.h"


@implementation DPDatePickerView

@synthesize months;
@synthesize years = _years;

#pragma mark -
#pragma mark UIPickerView Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.months = [self nameOfMonths];
        self.years = [self nameOfYears];
        
        self.delegate = self;
        self.dataSource = self;
        
        [self setdate:[NSDate date]
                     :NO
                     :NO];
        
    }
    return self;
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return 31000;
        case 1:
            return [self.months count]*1000;
        case 2:
            return [self.years count];
    }
    return 0;
}

#pragma mark -
#pragma mark UIPickerViewDelegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) // days
        return [NSString stringWithFormat:@"%i",(int)row % 31 + 1];
    else if (component == 1) // month
    {
        NSInteger monthCount = [self.months count];
        return [self.months objectAtIndex:(row % monthCount)];
    }
    else
    {
        NSInteger yearCount = [self.years count];
        return [self.years objectAtIndex:(row % yearCount)];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    int n=[self validity];
    if(n !=0)
        [self setLastdate:n];
    [self todatecheck];
    static NSString *const CSDataUpdatedNotification = @"CSDataUpdatedNotification";
    [[NSNotificationCenter defaultCenter] postNotificationName:CSDataUpdatedNotification object:self];
}


#pragma mark -
#pragma mark Local Methods: Array initialize

-(NSArray *)nameOfMonths
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    return [dateFormatter shortStandaloneMonthSymbols];
}

-(NSArray *)nameOfYears
{
    NSMutableArray *years = [NSMutableArray array];
    
    for(NSInteger year = 1900; year <= [self currentYear]; year++)
    {
        NSString *yearStr = [NSString stringWithFormat:@"%i", year];
        [years addObject:yearStr];
    }
    [years addObject:@"----"];
    return years;
}

#pragma mark -
#pragma mark Local Methods

-(NSInteger)currentYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return [[formatter stringFromDate:[NSDate date]] intValue];
}

-(void) todatecheck
{
    NSString *year = [self.years objectAtIndex:([self selectedRowInComponent:2] % [self.years count])];
    if(![year  isEqual: @"----"])
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MMM-yyyy"];
        NSString *month = [self.months objectAtIndex:([self selectedRowInComponent:1] % [self.months count])];
        NSString *date=[NSString stringWithFormat:@"%i",([self selectedRowInComponent:0] % 31 + 1)];
        NSDate *cmp_date=[formatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@",date,month,year]];
        if([cmp_date compare:[NSDate date]] == NSOrderedDescending)
            [self setdate:[NSDate date]
                         :YES
                         :YES];
        
    }
}

-(void)setdate:(NSDate*)date
              :(BOOL) Animated
              :(BOOL) retain
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *cell,*ref;
    NSInteger row;

    //date
    [formatter setDateFormat:@"dd"];
    row= [[formatter stringFromDate:date] intValue]-1;
    row=row+31000/2;
    [self selectRow: row
        inComponent: 0
           animated: Animated];
    
    //month
    [formatter setDateFormat:@"MMM"];
    ref = [formatter stringFromDate:date];
    for(cell in self.months)
    {
        if([cell isEqualToString:ref])
        {
            row = [self.months indexOfObject:cell];
            row=row+[self.months count]  *500;
            break;
        }
    }
    
    [self selectRow: row
        inComponent: 1
           animated: Animated];
    
    //year
    if(!retain)
        [self selectRow: ([self.years count]-1)
            inComponent: 2
               animated: Animated];
    else
    {
        [formatter setDateFormat:@"YYYY"];
        ref = [formatter stringFromDate:date];
        for(cell in self.years)
        {
            if([cell isEqualToString:ref])
            {
                row = [self.years indexOfObject:cell];
                break;
            }
        }
        
        [self selectRow: row
            inComponent: 2
               animated: Animated];
    }
    
}

-(void) setLastdate: (NSInteger) n
{
    int row=(n-1)+31000/2;
    [self selectRow: row
        inComponent: 0
           animated: YES];
    
}

-(int) validity
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSString *year = [self.years objectAtIndex:([self selectedRowInComponent:2] % [self.years count])];
    
    if([year  isEqual: @"----"])
    {
        [formatter setDateFormat:@"yyyy"];
        year=[formatter stringFromDate:[NSDate date]];
    }
    
    [formatter setDateFormat:@"MMM"];
    NSString *month = [self.months objectAtIndex:([self selectedRowInComponent:1] % [self.months count])];
    
    [formatter setDateFormat:@"MMM-yyyy"];
    NSDate *cmp_date=[formatter dateFromString:[NSString stringWithFormat:@"%@-%@",month,year]];
    
    int max_days=[[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                    inUnit:NSMonthCalendarUnit
                                                   forDate:cmp_date].length;
    
    if(([self selectedRowInComponent:0] % 31 + 1) > max_days)
        return max_days;
    return 0;
    
}

-(NSString *)seldate
{
    NSString *date = [NSString stringWithFormat:@"%i",(int)[self selectedRowInComponent:0] % 31 + 1];
    
    NSInteger monthCount = [self.months count];
    NSString *month = [self.months objectAtIndex:([self selectedRowInComponent:1] % monthCount)];
    
    NSInteger yearCount = [self.years count];
    NSString *year = [self.years objectAtIndex:([self selectedRowInComponent:2] % yearCount)];
    
    if(![year  isEqual: @"----"])
        return [NSString stringWithFormat:@"%@-%@-%@",date,month,year];
    return [NSString stringWithFormat:@"%@-%@",date,month];
    
}

@end