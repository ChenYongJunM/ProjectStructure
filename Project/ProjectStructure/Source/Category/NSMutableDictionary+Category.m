//
//  NSMutableDictionary+Category.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "NSMutableDictionary+Category.h"

@implementation NSMutableDictionary (Category)
-(void)setObject:(id)object forKeyIfNotNil:(id)key{
    if (object && key) {
        [self setObject:object forKey:key];
    }
}
@end
