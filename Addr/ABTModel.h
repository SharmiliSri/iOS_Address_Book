//
//  ABTModel.h
//  Addr
//
//  Created by Sharmili S on 21/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTModel : NSObject
{
    NSString *docPath;
    NSMutableArray *contactList;
}

@property (nonatomic,readonly) NSString *docPath;
//@property (nonatomic, readonly)NSMutableArray *contactList;

+(id) sharedModel;
-(NSInteger) returnCount;
-(NSString*) returnContactName:(NSInteger) index;
-(void) addObject:(NSMutableDictionary*) data;
-(void) delObject:(NSInteger) row;
-(NSMutableDictionary*) returnDetail:(NSInteger) row;

@end
