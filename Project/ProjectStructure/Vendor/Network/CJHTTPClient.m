//
//  CJFileDownloadQueue.h
//  VideoShare
//
//  Created by IOS_Doctor on 14-7-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "CJHTTPClient.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "JCFileRequestOperation.h"
#import "JSON.h"


#define TIMEOUT 1.0
NSString *const XIMHTTPClientErrorDomain = @"com.xbcx.im.http.error";

@implementation CJHTTPClient

+ (instancetype)sharedClient
{
    static dispatch_once_t once;
    static CJHTTPClient *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[[self class] alloc] init];
    });
    return __singleton__;
}

+ (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
	if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
		return nil;
	}
	// Borrowed from http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
	CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
	if (!MIMEType) {
		return @"application/octet-stream";
	}
    return (__bridge NSString *)MIMEType;
}

#pragma mark - Override from super.

- (instancetype)init
{
    if (self = [super init]) {
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.readingOptions = NSJSONReadingAllowFragments | NSJSONReadingMutableContainers;
        self.responseSerializer = responseSerializer;
        
        self.timeoutTime = 0.1;
    }
    return self;
}

- (void)setTimeoutTime:(NSTimeInterval)timeoutTime
{
    _timeoutTime = timeoutTime;
    self.requestSerializer.timeoutInterval = _timeoutTime;
}

+ (NSMutableDictionary*)httpHederDic
{
    NSString *ggToken = [[VCCDataHelper sharedInstance] user].token;
    NSLog(@"token---%@---",ggToken);
    return [@{@"token":ggToken} mutableCopy];
}


#pragma mark - Inherited Methods
- (AFHTTPRequestOperation *)GETImageWithURL:(NSURL *)url targetPath:(NSString *)targetPath inMemoryData:(BOOL)inMemoryData progress:(XBOSSProgressBlock)progress success:(XBOSSGETSucessBlock)success failure:(XBOSSFailureBlock)failure {
    
    NSError *error = nil;
    if (targetPath.length == 0 && !inMemoryData) {
        error = [NSError errorWithDomain:@"CJHTTPClient.m"
                                    code:0000
                                userInfo:@{@"description": @"targetPath cannot be nil when do streaming fetching."}];
        if (failure) {
            failure(error);
        }
        return nil;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[UIImage class]]) {
            UIImage *data = responseObject;
            if (targetPath.length) {
                NSFileManager *fm = [NSFileManager defaultManager];
                NSString *dirPath = [targetPath stringByDeletingLastPathComponent];
                if (![fm fileExistsAtPath:dirPath]) {
                    [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
                }
                [fm createFileAtPath:targetPath contents:UIImageJPEGRepresentation(data, 1) attributes:nil];
            }
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(targetPath, UIImageJPEGRepresentation(data, 1));
                });
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                success(targetPath, responseObject);
            });
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    if (progress) {
        [requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalRead, long long total){
            progress(totalRead, total);
        }];
    }
    
    [requestOperation start];
    return requestOperation;
}


//**
//      code : 200
//      code : 400  msg 传出
//      code : 500  msg = @"服务器错误";
//      code : 401  到登陆界面
/**/




#pragma mark - Inherited Methods

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    //**拼接URL参数*/
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = TIMEOUT;
    
    //** here need set request head.*/
    [request setAllHTTPHeaderFields:[[self class] httpHederDic]];
    NSLog(@"\n=======Request_get===:%@\n" , URLString);
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];

        if (success) {
            success(operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
    [self.operationQueue addOperation:operation];
    return operation;
}


//MARK: 字典转string
-(NSString *)JsonDataBy:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return string;
    }else{
        return nil;
    }
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:URLString];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = TIMEOUT;
    
    NSString *jsonParam = [NSString stringWithFormat:@"params=%@",[self JsonDataBy:parameters]];
    request.HTTPBody   = [jsonParam dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //** here need set request head.*/
    [request setAllHTTPHeaderFields:[[self class] httpHederDic]];
    NSLog(@"\n=======Request_post===:%@\n" , URLString);
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        if (success) {
            success(operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end
