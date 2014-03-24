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
    
    TFPNO=[[UITextField alloc] initWithFrame:CGRectMake(100, 120, 200, 31)];
    [TFPNO setBorderStyle:UITextBorderStyleRoundedRect];
    [TFPNO setPlaceholder:@"Eg: +911234567890"];
    
    TFMail=[[UITextField alloc] initWithFrame:CGRectMake(100, 160, 200, 31)];
    [TFMail setBorderStyle:UITextBorderStyleRoundedRect];
    [TFMail setPlaceholder:@"Eg: mail@mail.com"];
    
    TFDOB=[[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 31)];
    [TFDOB setBorderStyle:UITextBorderStyleRoundedRect];
    [TFDOB setPlaceholder:@"Eg: DD/MM/YYYY"];
    
    submit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submit setFrame:CGRectMake(120, 240, 72, 31)];
    [submit addTarget:self
               action:@selector(addContact:)
     forControlEvents:UIControlEventTouchUpInside];
    [submit setTitle:@"Insert"
            forState:UIControlStateNormal];
    
    [self.view addSubview:LName];
    [self.view addSubview:LPNO];
    [self.view addSubview:LMail];
    [self.view addSubview:LDOB];
    [self.view addSubview:TFName];
    [self.view addSubview:TFPNO];
    [self.view addSubview:TFMail];
    [self.view addSubview:TFDOB];
    [self.view addSubview:submit];
    
    self.title=@"Add Contact";
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    sharedmodel = [ABTModel sharedModel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addContact:(id) sender
{
    
    if([self validate])
    {
    NSMutableDictionary *data=[[NSMutableDictionary alloc] init];
    [data setValue:[TFName text] forKey:@"Name"];
    [data setValue:[TFPNO text] forKey:@"PNO"];
    [data setValue:[TFMail text] forKey:@"Mail"];
    [data setValue:[TFDOB text] forKey:@"DOB"];
    
    [sharedmodel addObject:data];
    
    [_delegate itemAdded];
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL) validate
{
    [self fieldFormatSet];
    if([TFName text].length <=0)
    {
        [self invaidFormat:TFName];
        return FALSE;
    }
    
    NSString *Regex;
    NSPredicate *test;
    
   Regex = @"^((\\+)|(00))[0-9]{6,14}$";
   test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
   if(![test evaluateWithObject:[TFPNO text]] || [TFPNO text].length <=0)
   {
       [self invaidFormat:TFPNO];
        return FALSE;
   }
    
    Regex=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    if(![test evaluateWithObject:[TFMail text]] || [TFMail text].length <=0)
    {
        [self invaidFormat:TFMail];
        return FALSE;
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setDateFormat:@"dd/MM/yyyy"];
    NSDate *validateDOB = [format dateFromString:[TFDOB text]];
    if (validateDOB == nil)
    {
        [self invaidFormat:TFDOB];
        return FALSE;
    }
    
    return TRUE;
}

-(void) invaidFormat:(UITextField *)tf
{
    tf.backgroundColor= UIColor.yellowColor;
    tf.layer.borderColor=UIColor.redColor.CGColor;
    tf.layer.BorderWidth = 3;
    tf.layer.CornerRadius = 5;
}

-(void) fieldFormatSet
{
    if(TFName.backgroundColor == UIColor.yellowColor)
    {
    TFName.backgroundColor= UIColor.whiteColor;
    TFName.layer.borderColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
    TFName.layer.BorderWidth = 0;
    TFName.layer.CornerRadius = 0;
    }
    
    if(TFPNO.backgroundColor == UIColor.yellowColor)
    {
        TFPNO.backgroundColor= UIColor.clearColor;
        TFPNO.layer.borderColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        TFPNO.layer.BorderWidth = 0;
        TFPNO.layer.CornerRadius = 0;
    }
    
    if(TFMail.backgroundColor == UIColor.yellowColor)
    {
        TFMail.backgroundColor= UIColor.whiteColor;
        TFMail.layer.borderColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        TFMail.layer.BorderWidth = 0;
        TFMail.layer.CornerRadius = 0;
    }
    
    if(TFDOB.backgroundColor == UIColor.yellowColor)
    {
        TFDOB.backgroundColor= UIColor.whiteColor;
        TFDOB.layer.borderColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        TFDOB.layer.BorderWidth = 0;
        TFDOB.layer.CornerRadius = 0;
    }
    
}

@end
