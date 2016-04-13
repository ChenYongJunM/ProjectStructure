//
//  NSMutableDictionary+Category.h
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Category)
//将一个元素加入dictionary
-(void)setObject:(id)object forKeyIfNotNil:(id)key;
@end
