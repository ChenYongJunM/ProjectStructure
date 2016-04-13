//
//  CJFileDownloadQueue.h
//  VideoShare
//
//  Created by IOS_Doctor on 14-7-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "COHTTPConfigure.h"

typedef void (^XIMHTTPClientSuccessBlock)(id responseObject);
typedef void (^XIMHTTPClientFailureBlock)(NSError *error);
typedef void (^XIMHTTPClientProgressBlock)(unsigned long long loadedSize, unsigned long long totalSize);

FOUNDATION_EXPORT NSString *const XIMHTTPClientErrorDomain;

/** By using GET:paramters:success:failure and POST:paramters:success:failure, you can easily
 *  subclass XIMHTTPClient and implement your own web APIs calls.
 */
@interface CJHTTPClient : AFHTTPRequestOperationManager

@property (nonatomic, assign) NSTimeInterval timeoutTime;

+ (instancetype)sharedClient;


- (AFHTTPRequestOperation *)GETImageWithURL:(NSURL *)url
                                 targetPath:(NSString *)targetPath
                               inMemoryData:(BOOL)inMemoryData
                                   progress:(XBOSSProgressBlock)progress
                                    success:(XBOSSGETSucessBlock)success
                                    failure:(XBOSSFailureBlock)failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
