//
//  CJFileDownloadQueue.h
//  VideoShare
//
//  Created by IOS_Doctor on 14-7-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface JCFileRequestOperation : AFHTTPRequestOperation

#pragma mark - Download Request Operation
/** this method will fetch data from server to memory as well as saving it to local disk filePath(can be nil).
 */
+ (instancetype)downloadRequestToMemoryWithRequest:(NSURLRequest *)request
                                      savingToPath:(NSString *)filePath
                                          progress:(void (^)(unsigned long long bytesRead, unsigned long long totalBytes))progress
                                           success:(void (^)(id responseData))success
                                           failure:(void (^)(NSError *error))failure;

/** this method will establish a stream from server to local disk, so the callback block won't have memory data.
 */

+ (instancetype)downloadRequestToDiskWithRequest:(NSURLRequest *)request
                                    savingToPath:(NSString *)filePath
                                        progress:(void (^)(unsigned long long bytesRead, unsigned long long totalBytes))progress
                                         success:(void (^)(NSString * filePath))success
                                         failure:(void (^)(NSError *))failure;

@end
