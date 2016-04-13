//
//  COHTTPConfigure.m
//  Cooking
//
//  Created by iOS_Doctor on 14-9-10.
//  Copyright (c) 2014年 ___GoGo___. All rights reserved.
//

#import "COHTTPConfigure.h"

@implementation COHTTPConfigure

+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    static COHTTPConfigure *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[[self class] alloc] init];
    });
    return __singleton__;
}

@end
