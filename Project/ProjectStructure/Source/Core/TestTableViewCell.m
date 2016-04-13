//
//  MainTableViewCell.m
//  StructureProject
//
//  Created by ChenYJ on 15/7/19.
//  Copyright (c) 2015年 ChenYJ. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestObj.h"

@implementation TestTableViewCell

+(CGFloat)heightWithModel:(BaseModel *)model
{
    return 65;
}

- (void)setModel:(BaseModel *)model{
    
    TestObj *obj = (TestObj *)model;
    
    _myLab.text = obj.name;
}

@end
