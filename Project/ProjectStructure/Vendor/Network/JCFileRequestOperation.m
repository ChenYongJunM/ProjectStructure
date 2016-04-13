//
//  CJFileDownloadQueue.h
//  VideoShare
//
//  Created by IOS_Doctor on 14-7-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "JCFileRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "NSFileManager+XIMAddition.h"

#define kIMRefreshProgressiveThrottle 0.01

NSString *const kIMFileServerBaseURLString = @"";

@implementation JCFileRequestOperation

+ (instancetype)_fileRequestWithRequest:(NSURLRequest *)request
                               progress:(void (^)(unsigned long long, unsigned long long))progress;
{
    JCFileRequestOperation *downloadOperation = [[JCFileRequestOperation alloc] initWithRequest:request];
    
    if (progress) {
        __block double bufSize = 0.0;
        void (^progressBlock)(NSUInteger, long long, long long) = ^(NSUInteger bytesHandled, long long totalBytesHandled, long long totalBytesExpectedToHandle) {
            bufSize += (double)bytesHandled;
            double readPercentage = bufSize / (double)totalBytesExpectedToHandle;
            
            if (readPercentage >= kIMRefreshProgressiveThrottle) {
                progress(totalBytesHandled, totalBytesExpectedToHandle);
                bufSize = 0.0;
            }
        };
        
        if ([request.HTTPMethod isEqualToString:@"POST"])
            [downloadOperation setUploadProgressBlock:progressBlock];
        else
            [downloadOperation setDownloadProgressBlock:progressBlock];
    }
    
    return downloadOperation;
}

#pragma mark - Download Request Operation

+ (instancetype)downloadRequestToMemoryWithRequest:(NSURLRequest *)request
                                      savingToPath:(NSString *)filePath
                                          progress:(void (^)(unsigned long long , unsigned long long))progress
                                           success:(void (^)(id))success
                                           failure:(void (^)(NSError *))failure
{
    JCFileRequestOperation *downloadOperation = [[self class] _fileRequestWithRequest:request progress:progress];
    
    [downloadOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseData){
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (filePath.length > 0) {
                NSFileManager *fm = [[NSFileManager alloc] init];
                [fm createFileAtPath:filePath contents:responseData intermediate:YES];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                success(responseData);
            });
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        failure(error);
    }];
    
    return downloadOperation;
}

+ (instancetype)downloadRequestToDiskWithRequest:(NSURLRequest *)request
                                    savingToPath:(NSString *)filePath
                                        progress:(void (^)(unsigned long long, unsigned long long))progress
                                        success:(void (^)(NSString *))success
                                        failure:(void (^)(NSError *))failure
{
    if (filePath.length == 0 || filePath == nil) {
        failure([NSError errorWithDomain:@"com.xbcx.error" code:1234 userInfo:nil]);
        return nil;
    }
    
    JCFileRequestOperation *downloadOperation = [[self class] _fileRequestWithRequest:request progress:progress];
    
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil intermediate:YES];
    downloadOperation.outputStream = [[NSOutputStream alloc] initToFileAtPath:filePath append:NO];
    
    [downloadOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseData){
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        // responseData will be released here
        if (success) {
            success(filePath);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        if (failure) {
            failure(error);
        }
    }];
    
    return downloadOperation;
}

- (void)start
{
    [super start];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
}

@end
