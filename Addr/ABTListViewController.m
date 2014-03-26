//
//  ABTListViewController.m
//  Addr
//
//  Created by Sharmili S on 20/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import "ABTListViewController.h"
#import "ABTAddViewController.h"
#import "ABTDetailedViewController.h"


@interface ABTListViewController ()

@end

@implementation ABTListViewController

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [sharedmodel returnCount];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *c = [listTable dequeueReusableCellWithIdentifier:@""];
    if (!c)
    {
        // Only allocate a new cell if none are available
        c = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:@""];
    }
    
    [[c textLabel] setText:[sharedmodel returnContactName:[indexPath row]]];
    c.accessoryType=UITableViewCellAccessoryDetailButton;
     
    return c;
}

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
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 300, 380)
                                             style:UITableViewStylePlain];
    [listTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [listTable setDataSource:self];
    [listTable setDelegate:self];
    
    scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, 300, 380)];
    
    [self.view addSubview:scroll];
    [self.view addSubview:listTable];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *Add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushsecondcontroller)];
    
    self.navigationItem.rightBarButtonItem = Add;
    
    self.title = @"Address Book";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    sharedmodel = [ABTModel sharedModel];
    
}

- (void) pushsecondcontroller
{
    ABTAddViewController* abt = [[ABTAddViewController alloc] init];
    abt.delegate=self;
    [self.navigationController pushViewController:abt animated:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) itemAdded
{
    [listTable reloadData];
}

-(void) itemDeleted:(NSIndexPath *) path
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [listTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationFade];
    });
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ABTDetailedViewController* abt = [[ABTDetailedViewController alloc] init];
    abt.delegate=self;
    [abt setIpath:indexPath];
    [self.navigationController pushViewController:abt animated:TRUE];
}

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ABTAddViewController* abt = [[ABTAddViewController alloc] init];
    [abt setIpath:indexPath];
    [self.navigationController pushViewController:abt animated:TRUE];
}

@end
