//
//  ABTDelegateFile.h
//  Addr
//
//  Created by Sharmili S on 21/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABTDelegateFile <NSObject>
@optional
-(void) itemAdded;
-(void) itemDeleted:(NSIndexPath *) path;

@end
