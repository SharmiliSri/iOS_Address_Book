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

@interface ABTAddViewController : UIViewController
{
UILabel *LName,*LPNO,*LMail,*LDOB;
UITextField *TFName,*TFPNO,*TFMail,*TFDOB;
UIButton *submit;
UIDatePicker *DOB;
NSIndexPath *Ipath;

ABTModel *sharedmodel;

}

@property (nonatomic,assign) id <ABTDelegateFile> delegate;
@property NSIndexPath *Ipath;

-(void) addContact:(id) sender;
-(BOOL) validate;
-(void) invaidFormat:(UITextField *)tf;
-(void) fieldFormatSet:(UITextField *)tf;
-(void)phtextFieldDidChange:(UITextField *)tf;
-(void) mailtextFieldDidChange:(UITextField *)tf;
-(void) nameNotEntered:(UITextField *)tf;
-(void) updateContact:(id) sender;

@end
