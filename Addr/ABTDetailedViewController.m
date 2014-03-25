//
//  ABTDetailedViewController.m
//  Addr
//
//  Created by Sharmili S on 24/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import "ABTDetailedViewController.h"

@interface ABTDetailedViewController ()

@end

@implementation ABTDetailedViewController

@synthesize Ipath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadView
{
    [super loadView];
    
    sharedmodel = [ABTModel sharedModel];
    
    NSMutableDictionary* data=[sharedmodel returnDetail:Ipath.row];
    Lname=[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 500, 50)];
    [Lname setText:[NSString stringWithFormat:@"Name: %@",[data valueForKey:@"Name"]]];
    Lphone=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 500, 50)];
    [Lphone setText:[NSString stringWithFormat:@"Phone: %@",[data valueForKey:@"PNO"]]];
    Lmail=[[UILabel alloc] initWithFrame:CGRectMake(20, 160, 500, 50)];
    [Lmail setText:[NSString stringWithFormat:@"Mail: %@",[data valueForKey:@"Mail"]]];
    Ldob=[[UILabel alloc] initWithFrame:CGRectMake(20, 200, 500, 50)];
    [Ldob setText:[NSString stringWithFormat:@"DOB: %@",[data valueForKey:@"DOB"]]];
    
    [self.view addSubview:Lname];
    [self.view addSubview:Lphone];
    [self.view addSubview:Lmail];
    [self.view addSubview:Ldob];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *Del = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delChosen)];
    
    self.navigationItem.rightBarButtonItem = Del;
    self.title = @"Detailed View";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pushrootcontroller
{
    [sharedmodel delObject:Ipath.row];
    
    [_delegate itemDeleted:Ipath];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) delChosen
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deletion Initiated"
                                                    message:@"Are you sure to delete the item?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
   if(buttonIndex == [alertView firstOtherButtonIndex])
       [self pushrootcontroller];
}

@end
