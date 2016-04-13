//
//  CJFileDownloadQueue.h
//  VideoShare
//
//  Created by IOS_Doctor on 14-7-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "JCFileDownloadQueue.h"
#import "JCFileRequestOperation.h"
#import "NSFileManager+XIMAddition.h"

@interface JCFileDownloadQueue()

@property (nonatomic, strong) NSMutableDictionary *fileDownloadRequestDic;
@property (nonatomic, strong) NSMutableDictionary *fileDownloadProgressDic;

@end

@implementation JCFileDownloadQueue

- (void)dealloc
{
    for (int i = 0; i < self.fileDownloadRequestDic.allKeys.count; ++i) {
        JCFileRequestOperation *request = [self.fileDownloadRequestDic objectForKey:[self.fileDownloadRequestDic.allKeys objectAtIndex:i]];
        [request cancel];
    }
    
}

- (void)createDownloadWithUrl:(NSString*)url savePath:(NSString*)savePath key:(NSString*)messageId
{
    if (self.fileDownloadRequestDic == nil) {
        self.fileDownloadRequestDic = [NSMutableDictionary dictionary];
        self.fileDownloadProgressDic = [NSMutableDictionary dictionary];
    }
    
    JCFileRequestOperation *request = [self.fileDownloadRequestDic objectForKey:messageId];
    if (request) {
        return;
    }
    NSString *dirPath = [savePath stringByDeletingLastPathComponent];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:dirPath]) {
        [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fm addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:dirPath]];
    }
    request = [JCFileRequestOperation downloadRequestToDiskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] savingToPath:savePath progress:^(unsigned long long bytesRead, unsigned long long totalBytes) {
        [self.fileDownloadProgressDic setObject:@{@"current": @(bytesRead), @"total": @(totalBytes), @"key": messageId} forKey:messageId];
        [[NSNotificationCenter defaultCenter] postNotificationName:FILEDOWNLOAD_PROCESS_CHANGE object:nil userInfo:self.fileDownloadProgressDic[messageId]];
    } success:^(NSString *filePath) {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *dirPath = [filePath stringByDeletingLastPathComponent];
        if (![fm fileExistsAtPath:dirPath]) {
            [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![fm fileExistsAtPath:filePath]) {
            [fm createFileAtPath:filePath contents:[NSData data] attributes:nil];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:FILEDOWNLOAD_PROCESS_CHANGE object:nil userInfo:@{@"current": @(100), @"total": @(100), @"key": messageId}];
        [self.fileDownloadRequestDic removeObjectForKey:messageId];
        [self.fileDownloadProgressDic removeObjectForKey:messageId];
    } failure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FILEDOWNLOAD_PROCESS_CHANGE object:nil userInfo:@{@"key": messageId}];
        [self.fileDownloadRequestDic removeObjectForKey:messageId];
        [self.fileDownloadProgressDic removeObjectForKey:messageId];
    }];
    [self.fileDownloadRequestDic setObject:request forKey:messageId];
    [request start];
}

- (void)cancelDownloadRequestWithKey:(NSString*)messageId
{
    JCFileRequestOperation *request = [self.fileDownloadRequestDic objectForKey:messageId];
    if (![request isFinished]) {
//        [request clearDelegatesAndCancel];
        [request cancel];
    }
    [self.fileDownloadRequestDic removeObjectForKey:messageId];
}


@end
