//
//  BaseLib.h
//  BaseLib
//
//  Created by nia_wei on 14-9-11.
//  Copyright (c) 2014年 nia.wei. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const MD5Secret;

@interface Encryptor : NSObject

+ (NSString*)md5:(NSString*)str;
+ (NSString*)ThreeDesEncrypt:(NSString*)plainText;
+ (NSString*)ThreeDesDecrypt:(NSString*)encryptText;
//+ (NSString*)DESEncryptStr:(NSString*)sTextIn;

@end
