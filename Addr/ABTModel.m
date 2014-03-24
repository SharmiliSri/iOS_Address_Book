//
//  ABTModel.m
//  Addr
//
//  Created by Sharmili S on 21/03/14.
//  Copyright (c) 2014 Sharmili S. All rights reserved.
//

#import "ABTModel.h"

@implementation ABTModel
@synthesize docPath;

+(id) sharedModel
{
    static ABTModel *sharedModel = nil;
    @synchronized(self) {
        if (sharedModel == nil)
            sharedModel = [[self alloc] init];
    }
    return sharedModel;
}

- (id)init {
    if (self = [super init])
    {
        NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                NSUserDomainMask, YES);
        docPath= [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"contacts.td"];
        
        NSArray *plist = [NSArray arrayWithContentsOfFile:docPath];
        if (plist)
            contactList = [plist mutableCopy];
        else
            contactList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSString*) returnContactName:(NSInteger) index
{
    NSMutableDictionary *item = [contactList objectAtIndex:index];
    if(item)
        return [item valueForKey:@"Name"];
    else
        return @"No contacts yet";
}

-(NSInteger) returnCount
{
    return [contactList count];
}

-(void) addObject:(NSMutableDictionary*) data
{
    [contactList addObject:data];
    [contactList writeToFile:docPath atomically:YES];
}

-(NSMutableDictionary*) returnDetail:(NSInteger) row
{
    return [contactList objectAtIndex:row];
}

-(void) delObject:(NSInteger) row
{
    [contactList removeObjectAtIndex:row];
    [contactList writeToFile:docPath atomically:YES];
}
@end
