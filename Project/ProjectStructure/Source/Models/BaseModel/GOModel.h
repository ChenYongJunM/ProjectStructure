//
//  GOModel.h
//  MJExtensionExample
//
//  Created by nia_wei on 14-12-18.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@protocol GOKeyValue <NSObject>
@optional
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
- (NSDictionary *)goReplacedKey;

@end

@interface GOModel : NSObject <GOKeyValue>

/**
 *  根据path路径加载模型
 */
+ (id)loadFromFile:(NSString *)path;

/**
 *  存放模型到path路径
 */
- (BOOL)saveToFile:(NSString *)path;

/**
 *  根据data数据加载模型
 */
+ (id)loadFromData:(NSData *)data;

/**
 *  将model转为data
 */
- (NSData*)dataFromModel;

/**
 *  将model转为json字符串
 */
- (NSString *)keyValuesjson;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
//- (NSDictionary *)goReplacedKey __attribute__((objc_requires_super));

@end
