//
//  CJFileDownloadQueue.h
//  VideoShare
//
//  Created by IOS_Doctor on 14-7-29.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import <Foundation/Foundation.h>


#define FILEDOWNLOAD_PROCESS_CHANGE @"FILEDOWNLOAD_PROCESS_CHANGE"

@interface JCFileDownloadQueue : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *fileDownloadProgressDic;

- (void)cancelDownloadRequestWithKey:(NSString*)messageId;

- (void)createDownloadWithUrl:(NSString*)url savePath:(NSString*)savePath key:(NSString*)messageId;

@end
