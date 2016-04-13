//
//  XBVSTextField.m
//  StructureProject
//
//  Created by ChenYJ on 14/5/20.
//  Copyright (c) 2014年 ChenYJ. All rights reserved.
//

#import "XBVSTextField.h"

@implementation XBVSTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Override Super.

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [RGB(45, 45, 45) setFill];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        rect.origin.y = rect.origin.y + (self.height - 16) / 2;
    }
    else{
        rect.origin.y = rect.origin.y + 2;
    }
    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]}];
}

@end
