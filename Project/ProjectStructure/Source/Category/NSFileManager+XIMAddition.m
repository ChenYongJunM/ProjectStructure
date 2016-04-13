//
//  NSFileManager+XIMAdditions.h
//  VideoShare
//
//  Created by IOS_Doctor on 13-7-23.
//  Copyright (c) 2013年 juche. All rights reserved.
//

#import "NSFileManager+XIMAddition.h"
#import <sys/xattr.h>

@implementation NSFileManager (XIMAddition)

- (NSString *)cacheDirectory
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths[0];
}

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

- (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data intermediate:(BOOL)intermediate
{
    if (path.length == 0) return NO;
    
    NSString *dirPath = [path stringByDeletingLastPathComponent];
    if (intermediate && [self fileExistsAtPath:dirPath] == NO) {
        [self createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL success = [self createFileAtPath:path contents:data attributes:nil];
    [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
    return success;
}

- (BOOL)createDirectoryAtPath:(NSString *)path intermediate:(BOOL)intermediate
{
    if (![self fileExistsAtPath:path])
        return [self createDirectoryAtPath:path withIntermediateDirectories:intermediate attributes:nil error:nil];
    return YES;
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)url
{
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    return error == nil;
}

@end
