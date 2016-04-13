//
//  VCBaseModel.h
//  V_Cat
//
//  Created by my on 15/7/23.
//  Copyright (c) 2015年 ChenYJ. All rights reserved.
//

#import "GOModel.h"

@interface VCBaseModel : GOModel

@property(nonatomic,strong)NSString *msg;   //
@property(nonatomic,strong)NSNumber *code;  //状态
@property(nonatomic,strong)NSNumber *status;

@end
