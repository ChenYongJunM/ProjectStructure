//
//  VCTRootTabController.m
//  vcat
//
//  Created by xyx on 15-5-5.
//  Copyright (c) 2015年 vcat. All rights reserved.
//

#import "VCRootTabController.h"

@interface VCRootTabController()
{
    UIView *newView;
}
@end

@implementation VCRootTabController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setTintColor:VCT_COLOR_RED_NAVIGATION];
    
    [[UITabBarItem appearance]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName, nil]
     forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:VCT_COLOR_RED_NAVIGATION, NSForegroundColorAttributeName, nil]
     forState:UIControlStateSelected];
    
    NSDictionary* textAttributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.f] forKey:NSFontAttributeName];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];

}

@end
