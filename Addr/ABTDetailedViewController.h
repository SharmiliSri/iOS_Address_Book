//
//  ABTDetailedViewController.h
//  Addr
//
//  Created by Sharmili S on 24/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTModel.h"
#import "ABTDelegateFile.h"

@interface ABTDetailedViewController : UIViewController<UIAlertViewDelegate>
{
    NSIndexPath *Ipath;
    UILabel *Lname,*Lphone,*Lmail,*Ldob;
    
    ABTModel *sharedmodel;
}

@property (nonatomic,assign) id <ABTDelegateFile> delegate;
@property NSIndexPath *Ipath;
-(void) pushrootcontroller;

@end
