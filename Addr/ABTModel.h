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
-(void) addObject:(NSMutableDictionary*) data;
-(void) delObject:(NSInteger) row;
-(void) updateObject:(NSMutableDictionary*) data
                    :(NSInteger) row;
-(NSInteger) returnCount;
-(NSString*) returnContactName:(NSInteger) index;
-(NSMutableDictionary*) returnDetail:(NSInteger) row;

@end
