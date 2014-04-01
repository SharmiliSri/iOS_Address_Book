//
//  ABTAddViewController.h
//  Addr
//
//  Created by Sharmili S on 20/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTModel.h"
#import "ABTDelegateFile.h"
#import "DPDatePickerView.h"

@interface ABTAddViewController : UIViewController<UITextFieldDelegate>
{
UILabel *LName,*LPNO,*LMail,*LDOB;
UITextField *TFName,*TFPNO,*TFMail,*TFDOB;
UIButton *submit;
//UIDatePicker *DOB;
DPDatePickerView *DPDPV;
NSIndexPath *Ipath;

BOOL TFtouch;
ABTModel *sharedmodel;

}

@property (nonatomic,assign) id <ABTDelegateFile> delegate;
@property NSIndexPath *Ipath;

-(void) addContact:(id) sender;
-(void) updateContact:(id) sender;
-(void)DOBChange;

-(void) nameNotEntered:(UITextField *)tf;
-(void)phtextFieldDidChange:(UITextField *)tf;
-(void) mailtextFieldDidChange:(UITextField *)tf;
-(BOOL) validate;

-(void) invaidFormat:(UITextField *)tf;
-(void) fieldFormatSet:(UITextField *)tf;

@end
