//
//  NSDate+Extension.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//
#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSString *)YYYY_MM_DD_hh_mm_ss
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	return [formatter stringFromDate:self];
}

- (NSString *)hh_mm_ss
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"HH:mm:ss"];
	return [formatter stringFromDate:self];
}

+ (NSString *)dateStringWithSecendNumberString:(NSString *)secendString
{
    int m = [secendString intValue];
    int hour   = m / 60 / 60 % 24;
    int minute = m / 60 % 60;
    int secend = m % 60;
    return [NSString stringWithFormat:@"%d:%d:%d",hour,minute, secend];
}

@end
