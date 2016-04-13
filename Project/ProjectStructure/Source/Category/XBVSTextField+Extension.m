//
//  XBVSTextField+Extension.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "XBVSTextField+Extension.h"

@implementation XBVSTextField (Extension)

- (BOOL)textIsNumbers
{
    NSString *regex = @"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self.text];
}

@end
