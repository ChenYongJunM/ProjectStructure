//
//  AppDelegate.h
//  StructureProject
//
//  Created by ChenYJ on 15/7/7.
//  Copyright (c) 2015年 ChenYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)turnToLogiController;
- (void)turnToTabBarRootController;

@end

