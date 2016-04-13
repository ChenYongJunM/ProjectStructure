//
//  GOModel.m
//  MJExtensionExample
//
//  Created by nia_wei on 14-12-18.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GOModel.h"
#import "NSObject+SBJson.h"

@implementation GOModel

/**
 *  归档实现
 */
MJCodingImplementation

+ (id)loadFromFile:(NSString *)path
{
    id obj = nil;
    @try {
        obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *exception) {
        obj = nil;
        NSLog(@"Exception : %@", exception);
    }
    @finally {
        
    }
    return obj;
}

- (BOOL)saveToFile:(NSString *)path
{
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (id)loadFromData:(NSData *)data
{
    id obj = nil;
    @try {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
        obj = nil;
        NSLog(@"Exception : %@", exception);
    }
    @finally {
        
    }
    return obj;
}

- (NSData *)dataFromModel
{
    id obj = nil;
    @try {
        obj = [NSKeyedArchiver archivedDataWithRootObject:self];
    }
    @catch (NSException *exception) {
        obj = nil;
        NSLog(@"Exception : %@", exception);
    }
    @finally {
        
    }
    return obj;
}

- (NSString *)keyValuesjson
{
    NSDictionary *obj = [self keyValues];
    return [obj JSONRepresentation];
}

#pragma mark @protocol MJKeyValue
- (NSDictionary *)replacedKeyFromPropertyName
{
    NSMutableDictionary *result = [NSMutableDictionary new];
    if ([self respondsToSelector:@selector(goReplacedKey)]) {
        [result setValuesForKeysWithDictionary:[self goReplacedKey]];
    }
    //
    [result setValuesForKeysWithDictionary:@{@"base_id":@"id" , @"base_description":@"description" ,@"base_id":@"base_id",@"base_description":@"description",@"base_new_message_count":@"new_message_count",@"new_message_count":@"base_new_message_count",}];
    return result;
}

@end
