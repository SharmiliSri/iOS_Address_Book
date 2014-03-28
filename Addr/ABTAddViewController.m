//
//  ABTAddViewController.m
//  Addr
//
//  Created by Sharmili S on 20/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import "ABTAddViewController.h"

@interface ABTAddViewController ()

@end

@implementation ABTAddViewController
@synthesize Ipath;

#pragma mark -
#pragma mark UIViewController Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    self.view.backgroundColor=UIColor.whiteColor;
    
    sharedmodel = [ABTModel sharedModel];
    
    LName=[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 100, 31)];
    [LName setText:@"Name:"];
    
    LPNO=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 31)];
    [LPNO setText:@"Phone:"];
    
    LMail=[[UILabel alloc] initWithFrame:CGRectMake(20, 160, 100, 31)];
    [LMail setText:@"EMail:"];
    
    LDOB=[[UILabel alloc] initWithFrame:CGRectMake(20, 200, 100, 31)];
    [LDOB setText:@"DOB:"];
    
    TFName=[[UITextField alloc] initWithFrame:CGRectMake(100, 80, 200, 31)];
    [TFName setBorderStyle:UITextBorderStyleRoundedRect];
    [TFName addTarget:self action:@selector(nameNotEntered:) forControlEvents:UIControlEventEditingChanged];
    TFName.delegate=self;
    
    TFPNO=[[UITextField alloc] initWithFrame:CGRectMake(100, 120, 200, 31)];
    [TFPNO setBorderStyle:UITextBorderStyleRoundedRect];
    [TFPNO setKeyboardType:UIKeyboardTypePhonePad];
    [TFPNO setPlaceholder:@"Eg: 1234567890"];
    [TFPNO addTarget:self action:@selector(phtextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //Auxilary Done button on numpad
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(phNoDone)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           nil];
    
    TFPNO.inputAccessoryView = numberToolbar;
    
    
    TFMail=[[UITextField alloc] initWithFrame:CGRectMake(100, 160, 200, 31)];
    [TFMail setBorderStyle:UITextBorderStyleRoundedRect];
    [TFMail setKeyboardType:UIKeyboardTypeEmailAddress];
    [TFMail setPlaceholder:@"Eg: mail@mail.com"];
    [TFMail addTarget:self action:@selector(mailtextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    TFMail.delegate=self;
    
    DOB=[[UIDatePicker alloc] init];
    [DOB setMaximumDate:[NSDate date]];
    [DOB setDatePickerMode:UIDatePickerModeDate];
    [DOB addTarget:self action:@selector(DOBChange) forControlEvents:UIControlEventValueChanged];
    
    TFDOB=[[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 31)];
    [TFDOB setBorderStyle:UITextBorderStyleRoundedRect];
    [TFDOB setInputView:DOB];
    [TFDOB addTarget:self action:@selector(TFDOBTouched) forControlEvents:UIControlEventAllTouchEvents];
    
    submit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submit setFrame:CGRectMake(120, 250, 72, 31)];
    
    if(Ipath)
    {
        NSMutableDictionary* data=[sharedmodel returnDetail:Ipath.row];
        
        [TFName setText:[data valueForKey:@"Name"]];
        TFName.enabled=FALSE;
        
        [TFPNO setText:[data valueForKey:@"PNO"]];
        [TFMail setText:[data valueForKey:@"Mail"]];
        [TFDOB setText:[data valueForKey:@"DOB"]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        [DOB setDate:[formatter dateFromString:[data valueForKey:@"DOB"]]];
        
        [submit setTitle:@"Update" forState:UIControlStateNormal];
        [submit addTarget:self
                   action:@selector(updateContact:)
         forControlEvents:UIControlEventTouchUpInside];
        
        self.title=@"Edit Contact";
    }
    else
    {
    [submit setTitle:@"Insert"
            forState:UIControlStateNormal];
    [submit addTarget:self
                   action:@selector(addContact:)
         forControlEvents:UIControlEventTouchUpInside];
        self.title=@"Add Contact";
    }
    
    [self.view addSubview:LName];
    [self.view addSubview:LPNO];
    [self.view addSubview:LMail];
    [self.view addSubview:LDOB];
    [self.view addSubview:TFName];
    [self.view addSubview:TFPNO];
    [self.view addSubview:TFMail];
    [self.view addSubview:TFDOB];
    [self.view addSubview:submit];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    TFtouch = false;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([TFName isFirstResponder] && [touch view] != TFName)
        [TFName resignFirstResponder];
    if ([TFPNO isFirstResponder] && [touch view] != TFPNO)
        [TFPNO resignFirstResponder];
    if ([TFMail isFirstResponder] && [touch view] != TFMail)
        [TFMail resignFirstResponder];
    if ([TFDOB isFirstResponder] && [touch view] != TFDOB)
    {
        [self DOBChange];
        [TFDOB resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField text].length <=0 || textField.backgroundColor == UIColor.yellowColor)
        [self invaidFormat:textField];
    else
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -
#pragma mark Local Methods

-(void) addContact:(id) sender
{
    
    if([self validate])
    {
    NSMutableDictionary *data=[[NSMutableDictionary alloc] init];
    [data setValue:[TFName text] forKey:@"Name"];
    [data setValue:[TFPNO text] forKey:@"PNO"];
    [data setValue:[TFMail text] forKey:@"Mail"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    [data setValue:[formatter stringFromDate:[DOB date] ] forKey:@"DOB"];
    
    [sharedmodel addObject:data];
    
    [_delegate itemAdded];
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) updateContact:(id) sender
{
    if([self validate])
    {
        NSMutableDictionary *data=[[NSMutableDictionary alloc] init];
        [data setValue:[TFName text] forKey:@"Name"];
        [data setValue:[TFPNO text] forKey:@"PNO"];
        [data setValue:[TFMail text] forKey:@"Mail"];
        [data setValue:[TFDOB text] forKey:@"DOB"];
        
        [sharedmodel updateObject:data
                                 :Ipath.row];
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void)DOBChange
{
    [self fieldFormatSet:TFDOB];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    TFDOB.text=[formatter stringFromDate:[DOB date]];
}

-(void)TFDOBTouched
{
   if(!TFtouch)
       TFtouch=true;
    else
    {
        TFtouch=false;
        [self DOBChange];
        [TFDOB resignFirstResponder];
    }
}

-(void)phNoDone
{
    [self textFieldShouldReturn:TFPNO];
}

#pragma mark -
#pragma mark Validation methods

-(void) nameNotEntered:(UITextField *)tf
{
    [self fieldFormatSet:tf];
    if([tf text].length <=0)
        [self invaidFormat:tf];
}

-(void)phtextFieldDidChange:(UITextField *)tf
{
    [self fieldFormatSet:tf];
    NSString *Regex = @"^[0-9+][0-9]{5,13}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    if(![test evaluateWithObject:[tf text]] || [tf text].length <=0)
        [self invaidFormat:tf];
    
}

-(void) mailtextFieldDidChange:(UITextField *)tf
{
    [self fieldFormatSet:tf];
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    if(![test evaluateWithObject:[tf text]] || [tf text].length <=0)
        [self invaidFormat:tf];
    
}


-(BOOL) validate
{
    if(TFName.backgroundColor == UIColor.yellowColor || TFPNO.backgroundColor == UIColor.yellowColor || TFMail.backgroundColor == UIColor.yellowColor || TFDOB.backgroundColor == UIColor.yellowColor)
        return FALSE;
    
    if([TFName text].length <=0)
    {
        [self invaidFormat:TFName];
        return FALSE;
    }
    if([TFPNO text].length<=0)
    {
        [self invaidFormat:TFPNO];
        return FALSE;
    }

    if([TFMail text].length <=0)
    {
        [self invaidFormat:TFMail];
        return FALSE;
    }
    
    if([TFDOB text].length <=0)
    {
        [self invaidFormat:TFDOB];
        return FALSE;
    }

    
    return TRUE;
}

#pragma mark -
#pragma mark Format setting

-(void) invaidFormat:(UITextField *)tf
{
    tf.backgroundColor= UIColor.yellowColor;
    tf.layer.borderColor=UIColor.redColor.CGColor;
    tf.layer.BorderWidth = 3;
    tf.layer.CornerRadius = 5;
}

-(void) fieldFormatSet:(UITextField *)tf
{
    if(tf.backgroundColor == UIColor.yellowColor)
    {
    tf.backgroundColor= UIColor.whiteColor;
    tf.layer.borderColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
    tf.layer.BorderWidth = 0;
    tf.layer.CornerRadius = 0;
    }
    
}

@end
