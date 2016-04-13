//
//  BaseLib.h
//  BaseLib
//
//  Created by nia_wei on 14-9-11.
//  Copyright (c) 2014年 nia.wei. All rights reserved.
//

#import "Encryptor.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@implementation Encryptor

//#define DES_KEY @"20120511"
//#define MD5_KEY @"cdmp"
NSString *const ThreeDESKey = @"cncomgogotownwwwcd3desjm";
NSString *const ThreeDESIV = @"gogotown";
NSString *const MD5Secret = @"gogotown";

#pragma mark - MD5
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ] lowercaseString];
}

#pragma mark - 3DES
// 加密方法
+ (NSString*)ThreeDesEncrypt:(NSString*)plainText {
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    
    const void *vkey = (const void *) [ThreeDESKey UTF8String];
    
    const void *vinitVec = (const void *) [ThreeDESIV UTF8String];
    
    
    
    ccStatus = CCCrypt(kCCEncrypt,
                       
                       kCCAlgorithm3DES,
                       
                       kCCOptionPKCS7Padding,
                       
                       vkey,
                       
                       kCCKeySize3DES,
                       
                       vinitVec,
                       
                       vplainText,
                       
                       plainTextBufferSize,
                       
                       (void *)bufferPtr,
                       
                       bufferPtrSize,
                       
                       &movedBytes);
    
    
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    
    return result;
}


// 解密方法
+ (NSString*)ThreeDesDecrypt:(NSString*)encryptText {
    
    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    
    size_t plainTextBufferSize = [encryptData length];
    
    const void *vplainText = [encryptData bytes];
    
    
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    
    const void *vkey = (const void *) [ThreeDESKey UTF8String];
    
    const void *vinitVec = (const void *) [ThreeDESIV UTF8String];
    
    
    
    ccStatus = CCCrypt(kCCDecrypt,
                       
                       kCCAlgorithm3DES,
                       
                       kCCOptionPKCS7Padding,
                       
                       vkey,
                       
                       kCCKeySize3DES,
                       
                       vinitVec,
                       
                       vplainText,
                       
                       plainTextBufferSize,
                       
                       (void *)bufferPtr,
                       
                       bufferPtrSize,
                       
                       &movedBytes);
    
    
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    
    return result;
}

#pragma mark - DES
//+ (NSString *)DESEncryptStr:(NSString *)sTextIn
//{
//    const void *vplainText;
//    size_t plainTextBufferSize;
//    
//    NSString *urlencoded = [sTextIn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    plainTextBufferSize = [urlencoded length];
//    vplainText = (const void *) [urlencoded UTF8String];
//        
//    CCCryptorStatus ccStatus;
//    uint8_t *bufferPtr = NULL;
//    size_t bufferPtrSize = 0;
//    size_t movedBytes;
//    
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//    
//    const void *vkey = (const void *) [DES_KEY UTF8String];
//    
//    ccStatus = CCCrypt(kCCEncrypt,
//                       kCCAlgorithmDES,
//                       kCCOptionPKCS7Padding | kCCOptionECBMode,
//                       vkey,
//                       kCCKeySizeDES,
//                       NULL,
//                       vplainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
//        
//    if (ccStatus == kCCSuccess) {
//        
//        NSMutableString *sResult = [NSMutableString string];
//        for (int i=0; i<movedBytes; i++) {
//            [sResult appendFormat:@"%02X" , *(bufferPtr+i) & 0x00FF];
//        }
//      
//        NSString *returnString = [NSString stringWithString:sResult];
//        
//        free(bufferPtr);
//
//        return returnString;
//    } else {
//        switch (ccStatus) {
//            case kCCParamError:
//                NSLog(@"PARAM ERROR");
//                break;
//            case kCCBufferTooSmall:
//                NSLog(@"BUFFER TOO SMALL");
//                break;
//            case kCCMemoryFailure:
//                NSLog(@"MEMORY FAILURE");
//                break;
//            case kCCAlignmentError:
//                NSLog(@"ALIGNMENT");
//                break;
//            case kCCDecodeError:
//                NSLog(@"DECODE ERROR");
//                break;
//            case kCCUnimplemented:
//                NSLog(@"UNIMPLEMENTED");
//                break;
//            default:
//                NSLog(@"Unknown DES encrypt error");
//                break;
//        }
//        free(bufferPtr);
//        return nil;
//    }
//}
//
//+ (NSString *)md5:(NSString *)str {
////    NSString *string = [NSString stringWithFormat:@"%@%@", str, MD5_KEY];
//    
////    NSString *urlencoded = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    const char *cStr = [str UTF8String];
//    
//    unsigned char result[16]; 
//    CC_MD5( cStr, strlen(cStr), result ); 
//    return [NSString stringWithFormat: 
//            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0], result[1], result[2], result[3], 
//            result[4], result[5], result[6], result[7], 
//            result[8], result[9], result[10], result[11], 
//            result[12], result[13], result[14], result[15]
//            ]; 
//}

@end
