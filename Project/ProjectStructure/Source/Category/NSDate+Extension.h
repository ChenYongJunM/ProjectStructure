//
//  NSDate+Extension.h
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSString *)YYYY_MM_DD_hh_mm_ss;

- (NSString *)hh_mm_ss;

+ (NSString *)dateStringWithSecendNumberString:(NSString *)secendString;

@end
