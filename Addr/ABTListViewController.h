//
//  ABTListViewController.h
//  Addr
//
//  Created by Sharmili S on 20/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTModel.h"
#import "ABTDelegateFile.h"

@interface ABTListViewController : UIViewController <UITableViewDataSource,ABTDelegateFile,UITableViewDelegate>
{
    UITableView *listTable;
    UIScrollView *scroll;
    
    ABTModel *sharedmodel;
}
- (void) pushsecondcontroller;

@end
